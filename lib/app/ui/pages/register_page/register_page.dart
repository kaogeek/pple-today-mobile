import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/register_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/enum.dart';
import 'widgets/form_input_detail.dart';
import 'widgets/form_input_email.dart';
import 'widgets/form_input_pass.dart';
import 'widgets/form_profile_image.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({Key? key}) : super(key: key);

  final List<Widget> _formEmail = [
    FormInputEmail(),
    FormInputPass(),
    FormProfileImage(),
    FormInputDetail(),
  ];

  final List<Widget> _formSocial = [
    FormProfileImage(),
    FormInputDetail(),
  ];

  // TODO: implement TextField Background
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
            controller.onBackPage();
          },
        ),
        actions: [
          Container(
            height: 80,
            width: 160,
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesShutterstock553511089),
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
            child: GetBuilder<RegisterController>(
              init: RegisterController(),
              initState: (_) {},
              builder: (_) {
                return controller.arguments == null || (controller.arguments!.type == ModeType.email) ? _formEmail[controller.indexPage] : _formSocial[controller.indexPage];
              },
            ),
          ),
        ),
      ),
    );
  }
}
