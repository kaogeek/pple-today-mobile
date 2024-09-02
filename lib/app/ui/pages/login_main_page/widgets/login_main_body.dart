import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/login_main_controller.dart';
import '../../../utils/enum.dart';
import 'login_choice.dart';
import 'login_with_email.dart';

class LoginMainBody extends StatelessWidget {
  const LoginMainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GetBuilder<LoginMainController>(
          init: LoginMainController(),
          initState: (_) {},
          builder: (controller) {
            switch (controller.loginMode) {
              case ModeType.email:
                return LoginWithEmail();

              default:
                return LoginChoice();
            }
          },
        ),
      ),
    );
  }
}
