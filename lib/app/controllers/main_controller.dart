import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_information/device_information.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/my_dialog.dart';
import '../component/snack_bar_component.dart';
import '../data/models/firebase_remote_config_login_with_social_model.dart';
import '../data/models/frc_model.dart';
import '../data/models/offline_app_model.dart';
import '../data/services/user_service.dart';
import '../routes/app_routes.dart';
import '../ui/utils/storage_keys.dart';
import 'app_lifecycle_state_controller.dart';
import 'profile_controller.dart';

class MainController extends AppLifecycleStateController {
  ProfileController profileController = Get.put(ProfileController());

  final _remoteConfig = FirebaseRemoteConfig.instance;
  final _box = GetStorage();

  FirebaseRemoteConfigLoginWithSocialModel loginWithSocialModel = FirebaseRemoteConfigLoginWithSocialModel();

  @override
  void onInit() {
    super.onInit();
    _getLoginSocial('');
    _fetchGuest();
    _fetchGetRemoteConfig();
    _fetchCheckInternetConnect();
    _fetchCheckToken();
  }

  Future<void> _fetchGuest() async {
    final prefs = await SharedPreferences.getInstance();
    String tokenFCM = prefs.getString(StorageKeys.tokenFCM) ?? '';

    String deviceName = await DeviceInformation.deviceName;

    await UserService().guest(
      deviceName: deviceName,
      tokenFCM: tokenFCM,
      os: Platform.operatingSystem,
    );

    return;
  }

  Future<void> _fetchCheckInternetConnect() async {
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      final result = await InternetAddress.lookup('google.com');

      bool value = result.isNotEmpty && result.first.rawAddress.isNotEmpty;

      if (!value) {
        SnackBarComponent.show(
          title: 'ไม่พบการเชื่อมต่ออินเทอร์เน็ต',
          message: 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ตของคุณ',
          type: SnackBarType.warning,
          duration: const Duration(minutes: 1),
        );
      }
    });

    return;
  }

  Future<void> _fetchCheckToken() async {
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      String? message = await profileController.fetchCheckStatus();

      if (message != null) {
        MyDialog.defaultDialog(
          barrierDismissible: false,
          title: 'Warning',
          content: '$message\nกรุณาเข้าสู่ระบบอีกครั้ง',
          textConfirm: 'ตกลง',
          onConfirm: () async {
            Get.back(); // close dialog

            await profileController.fetchLogout();

            Get.offAllNamed(AppRoutes.SPLASH);
            return;
          },
        );
      }
    });

    return;
  }

  Future<void> _fetchGetRemoteConfig() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: Duration.zero,
        ),
      );

      await _remoteConfig.fetchAndActivate();

      Map<String, RemoteConfigValue> result = _remoteConfig.getAll();

      result.forEach((key, value) async {
        switch (key) {
          case 'CHECK_OFFLINE_APP':
            String source = _remoteConfig.getString(key);
            await _box.write(StorageKeys.checkOfflineApp, source);
            _getOffineApp(source);
            break;

          case 'CHECK_VERSION_UPDATE':
            String source = _remoteConfig.getString(key);
            await _box.write(StorageKeys.checkVersionUpdate, source);
            await _getCheckVersion(source);
            break;

          case 'LOGIN_WITH_SOCIAL':
            String source = _remoteConfig.getString(key);
            await _box.write(StorageKeys.loginWithSocial, source);
            _getLoginSocial(source);
            break;

          //   case 'MENU_ITEMS':
          //     String source = _remoteConfig.getString(key);
          //     await _box.write(StorageKeys.menuItems, source);
          //     break;

          case 'MENU_ITEM2':
            String source = _remoteConfig.getString(key);
            await _box.write(StorageKeys.menuItems, source);
            break;

          default:
            //statements;
            break;
        }
      });
    } catch (e) {
      log('', error: e, name: 'FetchGetRemoteConfig');
    }

    return;
  }

  Future<void> _getCheckVersion(String source) async {
    var json = jsonDecode(source);
    var model = CheckVersionUpdateModel.fromJson(json);

    await _box.write(StorageKeys.disablesUpdate, model.disabled ?? false);

    /*  2.seconds.delay(() async {
      if (kReleaseMode) {
        var json = jsonDecode(source);
        var model = CheckVersionUpdateModel.fromJson(json);

        var packageInfo = await PackageInfo.fromPlatform();

        late ConvertVersionStatus versionStatus;
        versionStatus = GetPlatform.isAndroid
            ? ConvertVersionStatus(
                localVersion: _cleanVersion(packageInfo.version),
                storeVersion: _cleanVersion(model.version ?? AppInformation.defaultVersion),
                appStoreLink: model.url ?? AppInformation.urlAndroid,
              )
            : ConvertVersionStatus(
                localVersion: _cleanVersion(packageInfo.version),
                storeVersion: _cleanVersion(model.version ?? AppInformation.defaultVersion),
                appStoreLink: model.url ?? AppInformation.urliOS,
              );

        String? isNotUpdate = _box.read(StorageKeys.isNotUpdate) ?? AppInformation.defaultVersion;

        if (versionStatus.canUpdate && (isNotUpdate != versionStatus.storeVersion)) {
          _showDialogUpdateVersionApp(
            versionStatus: versionStatus,
            allowDismissal: true,
            dialogTitle: model.mata?.title,
            dialogText: model.mata?.message,
            updateButtonText: model.mata?.button,
          );
        }

        await _remoteConfig.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 10),
            minimumFetchInterval: Duration.zero,
          ),
        );
        await _remoteConfig.fetchAndActivate();
      }
    }); */

    return;
  }

  void _getOffineApp(String source) {
    var json = jsonDecode(source);
    var model = OfflineAppModel.fromJson(json);

    if (model.isOffineApp ?? false) {
      MyDialog.defaultDialog(
        barrierDismissible: false,
        title: model.mata?.title,
        content: model.mata?.message,
        onConfirm: () {
          GetPlatform.isAndroid ? SystemNavigator.pop() : exit(0);
        },
      );
    }

    return;
  }

  void _getLoginSocial(String source) {
    try {
      final _source = _box.read(StorageKeys.loginWithSocial);
      var json = jsonDecode(_source ?? source);
      loginWithSocialModel = FirebaseRemoteConfigLoginWithSocialModel.fromJson(json);
    } catch (e) {
      loginWithSocialModel.clear();
      log('', error: e, name: 'GetLoginSocial');
    }

    update();
    return;
  }

  /* void _getMenuItems(String source) {
    try {
      var json = jsonDecode(source);
      loginWithSocialModel = FirebaseRemoteConfigLoginWithSocialModel.fromJson(json);
    } catch (e) {
      loginWithSocialModel.clear();
      log('', error: e, name: 'GetLoginSocial');
    }

    update();
    return;
  } */

  // String _cleanVersion(String version) => RegExp(r'\d+\.\d+\.\d+').stringMatch(version) ?? AppInformation.defaultVersion;

  /* Future<void> _showDialogUpdateVersionApp({
    required ConvertVersionStatus versionStatus,
    String? dialogTitle,
    String? dialogText,
    String? updateButtonText = 'อัปเดต',
    bool allowDismissal = true,
    String? dismissButtonText = 'ปิด',
    VoidCallback? dismissAction,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final dialogTitleWidget = Text(dialogTitle ?? 'MFP Today เวอร์ขั่นใหม่มาแล้ว');
    final dialogTextWidget = Text(
      dialogText ?? 'อัปเดตแอปนี้ได้จาก ${packageInfo.version} ไป ${versionStatus.storeVersion}\nกรุณาอัปเดตแอปเพื่อนประสบการณ์\nการใช้งานที่ดีกว่าเดิม',
    );

    final updateButtonTextWidget = Text(updateButtonText ?? 'อัปเดต');

    updateAction() async {
      Uri uri = Uri.parse(versionStatus.appStoreLink);

      bool value = await canLaunchUrl(uri);

      value
          ? await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            )
          : throw 'Could not launch appStoreLink';

      if (allowDismissal) Get.back();
    }

    List<Widget> actions = [
      GetPlatform.isAndroid
          ? TextButton(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            )
          : CupertinoDialogAction(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(dismissButtonText ?? 'ปิด');

      dismissAction = dismissAction ?? () => Get.back();

      actions.add(
        GetPlatform.isAndroid
            ? TextButton(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              )
            : CupertinoDialogAction(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              ),
      );
    }
    var val = false.obs;

    await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(allowDismissal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetPlatform.isAndroid
                  ? AlertDialog(
                      title: dialogTitleWidget,
                      content: dialogTextWidget,
                      actions: actions,
                    )
                  : CupertinoAlertDialog(
                      title: dialogTitleWidget,
                      content: dialogTextWidget,
                      actions: actions,
                    ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 24,
                      // width: Get.width,
                      child: Obx(() => Checkbox(
                            value: val.value,
                            fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: kPrimaryColor,
                            onChanged: (value) async {
                              val.value = value!;
                              val.refresh();
                            },
                          )),
                    ),
                    const Text(
                      'อย่าแสดงอีก',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) async => val.value ? await _box.write(StorageKeys.isNotUpdate, versionStatus.storeVersion) : await _box.remove(StorageKeys.isNotUpdate));

    return;
  } */
}
