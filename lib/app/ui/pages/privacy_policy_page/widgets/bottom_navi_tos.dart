import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../controllers/privacy_policy_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class BottomNaviTOS extends StatelessWidget {
  BottomNaviTOS({Key? key}) : super(key: key);

  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PrivacyPolicyController>(
        init: PrivacyPolicyController(),
        initState: (_) {},
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Theme(
                data: ThemeData(unselectedWidgetColor: kPrimaryColor),
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: kPrimaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                    'ฉันได้อ่านและยอมรับข้อกำหนดในการให้บริการและนโยบายความเป็นส่วนตัว',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: controller.accept,
                  onChanged: (value) {
                    controller.accept = value!;
                    controller.update();
                  },
                ),
              ),
              SizedBox(
                width: Get.width * .9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: controller.accept ? const BorderSide(color: kPrimaryColor) : BorderSide.none,
                    ),
                    primary: kPrimaryColor,
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: controller.accept ? _onAccept : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onAccept() async {
    await _box.write(StorageKeys.eula, true);

    Get.back(result: true);
    return;
  }
}
