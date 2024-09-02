import 'dart:convert';

import 'package:get/get.dart';

import '../../ui/utils/environment.dart';
import '../models/base_64_model.dart';

class TempService extends GetConnect {
  Future<Response> postFileTemp({
    required Base64Model base64Model,
    required String mode,
    required String token,
    required String userId,
  }) async {
    String url = '${Environment.apiURL}/api/file/temp';

    String body = jsonEncode(base64Model.toJson());

    Map<String, String> headers = {
      'content-type': defaultContentType,
      'authorization': 'Bearer $token',
      'mode': mode,
      'userid': userId,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }
}
