// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldForgotPass extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final TextInputType keyboardType;
  final void Function(String value)? onChanged;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool obscureText;

  const TextFieldForgotPass({
    Key? key,
    required this.controller,
    this.inputFormatters,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.suffixIcon,
    this.readOnly = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.2,
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextField(
          controller: controller,
          inputFormatters: inputFormatters,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.symmetric(
              vertical: Get.height / 100 * 2.5,
              horizontal: Get.width / 100 * 2.5,
            ),
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          autocorrect: false,
          readOnly: readOnly,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
