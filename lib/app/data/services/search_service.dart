// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';

class SearchService extends GetConnect {
  Future<String?> getMainSearch({required String keyword, required String uid}) async {
    String url = '${Environment.apiURL}/api/main/search';

    String body = jsonEncode({
      'keyword': keyword,
      'user': uid,
      'filter': {
        // TODO: implement filter
        'typePage': 'PAGE',
        // 'typeUser': 'USER',
        'typeHashTag': 'keyword',
      }
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
    };

    try {
      var response = await post(
        url,
        body,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } on Exception catch (e) {
      print('-- Error: $e');
      return null;
    }
  }

  Future<String?> postHistory({
    required String uid,
    required String deviceId,
    required String resultType,
    required String resultId,
    required String keyword,
    required String token,
  }) async {
    String url = '${Environment.apiURL}/api/history';

    String body = jsonEncode({
      'resultType': resultType,
      'resultId': resultId,
      'keyword': keyword,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
      'client-id': deviceId,
      'userid': uid,
    };

    try {
      var response = await post(
        url,
        body,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } on Exception catch (e) {
      print('-- Error: $e');
      return null;
    }
  }

  Future<String?> getHistorySearch({
    required String uid,
    required String deviceId,
    required int offset,
    required int limit,
    required List? relation,
    required bool count,
    required Map? orderBy,
    required List<String> whereConditions,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/history/search';

    String body = jsonEncode({
      'offset': offset,
      'limit': limit,
      'relation': relation,
      'count': count,
      'orderBy': orderBy,
      'whereConditions': {
        'type': whereConditions,
      },
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
      'client-id': deviceId,
      'userid': uid,
      'mode': mode,
    };

    try {
      var response = await post(
        url,
        body,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } on Exception catch (e) {
      print('-- Error: $e');
      return null;
    }
  }

  Future<String?> getContentSearch({
    required String uid,
    required List<String> keyword,
    required List<String> hashtag,
    required String type,
    required List? createBy,
    required String objective,
    required List? pageCategories,
    required int offset,
    required int limit,
  }) async {
    String url = '${Environment.apiURL}/api/main/content/search';

    String body = jsonEncode({
      'keyword': keyword,
      'hashtag': hashtag,
      'type': type,
      'createBy': createBy,
      'objective': objective,
      'pageCategories': pageCategories,
      'sortBy': 'LASTEST_DATE',
      'filter': {
        'offset': offset,
        'limit': limit,
      }
    });

    Map<String, String> query = {
      'isHideStory': 'true',
    };

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'userid': uid,
    };

    try {
      var response = await post(
        url,
        body,
        query: query,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } on Exception catch (e) {
      print('-- Error: $e');
      return null;
    }
  }

  Future<Response> getEmerTagId({required String emerTag}) async {
    String url = '${Environment.apiURL}/api/emergency/search';

    String body = jsonEncode({
      'filter': {
        'whereConditions': {
          'hashTag': emerTag,
        }
      }
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getHashTagPost({
    required String keyword,
    required String emerTag,
    required String emerTagId,
    required int limit,
    required int offset,
  }) async {
    String url = '${Environment.apiURL}/api/main/content/search';

    String body = jsonEncode({
      "keyword": [keyword],
      "hashtag": [keyword],
      "type": "",
      "emergencyEventTag": emerTag,
      "emergencyEvent": emerTagId,
      "pageCategories": [],
      "sortBy": "LASTEST_DATE",
      "filter": {
        "limit": limit,
        "offset": offset,
      }
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }
}
