// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';

class DoingService extends GetConnect {
  Future<String?> getDoing(DateTime dateTime) async {
    String url = '${Environment.apiURL}/api/objective/search';

    Map<String, dynamic> query = {
      'sample': '5',
    };

    String body = jsonEncode({
      'filter': {
        'limit': 4,
        'offset': 0,
        'whereConditions': {
          'createdDate': {
            '\$gte': dateTime.toIso8601String(),
          },
        },
      },
    });

    Map<String, String> headers = {
      'content-type': defaultContentType,
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

  Future<String?> getObjectivDoing({
    required int offset,
    required int limit,
  }) async {
    String url = '${Environment.apiURL}/api/objective/search';

    String body = jsonEncode({
      'filter': {
        'offset': offset,
        'limit': limit,
        'orderBy': {
          'createdDate': -1,
        },
      },
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
}
