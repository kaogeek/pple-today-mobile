import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_information.dart';
import '../../../controllers/login_main_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/enum.dart';
import 'widgets/login_main_body.dart';

class LoginMainPage extends GetView<LoginMainController> {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            switch (controller.loginMode) {
              case ModeType.email:
                controller.loginMode = null;
                controller.emailTextController.clear();
                controller.passwordTextController.clear();
                controller.hidePass = true;
                controller.isValidateLogin = false;
                controller.update();
                break;

              default:
                Get.back();
                break;
            }
          },
        ),
        actions: [
          Container(
            height: 100,
            width: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  // TODO: Change to MFP logo
                  //   Assets.images.mfpLogoHorizontalPNG,
                  Assets.assetsIconPpleTransparentO,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.assetsImagesShutterstock553511089,
            ),
            colorFilter: ColorFilter.mode(
              Colors.grey[700]!,
              BlendMode.modulate,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const LoginMainBody(),
      ),
      bottomNavigationBar: const SafeArea(
        child: Text(
          AppInformation.allRightsReserve,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
