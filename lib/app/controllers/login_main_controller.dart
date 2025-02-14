import 'dart:developer';
import 'dart:io';

// import 'package:device_information/device_information.dart';
import 'package:app_settings/app_settings.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../component/convert_image_component.dart';
import '../component/loading.dart';
import '../component/my_dialog.dart';
import '../component/snack_bar_component.dart';
import '../data/models/check_email_user_model.dart';
import '../data/models/login_email_model.dart';
import '../data/models/result_login_model.dart';
import '../data/models/user_data_social_model.dart';
import '../data/services/user_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/assets.dart';
import '../ui/utils/colors.dart';
import '../ui/utils/enum.dart';
import '../ui/utils/storage_keys.dart';
import 'account_merge_controller.dart';
import 'register_controller.dart';

class LoginMainController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  LoginWithEmailModel loginEmailModel = LoginWithEmailModel();
  ResultLoginModel resultLoginModel = ResultLoginModel();
  CheckEmailUserModel checkEmailUserModel = CheckEmailUserModel();
  UserDataSocialModel userDataSocialModel = UserDataSocialModel();

  ModeType? loginMode;

  bool hidePass = true;
  bool isValidateLogin = false;

  String errorCode = '';

  Future<int> fetchCheckEmailUser({
    required ModeType mode,
    String? email,
    String? pass,
    String? uid,
    String? tokenFB,
    String? tokenSecretTW,
    String? idToken,
    String? authToken,
  }) async {
    checkEmailUserModel.clear();
    update();

    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';
    // String deviceName = await DeviceInformation.deviceName;

    try {
      Response response = await _service.checkEmailUser(
        mode: mode,
        email: email,
        pass: pass,
        uid: uid,
        tokenSecretTW: tokenSecretTW,
        deviceName: 'deviceName',
        tokenFB: tokenFB,
        tokenFCM: tokenFCM,
        idToken: idToken,
        authToken: authToken,
      );
      debugPrint("response.body : ${response.body}", wrapWidth: 1024);

      checkEmailUserModel = CheckEmailUserModel.fromJson(response.body);

      if (checkEmailUserModel.status == 4) {
        checkEmailUserModel.message = 'ขออภัย มีบางอย่างผิดพลาด';
      }
    } catch (e) {
      checkEmailUserModel = CheckEmailUserModel(
        status: 4,
        message: e.toString(),
      );
      printError(info: e.toString());
    }

    update();
    return checkEmailUserModel.status ?? 4;
  }

  Future<LoginWithEmailModel> fetchLoginWithEmail({
    required String email,
    required String pass,
  }) async {
    try {
      loginEmailModel.clear();
      update();

      //   String deviceName = await DeviceInformation.deviceName;
      String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

      Response response = await _service.loginWithEmail(
        email: email,
        pass: pass,
        deviceName: 'deviceName',
        tokenFCM: tokenFCM,
      );

      if (response.hasError) {
        loginEmailModel = LoginWithEmailModel(
          status: 0,
          message: 'ขออภัย มีบางอย่างผิดพลาด',
        );
        update();

        return loginEmailModel;
      }

      loginEmailModel = LoginWithEmailModel.fromJson(response.body);

      if (loginEmailModel.status == 1) {
        await _box.write(StorageKeys.mode, 'EM');
        await _box.write(StorageKeys.memberShip, loginEmailModel.data?.user?.membership);
        await _box.write(StorageKeys.authMemberShip, (loginEmailModel.data?.user?.authUser?.contains('MFP') ?? false));
        await _box.write(StorageKeys.token, loginEmailModel.data?.token);
        await _box.write(StorageKeys.uid, loginEmailModel.data?.user?.id);
        await _box.write(StorageKeys.imageURL, loginEmailModel.data?.user?.imageUrl);
        await _box.write(StorageKeys.displayName, loginEmailModel.data?.user?.displayName);
      } else {
        Exception(response.bodyString);
      }
    } catch (e) {
      loginEmailModel.clear();
      printError(info: e.toString());
    }

    update();
    return loginEmailModel;
  }

  Future<void> fetchLoginWithFacebook() async {
    final userFB = await _firebaseLoginWithFacebook();

    if (errorCode.isNotEmpty) {
      SnackBarComponent.show(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถเข้าสู่ระบบได้',
        type: SnackBarType.error,
      );
      return;
    }

    if ((userFB.idToken ?? '').isEmpty) {
      Loading.dismiss();
      return;
    }

    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    // String deviceName = await DeviceInformation.deviceName;

    if ((userFB.email ?? '').isEmpty) {
      int? status = await fetchCheckEmailUser(
        tokenFB: userFB.idToken,
        mode: ModeType.facebook,
      );

      switch (status) {
        case 0:
          await _popUpInputEmail();

          if (emailTextController.text.isEmpty) {
            Loading.dismiss();
            return;
          } else {
            userFB.email = emailTextController.text;

            int? status0 = await fetchCheckEmailUser(
              email: userFB.email,
              tokenFB: userFB.idToken,
              mode: ModeType.facebook,
            );

            Loading.dismiss();

            switch (status0) {
              case 0:
                Get.toNamed(
                  AppRoutes.REGISTER,
                  arguments: RegisterArguments(
                    imagePath: userFB.imagePath ?? '',
                    name: userFB.name ?? '',
                    email: userFB.email ?? '',
                    type: ModeType.facebook,
                  ),
                );
                return;

              case 2:
                Get.toNamed(
                  AppRoutes.ACCOUNT_MERGE,
                  arguments: ArgumentsMerge(
                    email: userFB.email ?? '',
                    imgUrl: userFB.imageUrl ?? '',
                    type: ModeType.facebook,
                  ),
                );
                return;

              default:
                SnackBarComponent.show(
                  title: checkEmailUserModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
                  type: SnackBarType.error,
                );
                return;
            }
          }

        case 1:
          Response response = await _service.loginWithFacebook(
            deviceName: 'deviceName',
            tokenFCM: tokenFCM,
            tokenFB: userFB.idToken,
          );

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

            bool hasError = (resultLoginModel.status == 0 && (resultLoginModel.code ?? '').isEmpty) || resultLoginModel.data == null;

            if (hasError) {
              MyDialog.defaultDialog(
                content: resultLoginModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
              );
              return;
            }

            await _box.write(StorageKeys.mode, 'FB');
            await _box.write(StorageKeys.token, resultLoginModel.data!.token);
            await _box.write(StorageKeys.uid, resultLoginModel.data!.user!.id);
            await _box.write(StorageKeys.imageURL, resultLoginModel.data!.user!.imageUrl);
            await _box.write(StorageKeys.displayName, resultLoginModel.data!.user!.displayName);

            Get.offAllNamed(AppRoutes.SPLASH);

            return;
          } else {
            SnackBarComponent.show(
              title: 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
              type: SnackBarType.error,
            );
            return;
          }

        default:
          Loading.dismiss();
          SnackBarComponent.show(
            title: checkEmailUserModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
            type: SnackBarType.error,
          );
          return;
      }
    } else {
      int? status = await fetchCheckEmailUser(
        email: userFB.email,
        tokenFB: userFB.idToken,
        mode: ModeType.facebook,
      );
      debugPrint("status : $status", wrapWidth: 1024);

      switch (status) {
        case 0:
          Loading.dismiss();
          Get.toNamed(
            AppRoutes.REGISTER,
            arguments: RegisterArguments(
              imagePath: userFB.imagePath ?? '',
              name: userFB.name ?? '',
              email: userFB.email ?? '',
              type: ModeType.facebook,
            ),
          );
          return;

        case 1:
          Response response = await _service.loginWithFacebook(
            deviceName: 'deviceName',
            tokenFCM: tokenFCM,
            tokenFB: userFB.idToken,
          );

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

            bool hasError = (resultLoginModel.status == 0 && (resultLoginModel.code ?? '').isEmpty) || resultLoginModel.data == null;

            if (hasError) {
              MyDialog.defaultDialog(
                content: resultLoginModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
              );
              return;
            }

            await _box.write(StorageKeys.mode, 'FB');
            await _box.write(StorageKeys.token, resultLoginModel.data!.token);
            await _box.write(StorageKeys.uid, resultLoginModel.data!.user!.id);
            await _box.write(StorageKeys.imageURL, resultLoginModel.data!.user!.imageUrl);
            await _box.write(StorageKeys.displayName, resultLoginModel.data!.user!.displayName);

            Get.offAllNamed(AppRoutes.SPLASH);

            return;
          } else {
            SnackBarComponent.show(
              title: 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
              type: SnackBarType.error,
            );
            return;
          }

        case 2:
          Loading.dismiss();
          Get.toNamed(
            AppRoutes.ACCOUNT_MERGE,
            arguments: ArgumentsMerge(
              email: userFB.email ?? '',
              imgUrl: userFB.imageUrl ?? '',
              type: ModeType.facebook,
            ),
          );
          return;

        default:
          Loading.dismiss();
          SnackBarComponent.show(
            title: () {
              if ((checkEmailUserModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ').toUpperCase().contains('NULL')) {
                return 'ขออภัย มีบางอย่างผิดพลาดในระบบ';
              }

              return checkEmailUserModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ';
            }(),
            type: SnackBarType.error,
          );
          return;
      }
    }
  }

  Future<UserDataSocialModel> _firebaseLoginWithFacebook() async {
    try {
      userDataSocialModel.clear();
      errorCode = '';
      update();

      if (Platform.isIOS) {
        TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;

        // debugPrint("trackingAuth", wrapWidth: 1024);
        if (status == TrackingStatus.notDetermined) {
          //   debugPrint("request", wrapWidth: 1024);
          status = await AppTrackingTransparency.requestTrackingAuthorization();
        } else {
          if (status != TrackingStatus.authorized) {
            await Get.dialog(
              AlertDialog(
                title: Text(
                  'การตั้งค่าความเป็นส่วนตัว',
                  style: TextStyle(
                    fontSize: Get.context!.isPhone ? 16 : 24,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                content: Text(
                  'เพื่อให้แอปพลิเคชันสามารถใช้งานได้อย่างเต็มประสิทธิภาพ กรุณาเปิดการใช้งานการติดตามข้อมูลในการตั้งค่าของอุปกรณ์',
                  style: TextStyle(
                    fontSize: Get.context!.isPhone ? 18 : 26,
                    fontFamily: Assets.assetsFontsAnakotmaiLight,
                    color: Colors.black54,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(
                        fontSize: Get.context!.isPhone ? 16 : 24,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Get.back();

                      await AppSettings.openAppSettings(type: AppSettingsType.settings);
                    },
                    child: Text(
                      'ตั้งค่า',
                      style: TextStyle(
                        fontSize: Get.context!.isPhone ? 16 : 24,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        color: kPrimaryColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );

            return userDataSocialModel;
          }
        }
      }

      Loading.show();

      final firebaseAuth = FirebaseAuth.instance;
      final facebookAuth = FacebookAuth.instance;

      await firebaseAuth.signOut();
      await facebookAuth.logOut();

      final result = await facebookAuth.login(
        permissions: ['email', 'public_profile'],
        loginTracking: LoginTracking.enabled,
      );

      if (result.status == LoginStatus.success) {
        final tokenFB = result.accessToken?.tokenString ?? '';
        debugPrint("tokenFB : $tokenFB", wrapWidth: 1024);

        if (tokenFB.isEmpty) return userDataSocialModel;

        OAuthCredential credential = FacebookAuthProvider.credential(tokenFB);

        await firebaseAuth.signInWithCredential(credential);

        final profile = await facebookAuth.getUserData().timeout(const Duration(seconds: 10));
        final id = profile['id'];
        final name = profile['name'];
        final email = profile['email'];
        final imageUrl = profile['picture']['data']['url'];

        File imageFile = await ConvertImageComponent.imageNetworkToFile(
          imageUrl,
        );
        int expires = 100000;

        debugPrint('-- mode: FACEBOOK');
        debugPrint('-- name: $name');
        debugPrint('-- email: $email');
        debugPrint('-- imageUrl: $imageUrl');
        debugPrint('-- imagePath: ${imageFile.path}');
        debugPrint('-- expires: $expires');

        userDataSocialModel = UserDataSocialModel(
          uid: id,
          name: name,
          email: email,
          imageUrl: imageUrl,
          imagePath: imageFile.path,
          idToken: tokenFB,
          expires: expires,
          mode: ModeType.facebook,
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("e.code : ${e.code}", wrapWidth: 1024);
      debugPrint("e.message : ${e.message}", wrapWidth: 1024);
      switch (e.code) {
        case "account-exists-with-different-credential":
          errorCode = "You already have an account with us. Use correct provider";
          break;

        case 'invalid-credential':
          errorCode = 'Error occurred while accessing credentials. Try again.';
          break;

        case "null":
          errorCode = "Some unexpected error while trying to sign in";
          break;

        default:
          errorCode = e.toString();
          break;
      }
    } catch (e) {
      debugPrint("An unexpected error occurred: $e");
    } finally {
      Loading.dismiss();
    }

    update();
    return userDataSocialModel;
  }

  Future<void> _popUpInputEmail() async {
    emailTextController.clear();

    return await Get.defaultDialog(
        title: 'อีเมลของคุณ',
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            width: Get.width,
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
              controller: emailTextController,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'อีเมล',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
        textConfirm: 'ยืนยัน',
        textCancel: 'ยกเลิก',
        confirmTextColor: kPrimaryColor,
        cancelTextColor: Colors.black,
        buttonColor: Colors.white,
        onConfirm: () {
          Get.back();
          return;
        },
        onCancel: () {
          emailTextController.clear();
          update();
          Get.back();
          return;
        });
  }

  Future<void> fetchLoginWithGoogle() async {
    Loading.show();

    final userGG = await _firebaseLoginWithGoogle();

    if (errorCode.isNotEmpty) {
      Loading.dismiss();
      SnackBarComponent.show(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถเข้าสู่ระบบได้',
        type: SnackBarType.error,
      );
      return;
    }

    if ((userGG.idToken ?? '').isEmpty) {
      Loading.dismiss();
      return;
    }

    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    // String deviceName = await DeviceInformation.deviceName;

    if ((userGG.email ?? '').isEmpty) {
      await _popUpInputEmail();

      if (emailTextController.text.isEmpty) {
        Loading.dismiss();
        return;
      } else {
        userGG.email = emailTextController.text;
      }
    }

    int? status = await fetchCheckEmailUser(
      email: userGG.email,
      idToken: userGG.idToken,
      authToken: userGG.authToken,
      mode: ModeType.google,
    );

    switch (status) {
      case 0:
        Loading.dismiss();
        Get.toNamed(
          AppRoutes.REGISTER,
          arguments: RegisterArguments(
            imagePath: userGG.imagePath!,
            name: userGG.name!,
            email: userGG.email!,
            type: ModeType.google,
          ),
        );
        return;

      case 1:
        Response response = await _service.loginWithGoogle(
          idToken: userGG.idToken,
          authToken: userGG.authToken,
          deviceName: 'deviceName',
          tokenFCM: tokenFCM,
        );

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
            MyDialog.defaultDialog(
              content: resultLoginModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
            );
            return;
          }

          await _box.write(StorageKeys.mode, 'GG');
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
          return;
        }

        return;

      case 2:
        Loading.dismiss();
        Get.toNamed(
          AppRoutes.ACCOUNT_MERGE,
          arguments: ArgumentsMerge(
            email: userGG.email!,
            imgUrl: userGG.imageUrl!,
            type: ModeType.google,
          ),
        );
        return;

      default:
        Loading.dismiss();
        SnackBarComponent.show(
          title: checkEmailUserModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
          type: SnackBarType.error,
        );
        return;
    }
  }

  Future<UserDataSocialModel> _firebaseLoginWithGoogle() async {
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    userDataSocialModel.clear();
    errorCode = '';
    update();

    try {
      final GoogleSignInAccount? googleSingInAccount = await googleSignIn.signIn();

      if (googleSingInAccount != null) {
        final GoogleSignInAuthentication googleSingInAuthentication = await googleSingInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSingInAuthentication.accessToken,
          idToken: googleSingInAuthentication.idToken,
        );

        final userDetail = (await firebaseAuth.signInWithCredential(credential)).user!;

        File imageFile = await ConvertImageComponent.imageNetworkToFile(
          userDetail.photoURL!,
        );

        debugPrint('-- provider: GOOGLE');
        debugPrint('-- IdToken: ${googleSingInAuthentication.idToken}');
        debugPrint('-- authToken: ${googleSingInAuthentication.accessToken}');
        debugPrint('-- name: ${userDetail.displayName}');
        debugPrint('-- uid: ${userDetail.uid}');
        debugPrint('-- email: ${userDetail.email ?? userDetail.providerData.first.email}');
        debugPrint('-- imageUrl: ${userDetail.photoURL}');
        debugPrint('-- imagePath: ${imageFile.path}');

        userDataSocialModel = UserDataSocialModel(
          name: userDetail.displayName,
          uid: userDetail.uid,
          email: userDetail.email ?? userDetail.providerData.first.email,
          imageUrl: userDetail.photoURL,
          imagePath: imageFile.path,
          idToken: googleSingInAuthentication.idToken,
          authToken: googleSingInAuthentication.accessToken,
          mode: ModeType.google,
        );
      }
    } on FirebaseAuthException catch (e) {
      log('', error: e, name: 'FirebaseAuthException: firebaseLoginWithGoogle');

      if (e.code == 'account-exists-with-different-credential') {
        switch (e.code) {
          case 'account-exists-with-different-credential':
            errorCode = 'You already have an account with us. Use correct provider';
            break;

          case 'invalid-credential':
            errorCode = 'Error occurred while accessing credentials. Try again.';
            break;

          case 'null':
            errorCode = 'Some unexpected error while trying to sing in';
            break;

          default:
            errorCode = e.toString();
            break;
        }
      }
    } catch (e) {
      log('', error: e, name: 'firebaseLoginWithGoogle');
      errorCode = 'Error occurred using Google Sign In. Try again.';
    }

    update();
    return userDataSocialModel;
  }

  Future<void> fetchLoginWithApple() async {
    Loading.show();

    final userAP = await _firebaseLoginWithApple();

    if (errorCode.isNotEmpty) {
      Loading.dismiss();
      SnackBarComponent.show(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถเข้าสู่ระบบได้',
        type: SnackBarType.error,
      );
      return;
    }

    if ((userAP.uid ?? '').isEmpty) {
      Loading.dismiss();
      return;
    }

    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    // String deviceName = await DeviceInformation.deviceName;

    /* if ((_userAP.email ?? '').contains('@privaterelay.appleid.com')) {
      _userAP.email = '${_userAP.uid}@privaterelay.appleid.com';
    } */

    /* if ((_userAP.email ?? '').contains('@privaterelay.appleid.com')) {
      await _popUpInputEmail();

      if (emailTextController.text.trim().isEmpty) {
        Loading.dismiss();

        await MyDialog.defaultDialog(
          barrierDismissible: false,
          content: 'กรุณากรอกอีเมลของคุณ',
        );
        return;
      } else if (!emailTextController.text.trim().isEmail) {
        Loading.dismiss();

        await MyDialog.defaultDialog(
          barrierDismissible: false,
          content: 'กรุณากรอกอีเมลให้ถูกต้อง',
        );
        return;
      } else {
        _userAP.email = emailTextController.text;
      }
    } */

    int? status = await fetchCheckEmailUser(
      email: userAP.email,
      idToken: userAP.idToken,
      uid: userAP.uid,
      mode: ModeType.apple,
    );

    switch (status) {
      case 0:
        Loading.dismiss();
        Get.toNamed(
          AppRoutes.REGISTER,
          arguments: RegisterArguments(
            imagePath: userAP.imagePath!,
            name: userAP.name!.isEmpty ? 'Today_user' : userAP.name!,
            email: userAP.email!,
            type: ModeType.apple,
          ),
        );
        return;

      case 1:
        Response response = await _service.loginWithApple(
          uid: userAP.uid,
          email: userAP.email,
          idToken: userAP.idToken,
          authToken: userAP.authToken,
          creationTime: userAP.creationTime,
          lastSignInTime: userAP.lastSignInTime,
          deviceName: 'deviceName',
          tokenFCM: tokenFCM,
        );

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
            MyDialog.defaultDialog(
              content: resultLoginModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
            );
            return;
          }

          await _box.write(StorageKeys.mode, 'AP');
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
          return;
        }

        return;

      case 2:
        Loading.dismiss();
        Get.toNamed(
          AppRoutes.ACCOUNT_MERGE,
          arguments: ArgumentsMerge(
            email: userAP.email!,
            imgUrl: userAP.imageUrl!,
            type: ModeType.apple,
          ),
        );
        return;

      default:
        Loading.dismiss();
        SnackBarComponent.show(
          title: checkEmailUserModel.message ?? 'ขออภัย มีบางอย่างผิดพลาดในระบบ',
          type: SnackBarType.error,
        );
        return;
    }
  }

  Future<UserDataSocialModel> _firebaseLoginWithApple() async {
    final firebaseAuth = FirebaseAuth.instance;

    userDataSocialModel.clear();
    errorCode = '';
    update();

    bool available = await SignInWithApple.isAvailable();

    if (available) {
      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        final OAuthProvider authProvider = OAuthProvider('apple.com');
        final OAuthCredential authCredential = authProvider.credential(
          idToken: credential.identityToken,
          accessToken: credential.authorizationCode,
        );

        final userCredential = await firebaseAuth.signInWithCredential(authCredential);

        final userDetail = userCredential.user!;

        String displayName = userDetail.displayName ?? userDetail.providerData.first.displayName ?? '';
        String email = credential.email ?? userDetail.email ?? userDetail.providerData.first.email ?? '';
        String photoURL = userDetail.photoURL ?? userDetail.providerData.first.photoURL ?? '';
        File imageFile = File('');
        int creationTime = userDetail.metadata.creationTime!.millisecondsSinceEpoch;
        int lastSignInTime = userDetail.metadata.lastSignInTime!.millisecondsSinceEpoch;

        if (photoURL.isNotEmpty) {
          imageFile = await ConvertImageComponent.imageNetworkToFile(
            userDetail.photoURL!,
          );
        }

        debugPrint('-- mode: APPLE');
        debugPrint('-- Token: ${authCredential.accessToken}');
        debugPrint('-- name: $displayName');
        debugPrint('-- uid: ${userDetail.uid}');
        debugPrint('-- email: $email');
        debugPrint('-- imageUrl: $photoURL');
        debugPrint('-- imagePath: ${imageFile.path}');

        userDataSocialModel = UserDataSocialModel(
          name: displayName,
          uid: userDetail.uid,
          email: email,
          idToken: authCredential.idToken,
          authToken: authCredential.accessToken,
          imageUrl: photoURL,
          imagePath: imageFile.path,
          creationTime: creationTime,
          lastSignInTime: lastSignInTime,
          mode: ModeType.apple,
        );
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            errorCode = "You already have an account with us. Use correct provider";
            break;

          case 'invalid-credential':
            errorCode = 'Error occurred while accessing credentials. Try again.';
            break;

          case "null":
            errorCode = "Some unexpected error while trying to sign in";
            break;

          default:
            errorCode = e.toString();
            break;
        }
      } catch (e) {
        // errorCode.value = e.toString();
      }
    }
    //  else {
    //   errorCode.value = "This Device is not eligible for Apple Sign in";
    // }

    update();
    return userDataSocialModel;
  }
}
