// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../controllers/account_merge_controller.dart';
import '../../../utils/colors.dart';

class InputOtpField extends StatelessWidget {
  InputOtpField({Key? key}) : super(key: key);

  AccountMergeController controller = Get.put(AccountMergeController());

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      autoDisposeControllers: false,
      appContext: context,
      textStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      pastedTextStyle: const TextStyle(
        color: appleColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      length: controller.otpLenght,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 40,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveColor: Colors.grey,
      ),
      controller: controller.otpTextController,
      keyboardType: TextInputType.number,
      validator: (_) {
        return null;
      },
      onCompleted: (value) {
        debugPrint('onCompleted: $value');
      },
      onChanged: (value) {
        debugPrint('onChanged: $value');
      },
      beforeTextPaste: (text) {
        debugPrint('Allow to paste $text');
        return true;
      },
    );
  }
}
