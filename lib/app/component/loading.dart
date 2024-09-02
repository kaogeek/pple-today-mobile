import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../ui/utils/colors.dart';
import '../ui/utils/storage_keys.dart';

class Loading {
  static bool get isShowing => GetStorage().read(StorageKeys.isLoading) ?? false;

  static void show() {
    // GetStorage().write(StorageKeys.isLoading, true);

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(color: kPrimaryColor),
      ),
      barrierDismissible: false,
    );
  }

  static void dismiss() {
    // bool _isShowing = GetStorage().read(StorageKeys.isLoading) ?? false;
    bool _isShowing = Get.isDialogOpen ?? false;

    if (_isShowing) {
      // GetStorage().write(StorageKeys.isLoading, false);
      Get.back();
    }
  }
}
