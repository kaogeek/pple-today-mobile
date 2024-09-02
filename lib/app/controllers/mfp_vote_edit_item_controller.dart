// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/convert_image_component.dart';
import '../component/my_dialog.dart';
import '../data/models/base_64_model.dart';
import '../data/models/edit_vote_item_model.dart';
import '../data/models/file_temp_model.dart';
import '../data/services/temp_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteEditItemController extends GetxController {
  final _box = GetStorage();

  final EditVoteItemModel _data = Get.arguments['DATA'];
  final int index = Get.arguments['INDEX'];
  // final bool isEdit = Get.arguments['IS_EDIT'] ?? false;

  Rx<File> coverPhoto = File('').obs;
  var editItemModel = EditVoteItemModel().obs;
  var voteItemModel = RxList<VoteItem>();
  var voteChoiceModel = RxList<VoteChoice>();
  var deleteChoices = RxList<String>();

  @override
  void onInit() {
    Log.print('index: $index');
    editItemModel.value = _data;
    // editItemModel.value = EditVoteItemModel.fromJson(_data.toJson());

    editItemModel.update((val) {
      val!.voteItem![index].controller = TextEditingController(text: _data.voteItem![index].title!);
      // val.voteItem![index].voteChoice!.forEach((element) {
      //   element.controller = TextEditingController(text: element.title);
      // });
    });

    voteItemModel.addAll(_data.voteItem ?? []);
    // voteItemModel.value = _data.voteItem ?? [];

    voteChoiceModel.value = (_data.voteItem![index].voteChoice ?? []).map((e) => e.toJson()).toList().map((e) => VoteChoice.fromJson(e)).toList();
    // voteChoiceModel.addAll(_data.voteItem![index].voteChoice ?? []);
    // voteChoiceModel.value = _data.voteItem![index].voteChoice ?? [];

    voteChoiceModel.forEach((element) {
      element.controller = TextEditingController(text: element.title);
    });
    super.onInit();
  }

  @override
  void onClose() {
    coverPhoto.value = File('');
    try {
      editItemModel.update((val) {
        val!.voteItem![index].file = File('');
      });
      voteItemModel.close();
      voteChoiceModel.close();
      deleteChoices.close();
    } catch (e) {
      // log('', error: e, name: 'onClose');
    }
    Log.print('onClose MfpVoteEditItemController');
    super.onClose();
  }

  Future<void> onBack() async {
    FocusScope.of(Get.context!).unfocus();

    await MyDialog.defaultDialog(
      title: 'คุณต้องการยกเลิกการแก้ไขโหวต?',
      content: 'ข้อมูลที่คุณแก้ไขจะกลับเป็นค่าเดิม',
      textConfirm: 'ตกลง',
      textCancel: 'ยกเลิก',
      onConfirm: () {
        if (Get.isDialogOpen ?? false) Get.back();
        if (Get.currentRoute == AppRoutes.MFP_VOTE_EDIT_ITEM) {
          Get.back(result: null);
        }
      },
    );
    return;
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
}
