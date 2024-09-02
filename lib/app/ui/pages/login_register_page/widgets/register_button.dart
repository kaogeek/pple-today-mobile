// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.toNamed(AppRoutes.REGISTER),
      child: Text(
        'สร้างบัญชีประชาชน',
        style: TextStyle(
          fontSize: 16,
          color: primaryBlue,
        ),
      ),
    );
  }
}
