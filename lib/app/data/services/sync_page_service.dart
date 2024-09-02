// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';

class SyncPageService extends GetConnect {
  Future<Response> getPageListFB({
    required String uid,
    required String tokenFB,
  }) async {
    String url = 'https://graph.facebook.com/v14.0/$uid/accounts';

    Map<String, dynamic> query = {
      'access_token': tokenFB,
    };

    Response response = await get(
      url,
      query: query,
    );

    return response;
  }

  Future<Response> selectPageFB({
    required String facebookPageId,
    required String facebookPageName,
    required String pageAccessToken,
    required String facebookCategory,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/page/sync/fb';

    String body = jsonEncode({
      'facebookPageId': facebookPageId,
      'facebookPageName': facebookPageName,
      'pageAccessToken': pageAccessToken,
      'facebookCategory': facebookCategory,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
      'mode': mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<String?> syncPageTwitter({
    required String authTokenTW,
    required String tokenSecretTW,
    required String uidTW,
    required String pageNameTW,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/page/sync/tw';

    String body = jsonEncode({
      'twitterOauthToken': authTokenTW,
      'twitterTokenSecret': tokenSecretTW,
      'twitterUserId': uidTW,
      'twitterPageName': pageNameTW,
    });

    Map<String, String> headers = {
      'Content-Type': defaultContentType,
      'Authorization': 'Bearer $token',
      'mode': mode,
    };

    try {
      final response = await post(
        url,
        body,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } catch (e) {
      printError(info: e.toString());
      return null;
    }
  }

  /* Future<String?> facebookEnable({
    required String pageId,
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/page/$pageId/facebook_fetch_enable';

    String body = jsonEncode({
      'value': true,
      'type': 'boolean',
    });

    Map<String, String> headers = {
      'Content-Type': defaultContentType,
      'Authorization': 'Bearer $token',
      'userid': uid,
      'mode': mode,
    };

    try {
      final response = await post(
        url,
        body,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } catch (e) {
      printError(info: e.toString());
      return null;
    }
  } */
}
