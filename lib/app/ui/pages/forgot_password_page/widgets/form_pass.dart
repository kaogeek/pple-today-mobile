// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/all_rights_reserved.dart';
import '../../../../component/my_dialog.dart';
import '../../../../controllers/forgot_password_controller.dart';
import '../../../utils/colors.dart';
import 'text_field_forgot_pass.dart';

class FormPass extends StatelessWidget {
  FormPass({Key? key}) : super(key: key);

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
                  'ป้อนรหัสการกู้คืน\nโปรดตรวจสอบ รหัสกู้คืน ที่ใช้สำหรับการรีเซ็ตรหัสผ่าน\nบัญชีประชาชนทูเดย์ที่อีเมลของคุณ',
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
              controller: controller.otpTextController,
              hintText: 'รหัสกู้คืน',
            ),
            TextFieldForgotPass(
              controller: controller.passwordTextController,
              hintText: 'รหัสผ่าน',
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (controller.isValidPass)
                    const Icon(
                      Icons.check,
                      color: kPrimaryColor,
                    ),
                  IconButton(
                    icon: Icon(
                      controller.hidePass ? Icons.visibility_off_outlined : Icons.visibility,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      controller.hidePass = !controller.hidePass;
                      controller.update();
                    },
                  ),
                ],
              ),
              obscureText: controller.isValidPass ? true : controller.hidePass,
              onChanged: _validatePass,
            ),
            TextFieldForgotPass(
              controller: controller.cfPassTextController,
              hintText: 'ใส่รหัสผ่านอีกครั้ง',
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (controller.isValidConfirmPass)
                    const Icon(
                      Icons.check,
                      color: kPrimaryColor,
                    ),
                  IconButton(
                    icon: Icon(
                      controller.hideCFPass ? Icons.visibility_off_outlined : Icons.visibility,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      controller.hideCFPass = !controller.hideCFPass;
                      controller.update();
                    },
                  ),
                ],
              ),
              obscureText: controller.isValidConfirmPass ? true : controller.hideCFPass,
              onChanged: _validateCFPass,
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
            checkboxListTile(
              title: 'รหัสผ่านควรมากกว่า 6 ตัวอักษรขึ้นไป',
              value: controller.isCheckLength,
            ),
            checkboxListTile(
              title: 'ประกอบด้วยตัวอักขระพิเศษอย่างน้อย 1 ตัว',
              value: controller.isCheckSpecial,
            ),
            checkboxListTile(
              title: 'ต้องมีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว',
              value: controller.isCheckUpperCase,
            ),
            const SizedBox(height: 56),
            SizedBox(
              width: Get.width * .9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  backgroundColor: controller.isValidPass & controller.isValidConfirmPass ? kPrimaryColor : kPrimaryColor.withOpacity(.5),
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
                onPressed: _submitPass,
              ),
            ),
            const AllRightsReserve(),
          ],
        );
      },
    );
  }

  Widget checkboxListTile({
    required String title,
    required bool value,
  }) {
    final theme = Theme.of(Get.context!);
    final oldCheckboxTheme = theme.checkboxTheme;
    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Theme(
            data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
            child: Transform.scale(
              scale: .8,
              child: Checkbox(
                value: true,
                onChanged: (_) {},
                activeColor: kPrimaryColor,
                checkColor: value ? Colors.white : kPrimaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validatePass(String value) {
    controller.errorMassage = '';

    (controller.passwordTextController.text.isEmpty) || (controller.cfPassTextController.text.isEmpty)
        ? controller.isValidConfirmPass = false
        : controller.isValidConfirmPass = (value == controller.cfPassTextController.text);

    controller.isCheckLength = controller.passwordTextController.text.length >= 6;

    controller.isCheckUpperCase = RegExp(r'[A-Z]').hasMatch(controller.passwordTextController.text);

    controller.isCheckSpecial = RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(controller.passwordTextController.text);

    controller.isValidPass = controller.isCheckLength && controller.isCheckUpperCase && controller.isCheckSpecial;
    controller.update();
  }

  void _validateCFPass(String value) {
    controller.errorMassage = '';

    (controller.passwordTextController.text.isEmpty) || (controller.cfPassTextController.text.isEmpty)
        ? controller.isValidConfirmPass = false
        : controller.isValidConfirmPass = (value == controller.passwordTextController.text);
  }

  Future<void> _submitPass() async {
    if (controller.otpTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่รหัสกู้คืน';
      controller.update();
      return;
    }

    if (controller.passwordTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่รหัสผ่าน';
      controller.update();
      return;
    }

    if (controller.cfPassTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่รหัสผ่านยืนยัน';
      controller.update();
      return;
    }

    if (controller.passwordTextController.text != controller.cfPassTextController.text) {
      controller.errorMassage = 'รหัสผ่านไม่ตรงกัน';
      controller.update();
      return;
    }

    if (!controller.isCheckLength) {
      controller.errorMassage = 'รหัสผ่านควรมากกว่า 6 ตัวอักษรขึ้นไป';
      controller.update();
      return;
    }

    if (!controller.isCheckSpecial) {
      controller.errorMassage = 'ต้องมีตัวอักขระพิเศษอย่างน้อย 1 ตัว';
      controller.update();
      return;
    }

    if (!controller.isCheckUpperCase) {
      controller.errorMassage = 'ต้องมีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว';
      controller.update();
      return;
    }

    var result = await controller.fetchForgotPassChangePass(
      otp: controller.otpTextController.text,
      email: controller.emailTextController.text,
      pass: controller.passwordTextController.text,
    );

    if (result.status != 1) {
      MyDialog.defaultDialog(
        title: '',
        content: result.message ?? '',
      );
      return;
    }

    controller.onNextPage();
    return;
  }
}
