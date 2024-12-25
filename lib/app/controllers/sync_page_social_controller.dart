import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/page_list_fb_mode.dart';
import '../data/models/sync_page_model.dart';
import '../data/services/sync_page_service.dart';
import '../ui/utils/storage_keys.dart';

class SyncPageSocialController extends GetxController {
  final _service = SyncPageService();
  final _box = GetStorage();

  bool backButton = Get.arguments['BACK_BUTTON'] ?? false;
  bool skipButton = Get.arguments['SKIP_BUTTON'] ?? false;

  PageListFacebookModel pageListFBModel = PageListFacebookModel();
  SyncPageModel syncPageModel = SyncPageModel();

  Future<LoginStatus> loginFacebook() async {
    try {
      final FacebookAuth facebookAuth = FacebookAuth.instance;
      final LoginResult result = await facebookAuth.login(
        loginBehavior: LoginBehavior.webOnly,
        permissions: const [
          'email',
          'public_profile',
          'pages_manage_metadata',
          'pages_manage_posts',
          'pages_show_list',
          'pages_read_engagement',
        ],
      );

      if (result.status == LoginStatus.success) {
        String tokenFB = result.accessToken?.tokenString ?? '';
        debugPrint('-- TokenFB: $tokenFB');

        final userData = await FacebookAuth.instance.getUserData();

        String id = userData['id'];
        debugPrint('-- ID: $id');

        Response response = await _service.getPageListFB(
          uid: id,
          tokenFB: tokenFB,
        );

        var json = jsonDecode(response.bodyString!);
        pageListFBModel = PageListFacebookModel.fromJson(json);
        update();

        for (int i = 0; i < pageListFBModel.data!.length; i++) {
          final response0 = await _service.get(
            'https://graph.facebook.com/v15.0/${pageListFBModel.data![i].id}/picture?redirect=0&type=large&access_token=${pageListFBModel.data![i].accessToken}',
          );

          if (response0.body != null) {
            var json0 = jsonDecode(response0.bodyString!);
            pageListFBModel.data![i].imageUrl = json0['data']['url'];
          }
        }

        debugPrint('-- Status: ${result.status}');
        return result.status;
      } else {
        throw Exception('LoginStatus: ${result.status}');
      }
    } catch (e) {
      log('', error: e, name: 'SyncPageSocialController.loginFacebook');
      return LoginStatus.failed;
    }
  }

  Future<SyncPageModel> fetchSyncPageFB({
    required String facebookPageId,
    required String facebookPageName,
    required String pageAccessToken,
    required String facebookCategory,
  }) async {
    try {
      String? token = _box.read(StorageKeys.token);
      String? mode = _box.read(StorageKeys.mode);

      syncPageModel.clear();

      Response result = await _service.selectPageFB(
        facebookPageId: facebookPageId,
        facebookPageName: facebookPageName,
        pageAccessToken: pageAccessToken,
        facebookCategory: facebookCategory,
        token: token!,
        mode: mode!,
      );

      syncPageModel = SyncPageModel.fromJson(result.body);

      if (syncPageModel.status == 1) {
        List<String>? pageList = _box.read(StorageKeys.pageList) ?? [];

        if (!pageList.contains(facebookPageId)) {
          pageList.add(facebookPageId);
          await _box.write(StorageKeys.pageList, pageList);
        }
      }
    } catch (e) {
      log('', error: e, name: 'SyncPageSocialController.fetchSyncPageFB');
      syncPageModel = SyncPageModel(
        status: 0,
        message: e.toString(),
      );
    }

    update();
    return syncPageModel;
  }
}
