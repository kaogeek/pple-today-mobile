import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../ui/utils/storage_keys.dart';

class WebviewController extends GetxController {
  String url = Get.arguments['URL'] +
      (GetStorage().read(StorageKeys.token) != null ? '?token=${GetStorage().read(StorageKeys.token)}' : '') +
      (GetStorage().read(StorageKeys.uid) != null ? '&userid=${GetStorage().read(StorageKeys.uid)}' : '') +
      (GetStorage().read(StorageKeys.mode) != null ? '&mode=${GetStorage().read(StorageKeys.mode)}' : '');
  String title = Get.arguments['TITLE'];

  double isProgress = 0.0;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    log('URL: $url');
  }
}
