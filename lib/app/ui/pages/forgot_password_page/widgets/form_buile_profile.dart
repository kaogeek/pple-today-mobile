// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/all_rights_reserved.dart';
import '../../../../controllers/forgot_password_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class FormBuileProfile extends StatelessWidget {
  const FormBuileProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      initState: (_) {},
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              width: Get.width * .86,
              height: Get.height * .05,
              child: const Text(
                'เปลี่ยนรหัสผ่านสำเร็จ',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * .86,
              height: Get.height * .09,
              child: const Text(
                'คุณสามารถเข้าบัญชีของคุณผ่านรหัสผ่านใหม่ได้แล้ว',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: Get.height * .3,
              width: Get.width * .85,
              child: CircleAvatar(
                radius: (80),
                backgroundColor: Colors.white,
                child: (controller.changePassModel.data?.imageUrl ?? '').isEmpty
                    ? const CircleAvatar(
                        radius: 108,
                        backgroundImage: AssetImage(Assets.assetsImagesPlaceholderPNG),
                      )
                    : CircleAvatar(
                        radius: 108,
                        backgroundImage: NetworkImage(controller.changePassModel.data!.imageUrl!),
                      ),
              ),
            ),
            const SizedBox(height: 56),
            SizedBox(
              width: Get.width * .9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 15, bottom: 15), backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
                child: const Text(
                  'เสร็จ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _submitDone,
              ),
            ),
            const AllRightsReserve(),
          ],
        );
      },
    );
  }

  void _submitDone() {
    Get.offAllNamed(AppRoutes.DASHBOARD);
  }
}
