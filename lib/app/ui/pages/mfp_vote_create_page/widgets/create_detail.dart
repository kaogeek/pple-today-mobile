import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_create_controller.dart';
import '../../../utils/formatter.dart';
import 'group.dart';

class CreateDetail extends GetWidget<MfpVoteCreateController> {
  const CreateDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Group(
      groupName: 'คำอธิบาย',
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: TextField(
          focusNode: controller.descriptionFocusNode,
          controller: controller.descriptionController,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'เพิ่มคำอธิบาย',
            hintStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.all(8.0),
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.unspecified,
          keyboardType: TextInputType.text,
          inputFormatters: Formatter.inputText,
          autocorrect: false,
          maxLines: 6,
        ),
      ),
    );
  }
}
