// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/elevated_button_component.dart';
import '../../../../controllers/login_main_controller.dart';
import '../../../../controllers/main_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';

class LoginChoice extends StatelessWidget {
  LoginChoice({Key? key}) : super(key: key);

  LoginMainController controller = Get.put(LoginMainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      initState: (_) {},
      builder: (mainController) {
        return Column(
          children: [
            SizedBox(height: Get.height / 100 * 22),
            const Padding(
              padding: EdgeInsets.only(bottom: 120),
              child: Text(
                'เราอยากให้ทุกคนมี\nเสรีภาพ เสมอภาค ภราดรภาพ',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButtonComponent(
              primary: const Color(0xFFE5E5E5),
              icon: Image.asset(
                Assets.assetsImagesEmail,
                width: 56,
                height: 56,
                fit: BoxFit.fitHeight,
              ),
              labelText: 'เข้าสู่ระบบด้วย Email',
              style: const TextStyle(
                fontSize: 14,
                color: primaryBlue,
              ),
              onPressed: () {
                controller.loginMode = ModeType.email;
                controller.update();
              },
            ),
            // if (GetPlatform.isIOS
            //     ? mainController.loginWithSocialModel.iOS?.mfp ?? false
            //     : mainController.loginWithSocialModel.android?.mfp ?? false)
            // ElevatedButtonComponent(
            //   primary: kPrimaryMFPColor,
            //   icon: Image.asset(
            //     Assets.images.ppleTransparentPNG,
            //     width: 56,
            //     height: 30,
            //     fit: BoxFit.contain,
            //   ),
            //   labelText: 'เข้าสู่ระบบด้วยสมาชิกพรรค',
            //   onPressed: () async {
            //     Get.toNamed(
            //       AppRoutes.WEB_VIEW_LOGIN_MFP,
            //       arguments: {'URL': 'https://accounts.moveforwardparty.org/me'},
            //     );
            //   },
            // ),
            if (mainController.loginWithSocialModel.facebook ?? false)
              ElevatedButtonComponent(
                primary: facebookColor,
                icon: Image.asset(
                  Assets.assetsImagesFacebook,
                  width: 56,
                  height: 56,
                  fit: BoxFit.fitHeight,
                ),
                labelText: 'เข้าสู่ระบบด้วย Facebook',
                onPressed: () async {
                  await controller.fetchLoginWithFacebook();
                },
              ),

            /*  if (mainController.loginWithSocialModel.twitter ?? false)
              ElevatedButtonComponent(
                primary: const Color(0xFF1DA1F3),
                icon: Image.asset(
                  Assets.assetsImagesTwitter,
                  width: 56,
                  height: 56,
                  fit: BoxFit.fitHeight,
                ),
                labelText: 'เข้าสู่ระบบด้วย Twitter',
                onPressed: () {
                  controller.loginMode = ModeType.twitter;
                  controller.update();
                },
              ), */
            if (mainController.loginWithSocialModel.google ?? false)
              ElevatedButtonComponent(
                primary: googleColor,
                icon: Image.asset(
                  Assets.assetsImagesGoogle,
                  width: 56,
                  height: 32,
                  fit: BoxFit.fitHeight,
                ),
                labelText: 'เข้าสู่ระบบด้วย Google',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await controller.fetchLoginWithGoogle();
                },
              ),
            if (mainController.loginWithSocialModel.apple ?? false)
              ElevatedButtonComponent(
                primary: appleColor,
                icon: Image.asset(
                  Assets.assetsImagesApple,
                  width: 56,
                  height: 32,
                  fit: BoxFit.fitHeight,
                ),
                labelText: 'เข้าสู่ระบบด้วย Apple',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await controller.fetchLoginWithApple();
                },
              ),
          ],
        );
      },
    );
  }
}
