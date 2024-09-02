// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/convert_image_component.dart';
import '../data/models/base_64_model.dart';
import '../data/models/create_item_model.dart';
import '../data/models/file_temp_model.dart';
import '../data/services/temp_service.dart';
import '../data/services/vote_service.dart';
import '../ui/utils/storage_keys.dart';
import 'mfp_vote_create_item_controller.dart';

class MfpVoteCreateViewController extends GetxController {
  final _service = VoteService();
  final _box = GetStorage();

  final CreateItemModel data = Get.arguments['DATA'];

  var createItemModel = CreateItemModel().obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print('scroll to end');
      }
    });
    createItemModel.value = data;
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<FileTempModel> createFileTemp(String filePath) async {
    if (filePath.isEmpty) return FileTempModel();

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

      return FileTempModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'createFileTemp');
      return FileTempModel();
    }
  }

  void back() {
    print('back');
    MfpVoteCreateItemController createItemController = Get.put(MfpVoteCreateItemController());

    createItemController.createItemModel.value.voteItem!.removeLast();
    createItemController.createItemModel.refresh();

    // createItemController.voteChoiceType.value =
    //     createItemController.createItemModel.value.voteItem!.first.typeChoice == 'single'
    //         ? VoteChoiceType.single
    //         : createItemController.createItemModel.value.voteItem!.first.typeChoice == 'multiple'
    //             ? VoteChoiceType.multiple
    //             : VoteChoiceType.text;
    // createItemController.voteChoiceType.refresh();
  }

  Future<bool> fetchCreateVote() async {
    String token = _box.read(StorageKeys.token) ?? '';
    String uid = _box.read(StorageKeys.uid) ?? '';
    String mode = _box.read(StorageKeys.mode) ?? '';

    Response response = await _service.createVoteAsUser(
      token: token,
      uid: uid,
      mode: mode,
      createItemModel: createItemModel.value,
    );

    return response.status.hasError ? false : true;
  }
}
