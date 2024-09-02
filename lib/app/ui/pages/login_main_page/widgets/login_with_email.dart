// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/loading.dart';
import '../../../../component/my_dialog.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/account_merge_controller.dart';
import '../../../../controllers/login_main_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';

class LoginWithEmail extends StatelessWidget {
  LoginWithEmail({Key? key}) : super(key: key);

  LoginMainController controller = Get.put(LoginMainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginMainController>(
      init: LoginMainController(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            SizedBox(height: Get.height / 100 * 22),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'เข้าสู่ระบบด้วย Email',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            buildTextField(
              controller: controller.emailTextController,
              hintText: 'อีเมล',
              onChanged: _validateLogin,
            ),
            buildTextField(
              controller: controller.passwordTextController,
              hintText: 'รหัสผ่าน',
              suffixIcon: IconButton(
                icon: Icon(
                  controller.hidePass ? Icons.visibility_off_outlined : Icons.visibility,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  controller.hidePass = !controller.hidePass;
                  controller.update();
                },
              ),
              obscureText: controller.hidePass,
              onChanged: _validateLogin,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  child: const Text(
                    'ลืมรหัสผ่าน ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
                  }),
            ),
            SizedBox(
              width: Get.width * .9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.red),
                  ),
                  primary: controller.isValidateLogin ? kPrimaryColor : kPrimaryColor.withOpacity(.5),
                ),
                child: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _submitLogin,
              ),
            ),
            TextButton(
              child: const Text(
                'สมัครสมาชิก',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.REGISTER);
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    void Function(String value)? onChanged,
    Widget? suffixIcon,
    bool readOnly = false,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.2,
            color: Colors.black12,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: Get.height / 100 * 2.5,
              horizontal: Get.width / 100 * 2.5,
            ),
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
          obscureText: obscureText,
          keyboardType: TextInputType.text,
          autocorrect: false,
          readOnly: readOnly,
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _validateLogin(String value) {
    controller.isValidateLogin = controller.emailTextController.value.text.isNotEmpty && controller.passwordTextController.value.text.isNotEmpty;
    controller.update();
  }

  Future<void> _submitLogin() async {
    if (!controller.isValidateLogin) {
      MyDialog.defaultDialog(
        title: 'เข้าสู่ระบบไม่สำเร็จ',
        content: 'กรุณากรอกอีเมลและรหัสผ่านให้ครบถ้วน',
        textConfirm: 'ตกลง',
      );
      return;
    }

    int? status = await controller.fetchCheckEmailUser(
      email: controller.emailTextController.value.text,
      pass: controller.passwordTextController.value.text,
      mode: ModeType.email,
    );

    switch (status) {
      case 0:
        MyDialog.defaultDialog(
          title: 'เข้าสู่ระบบไม่สำเร็จ',
          content: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
          textConfirm: 'ตกลง',
        );
        break;

      case 1:
        Loading.show();

        var result = await controller.fetchLoginWithEmail(
          email: controller.emailTextController.value.text,
          pass: controller.passwordTextController.value.text,
        );

        Loading.dismiss();

        result.status == 1
            ? Get.offAllNamed(AppRoutes.SPLASH)
            : MyDialog.defaultDialog(
                title: 'เข้าสู่ระบบไม่สำเร็จ',
                content: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
                textConfirm: 'ตกลง',
              );
        break;

      case 2:
        Get.toNamed(
          AppRoutes.ACCOUNT_MERGE,
          arguments: ArgumentsMerge(
            email: controller.emailTextController.value.text,
            password: controller.passwordTextController.value.text,
            type: ModeType.email,
          ),
        );
        break;

      default:
        SnackBarComponent.show(
          title: controller.checkEmailUserModel.message ?? 'ขออภัย มีบางอย่างผิดพลาด',
          type: SnackBarType.error,
        );
        break;
    }
  }
}
