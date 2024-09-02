// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:io';

import 'package:device_information/device_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/models/check_status_model.dart';
import '../data/models/check_token_page_facebook.dart';
import '../data/models/profile_user_model.dart';
import '../data/models/user_access_page_model.dart';
import '../data/services/user_service.dart';
import '../ui/utils/storage_keys.dart';

class ProfileController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  File profileImage = File('');

  @override
  Future<void> onInit() async {
    isLoading = true;
    update();

    await fetchUserAccessPage();
    await fetchProfileUser();
    await fetchUserAccess();

    isLoading = false;
    update();

    super.onInit();
  }

  ProfileModel profileModel = ProfileModel();
  UserAccessPageModel userAccessPageModel = UserAccessPageModel();
  CheckTokenPageFacebook checkTokenPageFB = CheckTokenPageFacebook();

  bool isLoading = true;

  Future<String?> fetchCheckStatus() async {
    log('fetchCheckStatus');

    try {
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      if (token.isEmpty) return null;

      Response response = await _service.checkStatus(
        token: token,
        mode: mode,
      );

      final model = CheckStatusModel.fromJson(response.body);

      await _box.write(StorageKeys.memberShip, (model.data?.user?.membership ?? false));
      await _box.write(StorageKeys.authMemberShip, (model.data?.user?.authUser?.contains('MFP') ?? false));
      await _box.write(StorageKeys.imageURL, (model.data?.user?.imageUrl));
      await _box.write(StorageKeys.displayName, (model.data?.user?.displayName));

      return model.data == null ? "User token expired." : null;
    } catch (e) {
      log('', error: e, name: 'FetchCheckStatus');
      return null;
    }
  }

  Future<ProfileModel?> fetchProfileUser() async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      if (uid.isEmpty) return null;

      Response response = await _service.getProfileUser(uid);
      profileModel.data?.imageUrl = '';
      update();

      ProfileModel model = ProfileModel.fromJson(response.body);

      if (profileModel.status == 0) return null;

      bool memberShip = model.data?.memberShip ?? false;
      debugPrint('-- MEMBER_SHIP: $memberShip', wrapWidth: 1024);

      await _box.write(StorageKeys.memberShip, memberShip);
      await _box.write(StorageKeys.imageURL, profileModel.data?.imageUrl);

      profileModel = model;
      update();

      return profileModel;
    } catch (e) {
      log('', error: e, name: 'FetchProfileUser');
      update();
      return null;
    }
  }

  Future<void> fetchUserAccess() async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      if (uid.isEmpty) return;

      String token = _box.read(StorageKeys.token) ?? '';
      if (token.isEmpty) return;

      String mode = _box.read(StorageKeys.mode) ?? '';
      if (mode.isEmpty) return;

      Response response = await _service.getUserAccess(
        uid: uid,
        token: token,
        mode: mode,
      );

      /// response body
      /* {
	      "status": 1,
	      "message": 1,
	      "data": false
      } */

      bool whiteList = response.body['message'] == 1;
      debugPrint('-- WHITE_LIST: $whiteList', wrapWidth: 1024);

      bool memberVote = response.body['data'] == true;
      debugPrint('-- MEMBER_VOTE: $memberVote', wrapWidth: 1024);

      await _box.write(StorageKeys.whiteList, whiteList);
      await _box.write(StorageKeys.allowCreate, memberVote);

      return;
    } catch (e) {
      log('', error: e, name: 'FetchUserAccess');
      return;
    }
  }

  Future<void> fetchUserAccessPage() async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.getUserAccessPage(
        uid: uid,
        token: token,
        mode: mode,
      );

      userAccessPageModel = UserAccessPageModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'FetchUserAccessPage');
    }

    update();
    return;
  }

  Future<void> fetchCheckTokenFB() async {
    try {
      checkTokenPageFB.clear();

      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.checkTokenFB(
        uid: uid,
        token: token,
        mode: mode,
      );

      checkTokenPageFB = CheckTokenPageFacebook.fromJson(response.body);

      (checkTokenPageFB.data ?? []).removeWhere((element) => element.facebookTokenExpired == false);
    } catch (e) {
      log('', error: e, name: 'FetchCheckTokenFB');
    }

    update();
    return;
  }

  Future<void> fetchRefreshTokenPageFB({
    required List<String> facebookPageId,
    required List<String> facebookPageName,
    required List<String> facebookCategory,
    required List<String> pageAccessToken,
  }) async {
    try {
      String uid = _box.read(StorageKeys.uid) ?? '';
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';

      Response response = await _service.refreshTokenPageFB(
        facebookPageId: facebookPageId,
        facebookPageName: facebookPageName,
        facebookCategory: facebookCategory,
        pageAccessToken: pageAccessToken,
        uid: uid,
        token: token,
        mode: mode,
      );

      checkTokenPageFB = CheckTokenPageFacebook.fromJson(response.body);
    } catch (e) {
      checkTokenPageFB.clear();
      printError(info: e.toString());
    }

    update();
    return;
  }

  Future<void> fetchGuest() async {
    String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

    String deviceName = await DeviceInformation.deviceName;

    await _service.guest(
      deviceName: deviceName,
      tokenFCM: tokenFCM,
      os: Platform.operatingSystem,
    );

    return;
  }

  Future<bool> fetchLogout() async {
    try {
      String token = _box.read(StorageKeys.token) ?? '';
      String mode = _box.read(StorageKeys.mode) ?? '';
      String tokenFCM = _box.read(StorageKeys.tokenFCM) ?? '';

      switch (mode) {
        case 'FB':
          await FacebookAuth.instance.logOut();
          await FirebaseAuth.instance.signOut();
          break;

        case 'GG':
          await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();
          break;

        case 'AP':
          await FirebaseAuth.instance.signOut();
          break;

        default:
          break;
      }

      Response response = await _service.getLogout(
        token: token,
        tokenFCM: tokenFCM,
        mode: mode,
      );

      StorageKeys.keysLogout.forEach((key) async {
        await _box.remove(key);
      });

      return response.isOk;
    } catch (e) {
      log('', error: e, name: 'FetchLogout');
      return false;
    }
  }
}
