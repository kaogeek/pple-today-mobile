// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_routes.dart';
import '../ui/utils/assets.dart';
import '../ui/utils/colors.dart';
import '../ui/utils/storage_keys.dart';
import 'snack_bar_component.dart';

Future<void> bottomSheetUGC({
  void Function()? onHide,
  void Function()? onReportPost,
  void Function()? onReportUser,
  void Function()? onReportPage,
  void Function()? onReportComment,
  void Function()? onBlock,
  String? copyText,
}) async {
  await showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (copyText != null)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.copy_rounded),
                      title: Text(
                        'คัดลอก',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () async {
                        Clipboard.setData(ClipboardData(text: copyText));
                        Get.back(); // close bottom sheet
                        SnackBarComponent.show(
                          title: 'คัดลอกข้อความเรียบร้อยแล้ว',
                          type: SnackBarType.info,
                        );
                        return;
                      },
                    ),
                  ),
                if (onHide != null)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.close_rounded),
                      title: Text(
                        'ซ่อนโพสต์นี้',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('ไม่ต้องการเห็นโพสต์นี้'),
                      onTap: () async {
                        await _showDialog(
                          title: 'ซ่อนโพสต์นี้',
                          titleColor: kPrimaryColor,
                          content: 'คุณต้องการซ่อนโพสต์นี้ใช่หรือไม่',
                          onConfirm: () {
                            Get.back(); // close dialog
                            onHide();
                          },
                        );
                        return;
                      },
                    ),
                  ),
                if (onReportPost != null)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.warning_amber_rounded),
                      title: Text(
                        'รายงานโพสต์นี้',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('โพสต์นี้ไม่เหมาะสม'),
                      onTap: () {
                        Get.back(); // close bottom sheet
                        onReportPost();
                      },
                    ),
                  ),
                if (onReportUser != null)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.warning_amber_rounded),
                      title: Text(
                        'รายงานผู้ใช้นี้',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('ผู้ใช้นี้ไม่เหมาะสม'),
                      onTap: () async {
                        await _showDialog(
                          title: 'รายงานผู้ใช้นี้',
                          titleColor: Colors.red,
                          content: 'คุณต้องการรายงานผู้ใช้นี้ใช่หรือไม่',
                          onConfirm: () {
                            Get.back(); // close dialog
                            onReportUser();
                          },
                        );
                        return;
                      },
                    ),
                  ),
                if (onReportPage != null)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.warning_amber_rounded),
                      title: Text(
                        'รายงานเพจนี้',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('เพจนี้ไม่เหมาะสม'),
                      onTap: () {
                        Get.back(); // close bottom sheet
                        onReportPage();
                      },
                    ),
                  ),
                if (onReportComment != null)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.warning_amber_rounded),
                      title: Text(
                        'รายงานคอมเม้นนี้',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('คอมเม้นนี้ไม่เหมาะสม'),
                      onTap: () async {
                        await _showDialog(
                          title: 'รายงานคอมเม้นนี้',
                          titleColor: Colors.red,
                          content: 'คุณต้องการรายงานคอมเม้นนี้ใช่หรือไม่',
                          onConfirm: () {
                            Get.back(); // close dialog
                            onReportComment();
                          },
                        );
                        return;
                      },
                    ),
                  ),
                if (onBlock != null)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.block_rounded),
                      title: Text(
                        'บล็อกผู้ใช้นี้',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('ไม่ต้องการเห็นโพสต์ของผู้ใช้นี้'),
                      onTap: () async {
                        await _showDialog(
                          title: 'บล็อกผู้ใช้นี้',
                          titleColor: Colors.red,
                          content: 'คุณต้องการบล็อกผู้ใช้นี้ใช่หรือไม่',
                          onConfirm: () {
                            Get.back(); // close dialog
                            onBlock();
                          },
                        );
                        return;
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      });
  return;
}

Future<void> _showDialog({
  required String title,
  Color titleColor = Colors.black,
  required String content,
  required void Function() onConfirm,
  Color cancelTextColor = Colors.black,
  Color confirmTextColor = kPrimaryColor,
}) async {
  String token = GetStorage().read(StorageKeys.token) ?? '';

  if (token.isEmpty) {
    Get.back(); // close dialog
    Get.toNamed(AppRoutes.LOGIN_REGISTER);
    return;
  }

  await Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(
      fontSize: 24,
      fontFamily: Assets.assetsFontsAnakotmaiLight,
      color: titleColor,
    ),
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: Assets.assetsFontsAnakotmaiLight,
      ),
    ),
    textCancel: 'ปิด',
    textConfirm: 'ใช่',
    cancelTextColor: cancelTextColor,
    confirmTextColor: confirmTextColor,
    buttonColor: Colors.white,
    onConfirm: onConfirm,
  );

  Get.back(); // close dialog
  return;
}
