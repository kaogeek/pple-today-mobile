import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_information.dart';
import '../routes/app_routes.dart';
import '../ui/utils/assets.dart';
import '../ui/utils/colors.dart';
import '../ui/utils/storage_keys.dart';
import 'elevated_button_component.dart';

class Mfp {
  static Future<void> memberBindingDialog() async {
    final RxBool _value = false.obs;

    await Get.defaultDialog(
      backgroundColor: dashBlue,
      barrierDismissible: true,
      titlePadding: const EdgeInsets.only(top: 24),
      title: 'คุณเป็นสมาชิกของพรรคประชาชน\nใช่หรือไม่?',
      titleStyle: const TextStyle(
        fontFamily: Assets.assetsFontsAnakotmaiMedium,
        color: primaryBlue,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              'เพื่อเชื่อมต่อระบบสมาชิกพรรคประชาชนเข้ากับPPLE Today',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: Assets.assetsFontsAnakotmaiLight,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              primary: kPrimaryColor,
              labelText: 'ใช่...ฉันเป็นสมาชิกพรรคประชาชน',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () {
                Get.back(); // close dialog
                Get.toNamed(
                  AppRoutes.CONNECT_SOCIAL_MEDIA,
                  arguments: {'AUTO_TAP_BINDING': true},
                );
              },
            ),
            ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              labelText: 'ฉันต้องการสมัครสมาชิกพรรค',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () async {
                Get.back(); // close dialog
                Uri uri = Uri.parse(AppInformation.urlRegisterMemberShip);
                bool value = await canLaunchUrl(uri);
                value
                    ? await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      )
                    : throw 'Could not launch ${uri.toString()}';
              },
            ),
            ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              labelText: 'ฉันไม่ได้เป็นสมาชิกพรรค',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () {
                Get.back(); // close dialog
              },
            ),
            Obx(() => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  value: _value.value,
                  onChanged: (value) async {
                    final _box = GetStorage();

                    value ?? false
                        ? await _box.write(StorageKeys.popUpMemberShip, value)
                        : await _box.remove(StorageKeys.popUpMemberShip);

                    _value.toggle();
                    _value.refresh();
                  },
                  title: const Text(
                    'ไม่ต้องการแสดงอีก',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: Assets.assetsFontsAnakotmaiLight,
                      color: primaryBlue,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );

    return;
  }

  static Future<void> memberEngagementDialog() async {
    await Get.defaultDialog(
      backgroundColor: dashBlue,
      barrierDismissible: true,
      titlePadding: const EdgeInsets.only(top: 24),
      title: 'คุณเป็นสมาชิกพรรคประชาชนแล้วหรือยัง?',
      titleStyle: const TextStyle(
        fontFamily: Assets.assetsFontsAnakotmaiMedium,
        color: primaryBlue,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              'คุณสามารถแสดงความคิดเห็นหรือกดไลค์ได้เมื่อเป็นสมาชิกพรรคเท่านั้น',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: Assets.assetsFontsAnakotmaiLight,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              primary: kPrimaryColor,
              labelText: 'ใช่...ฉันเป็นสมาชิกพรรคประชาชน',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () {
                Get.back(); // close dialog
                Get.toNamed(
                  AppRoutes.CONNECT_SOCIAL_MEDIA,
                  arguments: {'AUTO_TAP_BINDING': true},
                );
              },
            ),
            // ElevatedButtonComponent(
            //   height: 48,
            //   padding: const EdgeInsets.symmetric(vertical: 4),
            //   labelText: 'ฉันต้องการสมัครสมาชิกพรรค',
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.black,
            //     fontFamily: Assets.assetsFontsAnakotmaiMedium,
            //   ),
            //   onPressed: () async {
            //     Get.back(); // close dialog
            //     Uri uri = Uri.parse(AppInformation.urlRegisterMemberShip);
            //     bool value = await canLaunchUrl(uri);
            //     value
            //         ? await launchUrl(
            //             uri,
            //             mode: LaunchMode.externalApplication,
            //           )
            //         : throw 'Could not launch ${uri.toString()}';
            //   },
            // ),
            ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              labelText: 'ไว้ก่อนแล้วกัน',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () {
                Get.back(); // close dialog
              },
            ),
          ],
        ),
      ),
    );

    return;
  }

  static Future<void> memberExpieadDialog() async {
    await Get.defaultDialog(
      backgroundColor: dashBlue,
      barrierDismissible: true,
      titlePadding: const EdgeInsets.only(top: 24),
      title: 'แจ้งเตือน',
      titleStyle: const TextStyle(
        fontFamily: Assets.assetsFontsAnakotmaiMedium,
        color: primaryBlue,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              'บัตรสมาชิกพรรคประชาชนหมดอายุแล้ว',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: Assets.assetsFontsAnakotmaiLight,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            /*  ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              primary: kPrimaryColor,
              labelText: 'ใช่...ฉันเป็นสมาชิกพรรคประชาชน',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () {
                Get.back(); // close dialog‚
                Get.toNamed(
                  AppRoutes.CONNECT_SOCIAL_MEDIA,
                  arguments: {'AUTO_TAP_BINDING': true},
                );
              },
            ), */
            /*  ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              labelText: 'ฉันต้องการสมัครสมาชิกพรรค',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () async {
                Get.back(); // close dialog
                Uri uri = Uri.parse(AppInformation.urlRegisterMemberShip);
                bool value = await canLaunchUrl(uri);
                value
                    ? await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      )
                    : throw 'Could not launch ${uri.toString()}';
              },
            ), */
            ElevatedButtonComponent(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4),
              labelText: 'ปิด',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
              onPressed: () {
                Get.back(); // close dialog
              },
            ),
          ],
        ),
      ),
    );

    return;
  }
}
