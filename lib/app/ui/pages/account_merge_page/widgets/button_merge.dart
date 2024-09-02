// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mfp_app/app/routes/app_routes.dart';

import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/account_merge_controller.dart';
import '../../../utils/colors.dart';

class ButtonMerge extends StatelessWidget {
  ButtonMerge({Key? key}) : super(key: key);

  AccountMergeController controller = Get.put(AccountMergeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kBottomNavigationBarHeight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(bottom: 16),
        child: ElevatedButton(
          onPressed: onMerge,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          child: const Text(
            'ถัดไป',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onMerge() async {
    int statusCode = await controller.fetchSendOTP(controller.arguments.email);

    switch (statusCode) {
      case 0:
        SnackBarComponent.show(
          title: 'OTP ถูกส่งมากกว่า 3 กรุณาลองส่ง OTP อีกครั้งในภายหลัง',
          type: SnackBarType.warning,
        );
        break;

      case 1:
        Get.toNamed(
          AppRoutes.ACCOUNT_MERGE_INPUT_OTP,
          arguments: controller.arguments,
        );
        break;

      default:
        SnackBarComponent.show(
          title: 'ขออภัยระบบเกิดข้อผิดพลาด',
          type: SnackBarType.error,
        );
        break;
    }

    return;
  }
}
