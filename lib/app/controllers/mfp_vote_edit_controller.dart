import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/convert_image_component.dart';
import '../data/models/base_64_model.dart';
import '../data/models/edit_vote_item_model.dart';
import '../data/models/file_temp_model.dart' as t;
import '../data/models/vote_choice_model.dart';
import '../data/models/vote_hash_tag_model.dart';
import '../data/services/temp_service.dart';
import '../data/services/user_service.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteEditController extends GetxController {
  final _voteService = VoteService();
  final _userService = UserService();
  final _box = GetStorage();
  final _now = DateTime.now();

  final _data = Get.arguments['DATA'] as EditVoteItemModel;

  // var coverPhoto = File('').obs;

  var type = 'member'.obs;
  var showVoteName = false.obs;
  var showVoteResult = false.obs;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController hashTagController;
  late TextEditingController openVoteController;

  var editVoteItemModel = EditVoteItemModel().obs;
  var voteHashTagModel = VoteHashTagModel().obs;
  var voteChoiceModel = VoteChoiceModel().obs;

  @override
  void onInit() {
    Log.print('VOTE_ID: ${_data.id}');

    editVoteItemModel.value = _data;

    titleController = TextEditingController(text: _data.title);
    descriptionController = TextEditingController(text: _data.detail);
    hashTagController = TextEditingController(text: _data.hashTag);
    openVoteController = TextEditingController(text: (_data.voteDaysRange ?? 7).toString());

    showVoteResult.value = _data.showVoteResult ?? false;
    showVoteName.value = _data.showVoteName ?? false;

    fetchGetHashTagList();
    super.onInit();
  }

  @override
  void onReady() {
    fetchGetVoting();
    super.onReady();
  }

  // @override
  // void onClose() {
  //   // data.close();
  //   titleController.dispose();
  //   descriptionController.dispose();
  //   hashTagController.dispose();
  //   openVoteController.dispose();

  //   super.onClose();
  // }

  Future<void> fetchGetHashTagList() async {
    try {
      Response response = await _voteService.getVoteHashTagList();

      if (response.hasError || response.body['status'] == 0) {
        throw Exception(response.statusText);
      }

      final model = VoteHashTagModel.fromJson(response.body);

      voteHashTagModel(model);
    } catch (e) {
      log('', error: e, name: 'FetchUserAccessPage');
    }

    return;
  }

  Future<void> fetchGetVoting() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _voteService.getVoting(
        voteId: _data.id!,
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError) throw Exception(response.statusText ?? 'Error');

      final model = VoteChoiceModel.fromJson(response.body);

      if (model.status == 0) throw Exception(model.message ?? 'Error');

      if ((model.data!.voteItem ?? []).isNotEmpty) {
        /// sort ordering
        model.data!.voteItem!.sort((a, b) => a.ordering!.compareTo(b.ordering!));

        voteChoiceModel(model);
      } else {
        // TODO: No data
      }
    } catch (e) {
      log('', error: e, name: 'fetchGetVoteChoice');
      // TODO catch error
    }

    voteChoiceModel.refresh();
    return;
  }

  Future<t.FileTempModel> createFileTemp(String filePath) async {
    if (filePath.isEmpty) return t.FileTempModel();

    try {
      Base64Model base64Model = await ConvertImageComponent.imageFileToBase64(File(filePath));

      String token = _box.read(StorageKeys.token) ?? '';
      String uid = _box.read(StorageKeys.uid) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await TempService().postFileTemp(
        base64Model: base64Model,
        mode: mode,
        token: token,
        userId: uid,
      );

      if (response.hasError || response.body['status'] == 0) {
        throw Exception(response.statusText);
      }

      return t.FileTempModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'createFileTemp');
      return t.FileTempModel();
    }
  }
}
