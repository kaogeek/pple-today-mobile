// ignore_for_file: must_be_immutable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../config/app_information.dart';
import '../../../data/services/dependency_injection.dart';
import '../../../routes/app_routes.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/storage_keys.dart';
import 'widgets/animated_splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  Future<void> onInit() async {
    Intl.defaultLocale = 'th';
    await initializeDateFormatting();

    // await dotenv.load(fileName: Environment.fileName);

    await GetStorage.init();

    // await Firebase.initializeApp();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? _tokenFCM = await firebaseMessaging.getToken();

    if (GetPlatform.isIOS) {
      String? apnsToken = await firebaseMessaging.getAPNSToken();
      debugPrint('\n-- APNSToken: $apnsToken\n');
    }

    await GetStorage().write(StorageKeys.tokenFCM, _tokenFCM);
    debugPrint('-- TokenFCM: $_tokenFCM\n');

    String token = GetStorage().read(StorageKeys.token) ?? '';
    debugPrint('-- TOKEN: $token\n');

    String uid = GetStorage().read(StorageKeys.uid) ?? '';
    debugPrint('-- USER_ID: $uid\n');

    await GetStorage().remove(StorageKeys.initLink);
    await GetStorage().remove(StorageKeys.isLoading);

    DependecyInjection.init();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      backgroundColor: kPrimaryColor,
      //   TODO: Change the logoPath to your own logo
      //   logoPath: Assets.images.mfpLogoHorizontalWhiteMinPNG,
      logoPath: Assets.assetsIconPpleTransparentW,
      subtitle: AppInformation.allRightsReserve,
      onInit: onInit,
      duration: 2000,
      home: AppRoutes.DASHBOARD,
    );
  }
}
