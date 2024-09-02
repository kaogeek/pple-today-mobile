import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../../../controllers/today_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';

class TodayAnnouncement extends GetWidget<TodayController> {
  const TodayAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodayController>(
      init: TodayController(),
      initState: (_) {},
      builder: (_) {
        return controller.announcementModel.data == null || !controller.announcementModel.data!.offOn!
            ? const SizedBox()
            : Container(
                height: 40,
                color: kPrimaryMFPColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.WEBVIEW,
                        arguments: {
                          'URL': controller.announcementModel.data!.link! + '?hidebar=true',
                          'TITLE': controller.announcementModel.data!.value!.split(':').first,
                        },
                      );
                    },
                    child: Marquee(
                      text: controller.announcementModel.data!.value!,
                      style: Get.textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                      blankSpace: 120,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
