// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';

class PageService extends GetConnect {
  Future<String?> getPage({
    required String pageId,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/page/$pageId';

    Map<String, String> headers = {
      'userid': uid,
      'mode': mode,
    };

    try {
      var response = await get(
        url,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } on Exception catch (e) {
      print('-- Error: $e');
      return null;
    }
  }

  Future<Response> getPagePostSearch({
    required String pageId,
    required String type,
    required int offset,
    required int limit,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/page/$pageId/post/search';

    String body = jsonEncode({
      'type': type,
      'offset': offset,
      'limit': limit,
    });

    Map<String, String> query = {
      'isHideStory': 'true',
    };

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'userid': uid,
      'mode': mode,
    };

    Response response = await post(
      url,
      body,
      query: query,
      headers: headers,
    );

    return response;
  }

  Future<Response> updatePage({
    required String pageId,
    required String token,
    required String uid,
    required String mode,
    String? pageName,
    String? pageUsername,
    String? backgroundStory,
    String? lineId,
    String? facebookURL,
    String? twitterURL,
    String? websiteURL,
    String? email,
  }) async {
    String url = '${Environment.apiURL}/api/page/$pageId';

    String body = jsonEncode({
      'name': pageName,
      'pageUsername': pageUsername,
      'backgroundStory': backgroundStory,
      'lineId': lineId,
      'facebookURL': facebookURL,
      'twitterURL': twitterURL,
      'websiteURL': websiteURL,
      'email': email,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
      'userid': uid,
      'mode': mode,
    };

    Response response = await put(
      url,
      body,
      headers: headers,
    );

    return response;
  }
}
