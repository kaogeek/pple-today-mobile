import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, Get.height * .10, 15, 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            backgroundColor: kPrimaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              side: BorderSide(color: kPrimaryColor),
            ),
          ),
          child: const Text(
            'เข้าสู่ระบบ',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.LOGIN_MAIN);
          },
        ),
      ),
    );
  }
}
