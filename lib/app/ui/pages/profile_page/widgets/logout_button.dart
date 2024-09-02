// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({Key? key}) : super(key: key);

  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          primary: Colors.white,
          shadowColor: Colors.transparent,
        ),
        onPressed: () async {
          await Get.defaultDialog(
            title: 'ออกจากระบบ',
            content: Text(
              'คุณต้องการออกจากระบบ ใช่หรือไม่',
              style: TextStyle(
                fontFamily: Assets.assetsFontsAnakotmaiLight,
              ),
            ),
            textConfirm: 'ยืนยัน',
            textCancel: 'ยกเลิก',
            confirmTextColor: kPrimaryColor,
            cancelTextColor: Colors.black,
            buttonColor: Colors.white,
            onConfirm: () async {
              Get.back(); // close dialog

              await controller.fetchLogout();
              Get.offAllNamed(AppRoutes.SPLASH);

              return;
            },
          );
          return;
        },
        child: Text(
          'ออกจากระบบ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            // fontWeight: FontWeight.bold,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
      ),
    );
  }
}
