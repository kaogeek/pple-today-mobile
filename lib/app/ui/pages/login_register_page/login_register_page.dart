import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/login_register_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/login_button.dart';
import 'widgets/login_register_app_bar.dart';
import 'widgets/login_register_logo.dart';
import 'widgets/register_button.dart';

class LoginRegisterPage extends GetView<LoginRegisterController> {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: const LoginRegisterAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: const [
              LoginRegisterLogo(),
              LoginButton(),
              RegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
