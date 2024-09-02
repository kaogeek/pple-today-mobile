// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';

class TodayService extends GetConnect {
  Future<Response> getAnnouncementEnable() async {
    String url = '${Environment.apiURL}/api/config/kaokaiToday.link.announcement.enable';

    Response response = await get(url);

    return response;
  }

  Future<Response> getAnnouncementText() async {
    String url = '${Environment.apiURL}/api/config/kaokaiToday.announcement';

    Response response = await get(url);

    return response;
  }

  Future<Response> getAnnouncementLink() async {
    String url = '${Environment.apiURL}/api/config/kaokaiToday.link.announcement';

    Response response = await get(url);

    return response;
  }

  Future<Response> getMainContent({DateTime? date}) async {
    int stimestamp = 0;

    if (date != null) stimestamp = date.microsecondsSinceEpoch ~/ 1000;

    String url = '${Environment.apiURL}/api/main/content/v3';

    Response response = await get(url, query: {
      if (date != null) "date": stimestamp.toString(),
    }).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException('The connection has timed out, Please try again!');
      },
    );

    return response;
  }

  Future<Response> getMainContentMobile() async {
    String url = '${Environment.apiURL}/api/main/content/mobile';

    Response response = await get(url).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException('The connection has timed out, Please try again!');
      },
    );

    return response;
  }

  Future<String?> getPostStory({
    required int offset,
    required int limit,
    required String uid,
  }) async {
    String url = '${Environment.apiURL}/api/main/content/search';

    String body = jsonEncode({
      // 'keyword': [''],
      // 'hashtag': [''],
      // 'type': '',
      // 'createBy': [],
      // 'objective': '',
      // 'endActionCount': 16,
      // 'pageCategories': [],
      'sortBy': 'LASTEST_DATE',
      'isOfficial': true,
      'filter': {
        'offset': offset,
        'limit': limit,
      }
    });

    Map<String, dynamic> query = {
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

  Future<String?> getStory({
    required String postId,
    required String uid,
  }) async {
    String url = '${Environment.apiURL}/api/post/search';

    String body = jsonEncode({
      'limit': 10,
      'count': false,
      'whereConditions': {
        '_id': postId,
      },
    });

    Map<String, dynamic> query = {
      'isHideStory': 'false',
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

  Future<String?> postSearch({
    required String postId,
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/post/search';

    String body = jsonEncode({
      'limit': 10,
      'count': false,
      'whereConditions': {
        '_id': postId,
      },
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'accept': defaultContentType,
      'authorization': 'Bearer $token',
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

  Future<Response> isLike({
    required String postId,
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/post/$postId/like';

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'accept': defaultContentType,
      'authorization': 'Bearer $token',
      'userid': uid,
      'mode': mode,
    };

    Response response = await post(
      url,
      null,
      headers: headers,
    );

    return response;
  }

  Future<String?> isEditComment({
    required String postId,
    required String commentId,
    required String commentText,
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/post/$postId/comment/$commentId';

    String body = jsonEncode({
      'comment': commentText,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
      'userid': uid,
      'mode': mode,
    };

    try {
      var response = await put(
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

  Future<Response> isLikeComment({
    required String postId,
    required String commentId,
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/post/$postId/comment/$commentId/like';

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'accept': defaultContentType,
      'authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
      // 'whereConditions': {'isHideStory': false},
    };

    Response response = await post(
      url,
      null,
      headers: headers,
    );

    return response;
  }

  Future<String?> isDeleteComment({
    required String postId,
    required String commentId,
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/post/$postId/comment/$commentId';

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'accept': defaultContentType,
      'authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
      // 'whereConditions': {'isHideStory': false},
    };

    try {
      var response = await delete(
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

  Future<String?> getCommentList({
    required String postId,
    required String uid,
    required String token,
    required int offset,
    required int limit,
  }) async {
    String url = '${Environment.apiURL}/api/post/$postId/comment/search';

    String body = jsonEncode({
      'offset': offset,
      'limit': limit,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
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

  Future<String?> sendComment({
    required String postId,
    required String mode,
    required String uid,
    required String token,
    required String comment,
  }) async {
    String url = '${Environment.apiURL}/api/post/$postId/comment';

    String body = jsonEncode({
      // 'commentAsPage': uid,
      'comment': comment,
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
      'mode': mode,
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

  Future<Response> getRecommendedUserPage({
    required int offset,
    required int limit,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/recommend';

    Map<String, dynamic> query = {
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'userid': uid,
      'mode': mode,
    };

    Response response = await get(
      url,
      query: query,
      headers: headers,
    );

    return response;
  }

  Future<Response> follow({
    required String pageId,
    required String type,
    required String token,
    required String uid,
    required String mode,
    required String? tokenFCM,
  }) async {
    String url = type == 'USER' ? '${Environment.apiURL}/api/user/$pageId/follow' : '${Environment.apiURL}/api/page/$pageId/follow';

    String body = jsonEncode({
      'tokenFCM': tokenFCM,
    });

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'userid': uid,
      'mode': mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }
}
