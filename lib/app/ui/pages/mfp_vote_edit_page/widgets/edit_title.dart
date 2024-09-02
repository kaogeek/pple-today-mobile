import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_edit_controller.dart';
import 'group.dart';

class EditTitle extends GetWidget<MfpVoteEditController> {
  const EditTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Group(
      groupName: 'ชื่อการโหวต',
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
          controller: controller.titleController,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'ตั้งชื่อการโหวต',
            hintStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.all(8.0),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
          autocorrect: false,
        ),
      ),
    );
  }
}
