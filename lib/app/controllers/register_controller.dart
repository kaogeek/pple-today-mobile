import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../data/models/province_model.dart';
import '../data/models/register_model.dart';
import '../data/services/user_service.dart';
import '../ui/utils/enum.dart';
import 'login_main_controller.dart';

class RegisterController extends GetxController {
  final _service = UserService();

  RegisterArguments? arguments = Get.arguments;

  @override
  void onInit() {
    _autoInputData();
    fetchProvince();
    super.onInit();
  }

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController cfPassTextController = TextEditingController();
  TextEditingController displayNameTextController = TextEditingController();
  TextEditingController uniqueIdTextController = TextEditingController();
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController birthdayTextController = TextEditingController();

  String errorMassage = '';
  String provinceName = '';

  bool isValidEmail = false;
  bool isChangedEmail = false;
  bool isValidPass = false;
  bool isValidConfirmPass = false;
  bool isCheckLength = false;
  bool isCheckUpperCase = false;
  bool isCheckSpecial = false;
  bool isValidUniqueId = false;
  bool isChangedUniqueId = false;
  bool isVelidateInputDetail = false;

  File profileImage = File('');

  int indexPage = 0;
  int provinceId = 0;

  ProvinceModel provinceModel = ProvinceModel();
  RegisterModel registerModel = RegisterModel();

  void onNextPage() {
    indexPage++;
    update();
  }

  void onBackPage() {
    if (arguments == null || (arguments!.type == ModeType.email)) {
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
          indexPage--;
          if (profileImage.path.isNotEmpty) {
            File(profileImage.path).deleteSync(recursive: true);
            profileImage = File('');
          }
          break;

        case 3:
          indexPage--;
          displayNameTextController.clear();
          uniqueIdTextController.clear();
          isValidUniqueId = false;
          isChangedUniqueId = false;
          firstNameTextController.clear();
          lastNameTextController.clear();
          provinceName = provinceModel.data!.first.nameTh!;
          provinceId = provinceModel.data!.first.id!;
          birthdayTextController.clear();
          break;

        default:
          Get.back();
          break;
      }
    } else {
      switch (indexPage) {
        case 1:
          indexPage--;
          break;

        default:
          Get.back();
          break;
      }
    }

    update();
  }

  final String _chars = '1234567890';
  final math.Random _rnd = math.Random();

  String _getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))),
      );

  void _autoInputData() {
    if (arguments != null && (arguments!.type != ModeType.email)) {
      profileImage = File(arguments!.imagePath);
      displayNameTextController.text = arguments!.name;
      firstNameTextController.text = arguments!.name.split(' ').first;
      lastNameTextController.text = arguments!.name.split(' ').last;
      emailTextController.text = arguments!.email;

      RegExp rex = RegExp('[ก-๙~!@#\$%^&*-.?]');
      if (rex.hasMatch(firstNameTextController.text)) {
        String _uniqueIdTextCtrl = firstNameTextController.text.replaceAll(rex, '');
        uniqueIdTextController.text = _uniqueIdTextCtrl + _getRandomString(4);
      } else {
        String _uniqueIdTextCtrl = firstNameTextController.text;
        uniqueIdTextController.text = _uniqueIdTextCtrl + _getRandomString(4);
      }
      update();
    }
  }

  Future<ProvinceModel> fetchProvince() async {
    try {
      Response response = await _service.getProvince();

      if (response.hasError) {
        provinceModel.clear();
        update();

        return provinceModel;
      }

      String result = '{ "data": ' + response.bodyString! + '}';

      var json = jsonDecode(result);

      provinceModel = ProvinceModel.fromJson(json);
      provinceModel.data!.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
      provinceModel.data!.insert(
        0,
        DataProvince(
          id: 0,
          nameTh: 'กรุณาเลือกจังหวัด',
          nameEn: 'Please select province',
        ),
      );

      provinceName = provinceModel.data!.first.nameTh!;
      provinceId = provinceModel.data!.first.id!;
    } catch (e) {
      provinceModel.clear();
      printError(info: e.toString());
    }

    update();
    return provinceModel;
  }

  Future<bool> fetchCheckUniqueId(String uniqueId) async {
    try {
      Response response = await _service.uniqueidCheck(uniqueId);

      if (response.hasError) Exception('เกิดข้อผิดพลาดในการตรวจสอบยูสเซอร์เนม');

      final json = jsonDecode(response.bodyString!);

      isValidUniqueId = json["data"] ?? json["error"] ?? false;
    } catch (e) {
      isValidUniqueId = false;
      printError(info: e.toString());
    }

    update();
    return isValidUniqueId;
  }

  Future<bool> fetchCheckEmail(String email) async {
    try {
      Response response = await _service.emailCheck(email);

      response.isOk ? isValidEmail = response.body["data"] ?? response.body["error"] ?? false : isValidEmail = false;
    } catch (e) {
      isValidEmail = false;
      log('', error: e, name: 'FetchCheckEmail');
    }

    update();
    return isValidEmail;
  }

  Future<RegisterModel> fetchRegisterWithEmail() async {
    try {
      registerModel.clear();

      Uint8List? bytes = profileImage.path.isEmpty ? null : profileImage.readAsBytesSync();

      int? sizeImage = profileImage.path.isEmpty ? null : bytes!.length;
      String? base64 = profileImage.path.isEmpty ? null : base64Encode(bytes!);
      String? fileName = profileImage.path.isEmpty ? null : basename(profileImage.path);

      Response response = await _service.registerWithEmail(
        displayName: displayNameTextController.text,
        uniqueId: uniqueIdTextController.text,
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        email: emailTextController.text,
        pass: passwordTextController.text,
        province: provinceName,
        birthdate: birthdayTextController.text,
        mimeType: 'image/jpeg',
        fileName: fileName,
        sizeImage: sizeImage,
        base64: base64,
      );

      if (response.hasError) {
        registerModel = RegisterModel(
          status: 0,
          message: 'เกิดข้อผิดพลาดในการสมัครสมาชิก',
        );
        update();

        return registerModel;
      }

      var json = jsonDecode(response.bodyString!);

      registerModel = RegisterModel.fromJson(json);
    } catch (e) {
      registerModel.clear();
      printError(info: e.toString());
    }

    update();
    return registerModel;
  }

  Future<RegisterModel> fetchRegisterWithFacebook() async {
    LoginMainController controller = Get.find();

    try {
      registerModel.clear();

      Uint8List? bytes = profileImage.path.isEmpty ? null : profileImage.readAsBytesSync();

      String? base64 = profileImage.path.isEmpty ? null : base64Encode(bytes!);

      Response response = await _service.registerWithFacebook(
        displayName: displayNameTextController.text,
        uniqueId: uniqueIdTextController.text,
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        email: emailTextController.text,
        pass: passwordTextController.text,
        province: provinceName,
        birthdate: birthdayTextController.text,
        expiresFB: controller.userDataSocialModel.expires!,
        tokenFB: controller.userDataSocialModel.idToken!,
        uid: controller.userDataSocialModel.uid!,
        mimeType: 'image/jpeg',
        base64: base64,
      );

      if (response.hasError) {
        registerModel = RegisterModel(
          status: 0,
          message: 'เกิดข้อผิดพลาดในการสมัครสมาชิก',
        );
        update();

        return registerModel;
      }

      var json = jsonDecode(response.bodyString!);

      registerModel = RegisterModel.fromJson(json);
    } catch (e) {
      registerModel.clear();
      printError(info: e.toString());
    }

    update();
    return registerModel;
  }

  Future<RegisterModel> fetchRegisterWithGoogle() async {
    LoginMainController controller = Get.find();

    try {
      registerModel.clear();

      Uint8List? bytes = profileImage.path.isEmpty ? null : profileImage.readAsBytesSync();

      String? base64 = profileImage.path.isEmpty ? null : base64Encode(bytes!);

      Response response = await _service.registerWithGoogle(
        displayName: displayNameTextController.text,
        uniqueId: uniqueIdTextController.text,
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        email: emailTextController.text,
        birthdate: birthdayTextController.text,
        token: controller.userDataSocialModel.idToken!,
        authToken: controller.userDataSocialModel.authToken!,
        uid: controller.userDataSocialModel.uid!,
        mimeType: 'image/jpeg',
        base64: base64,
      );

      if (response.hasError) {
        registerModel = RegisterModel(
          status: 0,
          message: 'เกิดข้อผิดพลาดในการสมัครสมาชิก',
        );
        update();

        return registerModel;
      }

      var json = jsonDecode(response.bodyString!);

      registerModel = RegisterModel.fromJson(json);
    } catch (e) {
      registerModel.clear();
      printError(info: e.toString());
    }

    update();
    return registerModel;
  }

  Future<RegisterModel> fetchRegisterWithApple() async {
    LoginMainController controller = Get.find();

    try {
      registerModel.clear();

      Uint8List? bytes = profileImage.path.isEmpty ? null : profileImage.readAsBytesSync();

      String? base64 = profileImage.path.isEmpty ? null : base64Encode(bytes!);

      Response response = await _service.registerWithApple(
        displayName: displayNameTextController.text,
        uniqueId: uniqueIdTextController.text,
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        email: emailTextController.text,
        birthdate: birthdayTextController.text,
        token: controller.userDataSocialModel.idToken!,
        authToken: controller.userDataSocialModel.authToken!,
        emailHide: controller.userDataSocialModel.email,
        uid: controller.userDataSocialModel.uid!,
        mimeType: 'image/jpeg',
        base64: base64,
      );

      if (response.hasError) {
        registerModel = RegisterModel(
          status: 0,
          message: 'เกิดข้อผิดพลาดในการสมัครสมาชิก',
        );
        update();

        return registerModel;
      }

      var json = jsonDecode(response.bodyString!);

      registerModel = RegisterModel.fromJson(json);
    } catch (e) {
      registerModel.clear();
      printError(info: e.toString());
    }

    update();
    return registerModel;
  }
}

class RegisterArguments {
  final ModeType type;
  final String email;
  final String name;
  final String imagePath;

  RegisterArguments({
    required this.type,
    required this.email,
    required this.name,
    required this.imagePath,
  });
}
