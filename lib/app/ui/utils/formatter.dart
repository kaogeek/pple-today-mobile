import 'package:flutter/services.dart';

class Formatter {
  static List<TextInputFormatter> inputText = [FilteringTextInputFormatter.allow(RegExp('[ก-๙ a-z A-Z 0-9 !_.?]'))];

  static List<TextInputFormatter> inputNumber = [FilteringTextInputFormatter.digitsOnly];

  static List<TextInputFormatter> inputEmail = [FilteringTextInputFormatter.allow(RegExp('[^ก-๙]'))];

  static List<TextInputFormatter> inputPassword = [FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z 0-9 ?=.*?[!@#\$\%^&*_~.?]'))];

  static List<TextInputFormatter> inputUserName = [FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9 _]'))];
}
