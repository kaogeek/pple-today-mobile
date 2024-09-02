// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../component/all_rights_reserved.dart';
import '../../../../component/my_dialog.dart';
import '../../../../controllers/forgot_password_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/formatter.dart';
import 'text_field_forgot_pass.dart';

class FormEmail extends StatelessWidget {
  FormEmail({Key? key}) : super(key: key);

  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  );

  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              height: Get.height / 7,
              width: Get.width / 1,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'หากคุณลืมรหัสผ่าน\nประชาชนทูเดย์,',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 30,
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                width: Get.width / 1,
                height: Get.height / 5,
                child: const Text(
                  'หากคุณประสบปัญหาเมื่อพยายาม\nลงชื่อเข้าใช้ด้วยรหัสผ่าน บัญชีผู้ใช้\nประชาชนทูเดย์ของคุณ ใช้ขั้นตอนนี้เพื่อรีเซ็ต\nและรับคืนสิทธิ์การเข้าสู่บัญชีผู้ใช้ประชาชนทูเดย์',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white70,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Container(
              width: Get.width / 1,
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: const Text(
                'กรุณากรอก อีเมล ที่คุณใช้ในการสมัคร',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white70,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFieldForgotPass(
              controller: controller.emailTextController,
              inputFormatters: Formatter.inputEmail,
              keyboardType: TextInputType.emailAddress,
              hintText: 'อีเมล',
              onChanged: (value) {
                controller.errorMassage = '';
                controller.isValidEmail = false;
                controller.isChangedEmail = true;
                controller.update();

                if (value.isNotEmpty) {
                  _debouncer.call(() async {
                    if (!value.isEmail) {
                      controller.errorMassage = 'กรุณากรอกอีเมลให้ถูกต้อง';
                      controller.update();
                      return;
                    }

                    controller.isValidEmail = true;
                    controller.isChangedEmail = false;
                    controller.update();
                    return;
                  });
                }
              },
            ),
            SizedBox(
              height: 56,
              child: Center(
                child: Text(
                  controller.errorMassage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 56),
            SizedBox(
              width: Get.width * .9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  backgroundColor: controller.isValidEmail ? kPrimaryColor : kPrimaryColor.withOpacity(.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
                child: const Text(
                  'ถัดไป',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _submitForgotPass,
              ),
            ),
            const AllRightsReserve(),
          ],
        );
      },
    );
  }

  Future<void> _submitForgotPass() async {
    var result = await controller.fetchForgotPassSendOTP(
      controller.emailTextController.text,
    );

    if (result.status != 1) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: result.message ?? '',
      );
      return;
    }

    MyDialog.defaultDialog(
      title: 'ลืมรหัสผ่าน',
      content: result.message ?? '',
    ).then((_) {
      controller.onNextPage();
    });
    return;
  }
}
