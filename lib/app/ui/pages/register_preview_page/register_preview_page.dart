// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mfp_app/app/data/models/register_model.dart';

import '../../../component/loading.dart';
import '../../../component/my_dialog.dart';
import '../../../controllers/login_main_controller.dart';
import '../../../controllers/register_controller.dart';
import '../../../controllers/register_preview_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/enum.dart';
import '../register_page/widgets/button_submit.dart';

class RegisterPreviewPage extends GetView<RegisterPreviewController> {
  RegisterPreviewPage({Key? key}) : super(key: key);

  LoginMainController loginController = Get.put(LoginMainController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
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
            padding: EdgeInsets.fromLTRB(10, (Get.height * .19), 10, 0),
            child: GetBuilder<RegisterController>(
              init: RegisterController(),
              initState: (_) {},
              builder: (_) {
                return GetBuilder<RegisterController>(
                  init: RegisterController(),
                  initState: (_) {},
                  builder: (registerController) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 116,
                          backgroundColor: Colors.white,
                          child: registerController.profileImage.path.isNotEmpty
                              ? CircleAvatar(
                                  radius: 108,
                                  backgroundImage: FileImage(registerController.profileImage),
                                )
                              : CircleAvatar(
                                  radius: 108,
                                  backgroundImage: AssetImage(Assets.assetsImagesPlaceholderPNG),
                                ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '${registerController.firstNameTextController.text} ${registerController.lastNameTextController.text}',
                          style: const TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '@${registerController.uniqueIdTextController.text}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'ยินดีต้อนรับสู่ พรรคประชาชน',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'ยินดีต้อนรับสู่ แพลตฟอร์ม',
                          style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'ประชาชนทูเดย์',
                          style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                          ),
                        ),
                        ButtonSubmit(
                          title: 'สร้างโปรไฟล์',
                          value: true,
                          onPressed: () async {
                            Get.toNamed(
                              AppRoutes.PRIVACY_POLICY,
                              arguments: {'HIDE_BUTTON': false},
                            )?.then((value) async {
                              if (value == null) {
                                MyDialog.defaultDialog(
                                  content: 'กรุณายอมรับข้อกำหนดในการให้บริการ',
                                );
                                return;
                              }

                              if (value) {
                                Loading.show();

                                late RegisterModel resultRegister;

                                switch (controller.arguments?.type) {
                                  case ModeType.facebook:
                                    resultRegister = await registerController.fetchRegisterWithFacebook();
                                    break;

                                  case ModeType.google:
                                    resultRegister = await registerController.fetchRegisterWithGoogle();
                                    break;

                                  case ModeType.apple:
                                    resultRegister = await registerController.fetchRegisterWithApple();
                                    break;

                                  default:
                                    resultRegister = await registerController.fetchRegisterWithEmail();
                                    break;
                                }

                                if (resultRegister.status != 1) {
                                  Loading.dismiss();
                                  MyDialog.defaultDialog(
                                    content: resultRegister.message ?? 'เกิดข้อผิดพลาดในการสมัครสมาชิก',
                                  );
                                  return;
                                }

                                var resultLogin = await loginController.fetchLoginWithEmail(
                                  email: registerController.emailTextController.text,
                                  pass: registerController.passwordTextController.text,
                                );

                                Loading.dismiss();

                                if (resultLogin.status != 1) {
                                  MyDialog.defaultDialog(
                                    content: resultLogin.message ?? 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ',
                                  );
                                  return;
                                }

                                MyDialog.defaultDialog(
                                  content: resultRegister.message,
                                ).then((_) => Get.offAllNamed(
                                      AppRoutes.SYNC_PAGE_SOCIAL,
                                      arguments: {
                                        'BACK_BUTTON': false,
                                        'SKIP_BUTTON': true,
                                      },
                                    ));
                              }
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
