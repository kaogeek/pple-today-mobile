import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../ui/utils/storage_keys.dart';

class WebviewEmergencyController extends GetxController {
  String url = Get.arguments['URL'] +
      '?hidebar=true' +
      (GetStorage().read(StorageKeys.token) != null ? '&token=${GetStorage().read(StorageKeys.token)}' : '') +
      (GetStorage().read(StorageKeys.uid) != null ? '&userid=${GetStorage().read(StorageKeys.uid)}' : '') +
      (GetStorage().read(StorageKeys.mode) != null ? '&mode=${GetStorage().read(StorageKeys.mode)}' : '') +
      '${Get.arguments['DATE'] ?? ''}';
  String? iconImage = Get.arguments['ICON_IMAGE'];
  String title = Get.arguments['TITLE'] ?? '';

  @override
  void onInit() {
    super.onInit();
    log('URL: $url');
    debugPrint('TITLE: $title');
  }

  double isProgress = 0.0;

  bool isLoading = true;
}
