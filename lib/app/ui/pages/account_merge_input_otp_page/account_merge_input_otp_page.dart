import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/account_merge_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';
import 'widget/confirm_button.dart';
import 'widget/countdown_button.dart';
import 'widget/input_otp_field.dart';

class AccountMergeInputOtpPage extends GetView<AccountMergeController> {
  const AccountMergeInputOtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Text(
              'กรุณากรอกรหัส OTP ของคุณ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 30),
            InputOtpField(),
            const SizedBox(height: 20),
            CountdownButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: ConfirmButton(),
    );
  }
}
