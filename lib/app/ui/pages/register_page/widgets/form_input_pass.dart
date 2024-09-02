// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/register_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/formatter.dart';
import 'button_submit.dart';

class FormInputPass extends StatelessWidget {
  FormInputPass({Key? key}) : super(key: key);

  RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // height: Get.height / 5.8,
              // width: Get.width / 1,
              child: Column(
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'สวัสดี,',
                      style: TextStyle(
                        fontSize: 30,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ยินดีต้อนรับเข้าสู่ แพลตฟอร์ม\nประชาชนทูเดย์',
                      style: TextStyle(
                        fontSize: 25,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 96),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: const Text(
                'กรุณาใส่รหัสผ่าน',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.2,
                  color: Colors.black12,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextField(
                controller: controller.passwordTextController,
                inputFormatters: Formatter.inputPassword,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'รหัสผ่าน',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Get.height / 100 * 2.5,
                    horizontal: Get.width / 100 * 2.5,
                  ),
                  border: InputBorder.none,
                  suffixIcon: !controller.isValidPass
                      ? null
                      : const Icon(
                          Icons.check,
                          color: kPrimaryColor,
                        ),
                ),
                keyboardType: TextInputType.text,
                autocorrect: false,
                obscureText: true,
                onChanged: validatePass,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.2,
                  color: Colors.black12,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextField(
                controller: controller.cfPassTextController,
                inputFormatters: Formatter.inputPassword,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'ใส่รหัสผ่านอีกครั้ง',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Get.height / 100 * 2.5,
                    horizontal: Get.width / 100 * 2.5,
                  ),
                  border: InputBorder.none,
                  suffixIcon: !controller.isValidConfirmPass
                      ? null
                      : const Icon(
                          Icons.check,
                          color: kPrimaryColor,
                        ),
                ),
                keyboardType: TextInputType.text,
                autocorrect: false,
                obscureText: true,
                onChanged: validateCFPass,
              ),
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
              title: 'รหัสผ่านควรมีมากกว่า 6 ตัวอักษรขึ้นไป',
              value: controller.isCheckLength,
            ),
            checkboxListTile(
              title: 'ต้องมีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว',
              value: controller.isCheckUpperCase,
            ),
            checkboxListTile(
              height: null,
              title: 'ต้องมีตัวอักขระพิเศษ !@#\$%^&*_~.? อย่างน้อย 1 ตัว',
              value: controller.isCheckSpecial,
            ),
            ButtonSubmit(
              title: 'ถัดไป',
              value: controller.isCheckLength && controller.isCheckUpperCase && controller.isCheckSpecial,
              onPressed: _submitPass,
            ),
          ],
        );
      },
    );
  }

  Widget checkboxListTile({
    required String title,
    required bool value,
    double? height = 28,
  }) {
    final theme = Theme.of(Get.context!);
    final oldCheckboxTheme = theme.checkboxTheme;
    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Row(
        children: [
          Theme(
            data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
            child: Transform.scale(
              scale: 1,
              child: Checkbox(
                value: true,
                onChanged: (_) {},
                activeColor: kPrimaryColor,
                checkColor: value ? Colors.white : kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validatePass(String value) {
    controller.errorMassage = '';

    controller.passwordTextController.text.isEmpty || controller.cfPassTextController.text.isEmpty
        ? controller.isValidConfirmPass = false
        : controller.isValidConfirmPass = value == controller.cfPassTextController.text;

    controller.isCheckLength = controller.passwordTextController.text.length >= 6;

    controller.isCheckUpperCase = RegExp(r'[A-Z]').hasMatch(controller.passwordTextController.text);

    controller.isCheckSpecial = RegExp(r'^(?=.*?[!@#\$\%^&*_~.?])').hasMatch(controller.passwordTextController.text);

    controller.isValidPass = controller.isCheckLength && controller.isCheckUpperCase && controller.isCheckSpecial;
    controller.update();
  }

  void validateCFPass(String value) {
    controller.errorMassage = '';

    controller.passwordTextController.text.isEmpty || controller.cfPassTextController.text.isEmpty
        ? controller.isValidConfirmPass = false
        : controller.isValidConfirmPass = (controller.passwordTextController.text == value);
    controller.update();
  }

  void _submitPass() {
    if (controller.passwordTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณากรอกรหัสผ่าน';
      controller.update();
      return;
    }

    if (controller.cfPassTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณากรอกรหัสผ่านอีกครั้ง';
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

    controller.onNextPage();
    return;
  }
}
