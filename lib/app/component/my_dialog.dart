import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/utils/assets.dart';
import '../ui/utils/colors.dart';

class MyDialog {
  static Future twoTone({
    required String title,
    required String subTitle,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kPrimaryColor, kSecondaryColor],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryBlue.withOpacity(.05),
                      radius: 25,
                      child: Image.asset(
                        // TODO: Change to your logo
                        // Assets.images.group11925PNG,
                        Assets.assetsIconPpleIconTransparentW,
                        fit: BoxFit.fill,
                        width: 25,
                        height: 25,
                      ),
                    ),
                    AutoSizeText(
                      title,
                      maxLines: 5,
                      minFontSize: 16,
                      maxFontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: Assets.assetsFontsAnakotmaiLight,
                      ),
                    ),
                    AutoSizeText(
                      subTitle,
                      maxLines: 8,
                      minFontSize: 16,
                      maxFontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: Assets.assetsFontsAnakotmaiLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> defaultDialog({
    String? title,
    String? content,
    Color contentColor = Colors.black,
    Color? confirmTextColor = kPrimaryColor,
    String? textConfirm,
    VoidCallback? onConfirm,
    Color? cancelTextColor = Colors.black,
    String? textCancel,
    // VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) async {
    bool leanCancel = textCancel != null;
    bool leanConfirm = textConfirm != null;

    await Get.defaultDialog(
      barrierDismissible: barrierDismissible,
      title: title ?? 'เตือน!',
      content: Text(
        content ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: Assets.assetsFontsAnakotmaiLight,
          color: contentColor,
        ),
      ),
      confirmTextColor: confirmTextColor,
      textConfirm: leanConfirm ? textConfirm : 'ตกลง',
      onConfirm: onConfirm ?? () => Get.back(),
      cancelTextColor: cancelTextColor,
      textCancel: leanCancel ? textCancel : null,
      onCancel: leanCancel ? () {} : null,
      buttonColor: Colors.white,
    );
    return;
  }
}
