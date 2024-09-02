// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/all_rights_reserved.dart';
import '../../../utils/colors.dart';

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({Key? key, required this.title, required this.value, required this.onPressed}) : super(key: key);

  final String title;
  final bool value;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 56),
        SizedBox(
          width: Get.width * .9,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.red),
              ),
              primary: value ? kPrimaryColor : kPrimaryColor.withOpacity(.5),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        AllRightsReserve(),
      ],
    );
  }
}
