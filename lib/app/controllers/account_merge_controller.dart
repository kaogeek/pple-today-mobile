import 'dart:developer';

import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../component/loading.dart';
import '../component/snack_bar_component.dart';
import '../data/models/check_otp_model.dart';
import '../data/models/result_login_model.dart';
import '../data/models/send_otp_model.dart';
import '../data/services/user_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/enum.dart';
import '../ui/utils/storage_keys.dart';

class AccountMergeController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  ArgumentsMerge arguments = Get.arguments;

  TextEditingController otpTextController = TextEditingController();

  SendOtpModel sendOtpModel = SendOtpModel();
  CheckOtpModel checkOtpModel = CheckOtpModel();
  ResultLoginModel resultLoginModel = ResultLoginModel();

  int otpLenght = 6;

  Future<int> fetchSendOTP(String email) async {
    try {
      sendOtpModel.clear();

      Response response = await _service.sendOtp(
        email: email,
      );

      sendOtpModel = SendOtpModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'FetchSendOTP');
      sendOtpModel = SendOtpModel(status: 3);
    }

    update();
    return sendOtpModel.status ?? 3;
  }

  Future<CheckOtpModel> fetchCheckOTP({
    required String email,
    required int otp,
    required ModeType mode,
    String? id,
    String? fbsigbedReq,
    String? idToken,
    String? authToken,
    String? tokenSecretTW,
    int? expires,
  }) async {
    try {
      checkOtpModel.clear();

      String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

      String deviceName = await DeviceInformation.deviceName;

      Response response = await _service.checkOTP(
        email: email,
        otp: otp,
        id: id,
        idToken: idToken,
        authToken: authToken,
        devicename: deviceName,
        tokenFCM: tokenFCM,
        tokenSecretTW: tokenSecretTW,
        expires: expires,
        mode: mode,
      );

      checkOtpModel = CheckOtpModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'FetchCheckOTP');
      checkOtpModel = CheckOtpModel(
        status: 3,
        message: e.toString(),
      );
    }

    update();
    return checkOtpModel;
  }

  Future<void> fetchLoginWithEmail({
    required String email,
    required String pass,
  }) async {
    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    String deviceName = await DeviceInformation.deviceName;

    Response response = await _service.loginWithEmail(
      email: email,
      pass: pass,
      deviceName: deviceName,
      tokenFCM: tokenFCM,
    );

    await _resultLogin(response, 'EM');

    return;
  }

  Future<void> fetchLoginWithFacebook(String tokenFB) async {
    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    String deviceName = await DeviceInformation.deviceName;

    Response response = await _service.loginWithFacebook(
      deviceName: deviceName,
      tokenFCM: tokenFCM,
      tokenFB: tokenFB,
    );

    await _resultLogin(response, 'FB');

    return;
  }

  Future<void> fetchLoginWithGoogle({required String tokenGG, required String authTokenGG}) async {
    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    String deviceName = await DeviceInformation.deviceName;

    Response response = await _service.loginWithGoogle(
      idToken: tokenGG,
      authToken: authTokenGG,
      deviceName: deviceName,
      tokenFCM: tokenFCM,
    );

    await _resultLogin(response, 'GG');

    return;
  }

  Future<void> fetchLoginWithApple({
    required String uid,
    required String email,
    required String tokenAP,
    required String authTokenAP,
    required int? creationTime,
    required int? lastSignInTime,
  }) async {
    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    String deviceName = await DeviceInformation.deviceName;

    Response response = await _service.loginWithApple(
      uid: uid,
      email: email,
      idToken: tokenAP,
      authToken: authTokenAP,
      creationTime: creationTime,
      lastSignInTime: lastSignInTime,
      deviceName: deviceName,
      tokenFCM: tokenFCM,
    );
    await _resultLogin(response, 'AP');

    return;
  }

  Future<void> _resultLogin(Response response, String mode) async {
    Loading.dismiss();

    if (response.isOk) {
      if (response.bodyString == null || response.bodyString == '{}' || response.bodyString!.isEmpty) {
        SnackBarComponent.show(
          title: 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
          type: SnackBarType.error,
        );
        return;
      }

      resultLoginModel = ResultLoginModel.fromJson(response.body);
      update();

      bool hasError = resultLoginModel.status == 0 && (resultLoginModel.code ?? '').isEmpty;

      if (hasError) {
        SnackBarComponent.show(
          title: resultLoginModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
          type: SnackBarType.error,
        );
        return;
      }

      await _box.write(StorageKeys.mode, mode);
      await _box.write(StorageKeys.token, resultLoginModel.data!.token);
      await _box.write(StorageKeys.uid, resultLoginModel.data!.user!.id);
      await _box.write(StorageKeys.imageURL, resultLoginModel.data!.user!.imageUrl);
      await _box.write(StorageKeys.displayName, resultLoginModel.data!.user!.displayName);

      Get.offAllNamed(AppRoutes.SPLASH);
    } else {
      SnackBarComponent.show(
        title: 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
        type: SnackBarType.error,
      );
    }
  }
}

class ArgumentsMerge {
  final String email;
  final String? password;
  final String? imgUrl;
  final ModeType type;

  ArgumentsMerge({
    required this.email,
    this.password,
    this.imgUrl,
    required this.type,
  });
}
