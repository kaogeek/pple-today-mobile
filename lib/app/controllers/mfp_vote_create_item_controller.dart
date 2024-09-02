// ignore_for_file: invalid_use_of_protected_member, avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/convert_image_component.dart';
import '../component/my_dialog.dart';
import '../data/models/base_64_model.dart';
import '../data/models/create_item_model.dart';
import '../data/models/file_temp_model.dart';
import '../data/services/temp_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/log.dart';
import '../ui/utils/storage_keys.dart';

class MfpVoteCreateItemController extends GetxController {
  final _box = GetStorage();

  final CreateItemModel _data = Get.arguments['DATA'];
  final int index = Get.arguments['INDEX'];
  final bool isEdit = Get.arguments['IS_EDIT'] ?? false;

  Rx<File> coverPhoto = File('').obs;
  var createItemModel = CreateItemModel().obs;
  var voteItemModel = RxList<VoteItem>();
  var voteChoiceModel = RxList<VoteChoice>();

  late TextEditingController titleController;
  late FocusNode titleFocusNode;

  @override
  void onInit() {
    Log.print('index: $index');
    createItemModel.value = _data;
    // createItemModel.value = CreateItemModel.fromJson(_data.toJson());

    coverPhoto.value = createItemModel.value.voteItem![index].file ?? File('');
    Log.print('file: ${createItemModel.value.voteItem![index].file?.path ?? ''}');

    titleController = TextEditingController(text: _data.voteItem![index].titleItem!);
    titleFocusNode = _data.voteItem![index].focusNode!;

    // createItemModel.update((val) {
    //   // val!.voteItem![index].controller = TextEditingController(text: _data.voteItem![index].titleItem!);
    //   val!.voteItem![index].voteChoice!.forEach((element) {
    //     element.controller = TextEditingController(text: element.title);
    //   });
    // });

    // try {
    //   createItemModel.update((val) {
    //     val!.voteItem!.forEach((element) {
    //       Log.print('file: ${element.file?.path}');
    //       // element.file = File('');
    //     });
    //   });
    // } catch (e) {
    //   // Log.print('$e');
    // }

    voteItemModel.addAll(_data.voteItem ?? []);
    // voteItemModel.value = _data.voteItem ?? [];

    voteChoiceModel.addAll(_data.voteItem![index].voteChoice ?? []);
    // voteChoiceModel.value = _data.voteItem![index].voteChoice ?? [];
    super.onInit();
  }

  @override
  void onClose() {
    coverPhoto.close();
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
        if (Get.currentRoute == AppRoutes.MFP_VOTE_CREATE_ITEM) Get.back(result: null);
      },
    );

    /* if (isEdit) {
      var _data = createItemModel.value.obs;
      _data.update((val) {
        val!.voteItem!.removeAt(index);
      });

      Get.back(result: _data);
      // Get.back(result: createItemModel.value);
      return;
    }

    if (data.voteItem![index].controller!.text.isNotEmpty ||
        (createItemModel.value.voteItem![index].file?.path ?? '').isNotEmpty ||
        createItemModel.value.voteItem![index].controller!.text.isNotEmpty ||
        createItemModel.value.voteItem![index].voteChoice!.where((element) => element.controller.text.isNotEmpty).toList().isNotEmpty) {
      await MyDialog.defaultDialog(
        title: 'คุณต้องการยกเลิกการสร้างโหวต?',
        content: 'ข้อมูลที่คุณกรอกจะหายไป',
        textConfirm: 'ตกลง',
        textCancel: 'ยกเลิก',
        onConfirm: () {
          if (Get.isDialogOpen ?? false) Get.back();
          if (Get.currentRoute == AppRoutes.MFP_VOTE_CREATE_ITEM) {
            var _data = createItemModel.value.obs;
            _data.update((val) {
              val!.voteItem!.removeAt(index);
            });

            Get.back(result: _data);
          }
        },
      );
      return;
    }

    var _data = createItemModel.value.obs;
    _data.update((val) {
      val!.voteItem!.removeAt(index);
    });

    Get.back(result: _data); */
    // Get.back(result: null);
    // Get.back(result: createItemModel.value);
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
