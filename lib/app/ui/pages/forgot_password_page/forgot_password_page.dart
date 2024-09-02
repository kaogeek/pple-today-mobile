import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/forgot_password_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import 'widgets/form_buile_profile.dart';
import 'widgets/form_email.dart';
import 'widgets/form_pass.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final List<Widget> _form = [
    FormEmail(),
    FormPass(),
    const FormBuileProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          splashRadius: 1,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            controller.onBackPage();
          },
        ),
        actions: [
          Container(
            height: 100,
            width: 170,
            decoration: const BoxDecoration(
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(Assets.assetsImagesShutterstock553511089),
            colorFilter: ColorFilter.mode(
              Colors.grey.shade700,
              BlendMode.modulate,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 112, 10, 0),
            child: GetBuilder<ForgotPasswordController>(
              init: ForgotPasswordController(),
              initState: (_) {},
              builder: (_) {
                return _form[controller.indexPage];
              },
            ),
          ),
        ),
      ),
    );
  }
}
