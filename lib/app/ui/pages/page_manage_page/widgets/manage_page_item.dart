import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/elevated_button_component.dart';
import '../../../../controllers/page_manage_body_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class ManagePageItem extends GetWidget<PageManageBodyController> {
  final String labelText;
  final String? detail;
  final String value;
  final Widget? prefixIcon;

  const ManagePageItem({Key? key, required this.labelText, this.detail, required this.value, this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setData(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 14,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.2,
                  color: Colors.black12,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextField(
                controller: controller.textController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  hintText: labelText,
                  hintStyle: const TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.all(12),
                  border: InputBorder.none,
                  suffixIcon: Obx(() => (value != controller.textChanged.value) && controller.isSave.isFalse
                      ? IconButton(
                          onPressed: _onClean,
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey.shade700,
                          ),
                        )
                      : const SizedBox()),
                ),
                onChanged: (e) {
                  controller.textChanged.value = e;
                  controller.isSave.value = false;
                  controller.isSave.refresh();
                },
              ),
            ),
          ),
          if ((detail ?? '').isNotEmpty)
            Text(
              detail!,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          Obx(() => (value != controller.textChanged.value) && controller.isSave.isFalse
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ElevatedButtonComponent(
                        height: 32,
                        labelText: 'บันทึก',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                        primary: kPrimaryColor,
                        onPressed: _onSave,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButtonComponent(
                        height: 32,
                        labelText: 'ยกเลิก',
                        style: TextStyle(
                          fontSize: 14,
                          color: kPrimaryColor,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                        primary: Colors.white,
                        onPressed: _onClose,
                      ),
                    ),
                  ],
                )
              : const SizedBox()),
          // MyDivider(),
        ],
      ),
    );
  }

  void _onSave() {
    controller.isSave.value = true;
    controller.isSave.refresh();

    FocusManager.instance.primaryFocus?.unfocus();

    switch (labelText) {
      case 'ชื่อเพจ':
        controller.fetchUpdatePage(
          pageName: controller.textChanged.value,
        );
        break;

      case 'URL ของเพจ':
        controller.fetchUpdatePage(
          pageUsername: controller.textChanged.value,
        );
        break;

      case 'ความเป็นมา':
        controller.fetchUpdatePage(
          backgroundStory: controller.textChanged.value,
        );
        break;

      case 'เว็บไซต์':
        controller.fetchUpdatePage(
          websiteURL: controller.textChanged.value,
        );
        break;

      case 'อีเมล':
        controller.fetchUpdatePage(
          email: controller.textChanged.value,
        );
        break;

      case 'ไลน์':
        controller.fetchUpdatePage(
          lineId: controller.textChanged.value,
        );
        break;

      case 'เฟซบุ๊ค':
        controller.fetchUpdatePage(
          facebookURL: controller.textChanged.value,
        );
        break;

      case 'ทวิตเตอร์':
        controller.fetchUpdatePage(
          twitterURL: controller.textChanged.value,
        );
        break;

      default:
        break;
    }
  }

  void _onClose() {
    controller.textController.text = value;

    controller.textChanged.value = value;
    controller.textChanged.refresh();

    FocusManager.instance.primaryFocus?.unfocus();

    controller.isSave.value = false;
    controller.isSave.refresh();
  }

  void _onClean() {
    controller.textChanged.value = '';
    controller.textChanged.refresh();

    controller.textController.text = '';
  }
}
