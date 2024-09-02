// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/loading.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/account_merge_controller.dart';
import '../../../../controllers/login_main_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';

class ConfirmButton extends StatelessWidget {
  ConfirmButton({Key? key}) : super(key: key);

  AccountMergeController controller = Get.put(AccountMergeController());
  LoginMainController loginController = Get.put(LoginMainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        onPressed: _loginMerge,
        child: const Text(
          'ตกลง',
          style: TextStyle(fontSize: 18),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginMerge() async {
    final _otpText = controller.otpTextController.text;

    if (_otpText.isEmpty || _otpText.length < controller.otpLenght) {
      SnackBarComponent.show(
        title: 'กรุณาใส่รหัส OTP ให้ครบถ้วน',
        type: SnackBarType.warning,
      );
      return;
    }

    Loading.show();

    final int otpNum = int.parse(_otpText);

    final userData = loginController.userDataSocialModel;

    final result = await controller.fetchCheckOTP(
      email: controller.arguments.email,
      otp: otpNum,
      id: userData.uid,
      idToken: userData.idToken,
      fbsigbedReq: userData.email,
      expires: userData.expires,
      authToken: userData.authToken,
      tokenSecretTW: userData.secretToken,
      mode: userData.mode ?? ModeType.email,
    );

    if (result.status == 3) {
      Loading.dismiss();
      SnackBarComponent.show(
        title: 'OTP ของคุณหมดอายุแล้ว',
        type: SnackBarType.error,
      );
      return;
    }

    if (result.status == 0) {
      Loading.dismiss();
      SnackBarComponent.show(
        title: 'รหัส OTP ของคุณไม่ถูกต้อง',
        type: SnackBarType.warning,
      );
      return;
    }

    switch (result.authUser) {
      case 'FACEBOOK':
        await controller.fetchLoginWithFacebook(userData.idToken!);
        break;

      case 'GOOGLE':
        await controller.fetchLoginWithGoogle(
          tokenGG: userData.idToken!,
          authTokenGG: userData.authToken!,
        );
        break;

      case 'TWITTER':
        break;

      case 'APPLE':
        await controller.fetchLoginWithApple(
          uid: userData.uid!,
          email: controller.arguments.email,
          tokenAP: userData.idToken!,
          authTokenAP: userData.authToken!,
          creationTime: userData.creationTime,
          lastSignInTime: userData.lastSignInTime,
        );
        break;

      default:
        await controller.fetchLoginWithEmail(
          email: controller.arguments.email,
          pass: controller.arguments.password!,
        );
        break;
    }

    return;
  }
}
