import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mfp_app/app/component/convert_image_component.dart';

import '../data/models/base_64_model.dart';
import '../data/models/create_item_model.dart';
import '../data/models/file_temp_model.dart' as t;
import '../data/models/user_access_page_model.dart' as u;
import '../data/models/vote_hash_tag_model.dart';
import '../data/services/temp_service.dart';
import '../data/services/user_service.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteCreateController extends GetxController {
  final _voteService = VoteService();
  final _userService = UserService();
  final _box = GetStorage();

  final now = DateTime.now();

  var createItemModel = CreateItemModel().obs;
  var voteHashTagModel = VoteHashTagModel().obs;
  var userAccessPageModel = u.UserAccessPageModel().obs;
  var indexPage = 0.obs;
  var coverPhoto = File('').obs;
  var type = 'member'.obs;
  var showVoteName = false.obs;
  var showVoteResult = false.obs;
  var startDate = Rx<DateTime?>(null);
  var endDate = Rx<DateTime?>(null);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController hashTagController = TextEditingController();
  TextEditingController openVoteController = TextEditingController(text: '7');

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode hashTagFocusNode = FocusNode();
  FocusNode openVoteFocusNode = FocusNode();

  @override
  void onInit() {
    fetchUserAccessPage();
    fetchGetHashTagList();
    startDate.value = DateTime(
      now.year,
      now.month,
      now.day,
      0,
      0,
    );
    endDate.value = now.add(Duration(
      days: 15,
      hours: ((now.hour - 23) - (now.hour - 23)) - (now.hour - 23),
      minutes: ((now.minute - 59) - (now.minute - 59)) - (now.minute - 59),
    ));
    super.onInit();
  }

  Future<void> fetchUserAccessPage() async {
    String token = _box.read(StorageKeys.token) ?? '';
    if (token.isEmpty) return;

    String uid = _box.read(StorageKeys.uid) ?? '';

    String mode = _box.read(StorageKeys.mode) ?? '';

    try {
      Response response = await _userService.getUserAccessPage(
        uid: uid,
        token: token,
        mode: mode,
      );

      if (response.hasError || response.body['status'] == 0) {
        throw Exception(response.statusText);
      }

      final model = u.UserAccessPageModel.fromJson(response.body);

      userAccessPageModel(model);
    } catch (e) {
      log('', error: e, name: 'FetchUserAccessPage');
    } finally {
      // TODO: แก้ไขตอนเลือกหน้า

      String imageURL = _box.read(StorageKeys.imageURL) ?? '';
      String displayName = _box.read(StorageKeys.displayName) ?? '';

      userAccessPageModel.value.data!.insert(
        0,
        u.Data(
          page: u.Page(
            id: uid,
            name: displayName,
            imageUrl: imageURL,
          ),
        ),
      );
    }

    return;
  }

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

  Future<t.FileTempModel> createFileTemp() async {
    if (coverPhoto.value.path.isEmpty) return t.FileTempModel();

    try {
      Base64Model base64Model = await ConvertImageComponent.imageFileToBase64(File(coverPhoto.value.path));

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
