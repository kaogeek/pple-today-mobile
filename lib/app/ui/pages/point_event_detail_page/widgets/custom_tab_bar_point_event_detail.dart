import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/point_event_detail_controller.dart';

class CustomTabBarPointEventDetail extends GetWidget<PointEventDetailController> {
  const CustomTabBarPointEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            GestureDetector(
              onTap: () => controller.selectTab = 0,
              child: Container(
                width: (context.width / 2) - 16.0,
                height: context.isPhone ? 36.0 : 48.0,
                decoration: BoxDecoration(
                  color: controller.selectTab == 0 ? kPrimaryMFPColor : null,
                  border: Border.all(
                    color: controller.selectTab == 0 ? kPrimaryMFPColor : Colors.grey,
                    width: 0.2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'รายละเอียด',
                    style: TextStyle(
                      fontSize: context.isPhone ? 14 : 20,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      color: controller.selectTab == 0 ? Colors.white : Colors.grey.shade800,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.selectTab = 1,
              child: Container(
                width: (context.width / 2) - 16.0,
                height: context.isPhone ? 36.0 : 48.0,
                decoration: BoxDecoration(
                  color: controller.selectTab == 1 ? kPrimaryMFPColor : null,
                  border: Border.all(
                    color: controller.selectTab == 1 ? kPrimaryMFPColor : Colors.grey,
                    width: 0.2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'เงื่อนไข',
                    style: TextStyle(
                      fontSize: context.isPhone ? 14 : 20,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      color: controller.selectTab == 1 ? Colors.white : Colors.grey.shade800,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
