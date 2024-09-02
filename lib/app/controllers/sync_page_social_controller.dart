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
      final FacebookAuth _facebookAuth = FacebookAuth.instance;
      final LoginResult _result = await _facebookAuth.login(
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

      if (_result.status == LoginStatus.success) {
        String _tokenFB = _result.accessToken?.token ?? '';
        debugPrint('-- TokenFB: $_tokenFB');

        String _id = _result.accessToken?.userId ?? '';
        debugPrint('-- ID: $_id');

        Response response = await _service.getPageListFB(
          uid: _id,
          tokenFB: _tokenFB,
        );

        var json = jsonDecode(response.bodyString!);
        pageListFBModel = PageListFacebookModel.fromJson(json);
        update();

        for (int i = 0; i < pageListFBModel.data!.length; i++) {
          final _response = await _service.get(
            'https://graph.facebook.com/v14.0/${pageListFBModel.data![i].id}/picture?redirect=0&type=large&access_token=${pageListFBModel.data![i].accessToken}',
          );

          if (_response.body != null) {
            var _json = jsonDecode(_response.bodyString!);
            pageListFBModel.data![i].imageUrl = _json['data']['url'];
          }
        }

        debugPrint('-- Status: ${_result.status}');
        return _result.status;
      } else {
        throw Exception('LoginStatus: ${_result.status}');
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

      Response _result = await _service.selectPageFB(
        facebookPageId: facebookPageId,
        facebookPageName: facebookPageName,
        pageAccessToken: pageAccessToken,
        facebookCategory: facebookCategory,
        token: token!,
        mode: mode!,
      );

      syncPageModel = SyncPageModel.fromJson(_result.body);

      if (syncPageModel.status == 1) {
        List<String>? _pageList = _box.read(StorageKeys.pageList) ?? [];

        if (!_pageList.contains(facebookPageId)) {
          _pageList.add(facebookPageId);
          await _box.write(StorageKeys.pageList, _pageList);
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
