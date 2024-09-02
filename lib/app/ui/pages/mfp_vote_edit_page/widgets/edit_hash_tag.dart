import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_edit_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import 'group.dart';

class EditHashTag extends GetWidget<MfpVoteEditController> {
  const EditHashTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.voteHashTagModel.value.data ?? []).isEmpty
        ? const SizedBox()
        : Group(
            groupName: 'แฮชแท็ก',
            child: Container(
              width: Get.width,
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
              child: DropdownMenu<String>(
                width: Get.width - 36,
                enableFilter: true,
                // enableSearch: false,
                // initialSelection: controller.voteHashTagModel.value.data!.first,
                controller: controller.hashTagController,
                leadingIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.tag,
                    color: kPrimaryColor,
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  border: InputBorder.none,
                ),
                onSelected: (String? value) {
                  controller.hashTagController.text = value ?? '';
                  FocusScope.of(context).unfocus();
                },
                textStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
                dropdownMenuEntries: controller.voteHashTagModel.value.data!.map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry(
                      value: value,
                      label: value,
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          controller.hashTagController.text == value ? kPrimaryColor : Colors.black,
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(
                            fontSize: 14,
                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          ),
                        ),
                      ),
                      leadingIcon: const Icon(
                        Icons.tag,
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ));
  }
}
