import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoPeriewController extends GetxController {
  final _parameters = Get.parameters;
  get imageUrl => _parameters['imageUrl'] ?? '';

  @override
  void onInit() {
    debugPrint('IMAGE_URL: $imageUrl', wrapWidth: 1024);
    super.onInit();
  }
}
