import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/change_pass_model.dart';
import '../data/models/forgot_pass_model.dart';
import '../data/services/user_service.dart';
import '../routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final _service = UserService();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController cfPassTextController = TextEditingController();

  String errorMassage = '';

  bool isChangedEmail = false;
  bool isValidEmail = false;
  bool hidePass = true;
  bool isValidPass = false;
  bool hideCFPass = true;
  bool isValidConfirmPass = false;
  bool isCheckLength = false;
  bool isCheckUpperCase = false;
  bool isCheckSpecial = false;

  int indexPage = 0;

  ForgotPassModel forgotPassModel = ForgotPassModel();
  ChangePassModel changePassModel = ChangePassModel();

  void onNextPage() {
    indexPage++;
    update();
  }

  void onBackPage() {
    switch (indexPage) {
      case 1:
        indexPage--;
        passwordTextController.clear();
        isValidPass = false;
        cfPassTextController.clear();
        isValidConfirmPass = false;
        isCheckLength = false;
        isCheckUpperCase = false;
        isCheckSpecial = false;
        break;

      case 2:
        Get.offAllNamed(AppRoutes.DASHBOARD);
        break;

      default:
        Get.back();
        break;
    }
    update();
  }

  Future<ForgotPassModel> fetchForgotPassSendOTP(String email) async {
    try {
      forgotPassModel.clear();
      update();

      Response response = await _service.forgotPassSendOTP(email);

      forgotPassModel = ForgotPassModel.fromJson(response.body);
    } catch (e) {
      forgotPassModel.message = 'เกิดข้อผิดพลาดในการเชื่อมต่อเซิร์ฟเวอร์';
      printError(info: e.toString());
    }

    update();
    return forgotPassModel;
  }

  Future<ChangePassModel> fetchForgotPassChangePass({required String otp, required String email, required String pass}) async {
    try {
      changePassModel.clear();
      update();

      Response response = await _service.forgotPassChangePass(
        otp: otp,
        email: email,
        pass: pass,
      );

      response.isOk ? changePassModel = ChangePassModel.fromJson(response.body) : changePassModel.message = 'เกิดข้อผิดพลาดในการเชื่อมต่อเซิร์ฟเวอร์';
    } catch (e) {
      changePassModel.message = 'เกิดข้อผิดพลาดในการเชื่อมต่อเซิร์ฟเวอร์';
      printError(info: e.toString());
    }

    update();
    return changePassModel;
  }
}
