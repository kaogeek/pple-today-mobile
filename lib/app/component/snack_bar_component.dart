import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class SnackBarComponent {
  static Future<void> show({
    required String title,
    required SnackBarType type,
    String? message,
    Duration? duration = const Duration(seconds: 2),
  }) async {
    Duration _duration = duration ?? const Duration(seconds: 2);

    Get.snackbar(
      title,
      message ?? '',
      duration: _duration,
      borderRadius: 10,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: () {
        switch (type) {
          case SnackBarType.success:
            return Colors.green.withOpacity(.7);

          case SnackBarType.warning:
            return Colors.orange.withOpacity(.8);

          case SnackBarType.error:
            return Colors.red.withOpacity(.7);

          default:
            return Colors.black.withOpacity(.5);
        }
      }(),
    );

    await Future.delayed(_duration);
    await 1.3.seconds.delay();

    return;
  }
}
