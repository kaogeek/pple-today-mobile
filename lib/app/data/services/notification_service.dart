// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';

class NotificationService extends GetConnect {
  Future<Response> getNotificationSearch({
    required int offset,
    required int limit,
    required bool isRead,
    required String mode,
    required String token,
  }) async {
    String url = '${Environment.apiURL}/api/notification/search';

    String body = isRead
        ? jsonEncode({
            'offset': offset,
            'limit': limit,
            'orderBy': {'createdDate': 'DESC'},
            'whereConditions': {
              'deleted': false,
            },
          })
        : jsonEncode({
            'offset': offset,
            'limit': limit,
            'orderBy': {'createdDate': 'DESC'},
            'whereConditions': {
              'isRead': false,
              'deleted': false,
            },
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

  Future<String?> readNotification({
    required String id,
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/notification/$id/read';

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'mode': mode,
    };

    try {
      var response = await post(
        url,
        null,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } on Exception catch (e) {
      print('-- Error: $e');
      return null;
    }
  }

  Future<String?> readAllNotification({
    required String token,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/notification/clear';

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'mode': mode,
    };

    try {
      var response = await post(
        url,
        null,
        headers: headers,
      );

      if (response.hasError) print('-- hasError: ${response.bodyString}');

      return response.bodyString;
    } on Exception catch (e) {
      print('-- Error: $e');
      return null;
    }
  }
}
