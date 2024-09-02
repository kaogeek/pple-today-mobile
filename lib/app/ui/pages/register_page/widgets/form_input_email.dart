// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../controllers/register_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/formatter.dart';
import 'button_submit.dart';

class FormInputEmail extends StatelessWidget {
  FormInputEmail({Key? key}) : super(key: key);

  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      initState: (_) {},
      builder: (controller) {
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
                'กรุณาใส่ Email ที่คุณจะใช้ในการสมัคร',
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
                controller: controller.emailTextController,
                inputFormatters: Formatter.inputEmail,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'อีเมล',
                  hintStyle: const TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Get.height / 100 * 2.5,
                    horizontal: Get.width / 100 * 2.5,
                  ),
                  border: InputBorder.none,
                  suffixIcon: !controller.isValidEmail
                      ? null
                      : const Icon(
                          Icons.check,
                          color: kPrimaryColor,
                        ),
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
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

                      bool result = await controller.fetchCheckEmail(value);

                      if (!result) controller.errorMassage = 'อีเมลนี้มีผู้ใช้แล้ว';

                      controller.isChangedEmail = false;
                      controller.update();
                      return;
                    });
                  }
                },
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
            ButtonSubmit(
              title: 'ถัดไป',
              value: controller.isValidEmail,
              onPressed: () {
                if (controller.emailTextController.text.isEmpty) {
                  controller.errorMassage = 'กรุณากรอกอีเมล';
                  controller.update();
                  return;
                }

                if (controller.isValidEmail) {
                  controller.onNextPage();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
