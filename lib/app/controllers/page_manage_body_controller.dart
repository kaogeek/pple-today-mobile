import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page_manage_controller.dart';

class PageManageBodyController extends GetxController {
  PageManageController pageManageController = Get.find();

  TextEditingController textController = TextEditingController();

  RxString textChanged = ''.obs;

  RxBool isSave = true.obs;

  void setData(String text) {
    textController.text = text;
    textChanged.value = text;
  }

  Future<void> fetchUpdatePage({
    String? pageName,
    String? pageUsername,
    String? backgroundStory,
    String? lineId,
    String? facebookURL,
    String? twitterURL,
    String? websiteURL,
    String? email,
  }) async {
    try {
      await pageManageController.fetchUpdatePage(
        pageName: pageName,
        pageUsername: pageUsername,
        backgroundStory: backgroundStory,
        lineId: lineId,
        facebookURL: facebookURL,
        twitterURL: twitterURL,
        websiteURL: websiteURL,
        email: email,
      );
    } catch (e) {
      log('', error: e, name: 'FetchUpdatePage');
    }

    return;
  }
}
