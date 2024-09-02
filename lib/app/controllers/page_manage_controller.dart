import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/loading.dart';
import '../component/snack_bar_component.dart';
import '../data/services/page_service.dart';
import '../ui/utils/storage_keys.dart';

class PageManageController extends GetxController {
  final _service = PageService();
  final _box = GetStorage();

  final String pageId = Get.arguments['PAGE_ID'];

  @override
  void onInit() {
    debugPrint('--> PAGE_ID: $pageId');
    super.onInit();
  }

  Future<void> fetchUpdatePage({
    String? pageName,
    String? pageUsername,
    String? backgroundStory,
    String? lineId,
    String? facebookURL,
    String? twitterURL,
    String? websiteURL,
    String? email,
  }) async {
    Loading.show();

    try {
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';
      String uid = _box.read(StorageKeys.uid) ?? '';

      Response response = await _service.updatePage(
        pageId: pageId,
        token: token,
        uid: uid,
        mode: mode,
        pageName: pageName,
        pageUsername: pageUsername,
        backgroundStory: backgroundStory,
        lineId: lineId,
        facebookURL: facebookURL,
        twitterURL: twitterURL,
        websiteURL: websiteURL,
        email: email,
      );

      if (response.hasError) {
        throw Exception(response.statusText ?? 'Unknown error');
      }

      Loading.dismiss();
      SnackBarComponent.show(
        title: 'แก้ไขข้อมูลสำเร็จ',
        message: 'ข้อมูลของคุณได้รับการแก้ไขแล้ว',
        type: SnackBarType.success,
      );
    } catch (e) {
      Loading.dismiss();
      SnackBarComponent.show(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถแก้ไขข้อมูลได้',
        type: SnackBarType.error,
      );
      log('', error: e, name: 'FetchUpdatePage');
    }

    return;
  }
}
