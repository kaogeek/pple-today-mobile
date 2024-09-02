import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileTextFieldController extends GetxController {
  String title = Get.arguments['TITLE'];
  String hintText = Get.arguments['HINT_TEXT'];

  TextEditingController textController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Future<void> onInit() async {
    super.onInit();
    textController.text = hintText.trim();
    birthdayController.text = hintText.trim();
    focusNode.requestFocus();
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
    birthdayController.dispose();
    focusNode.dispose();
  }
}
