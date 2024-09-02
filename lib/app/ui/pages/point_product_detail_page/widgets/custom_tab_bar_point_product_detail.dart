import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../../controllers/point_product_detail_controller.dart';

class CustomTabBarPointProductDetail extends GetWidget<PointProductDetailController> {
  const CustomTabBarPointProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.isPhone ? 4.0 : 16.0),
      child: Obx(() => Row(
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
                      style: context.isPhone
                          ? Get.textTheme.titleSmall!.copyWith(
                              fontSize: 14.0,
                              color: controller.selectTab == 0 ? Colors.white : Colors.grey.shade800,
                            )
                          : Get.textTheme.titleMedium!.copyWith(
                              fontSize: 20.0,
                              color: controller.selectTab == 0 ? Colors.white : Colors.grey.shade800,
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
                      style: context.isPhone
                          ? Get.textTheme.titleSmall!.copyWith(
                              fontSize: 14.0,
                              color: controller.selectTab == 1 ? Colors.white : Colors.grey.shade800,
                            )
                          : Get.textTheme.titleMedium!.copyWith(
                              fontSize: 20.0,
                              color: controller.selectTab == 1 ? Colors.white : Colors.grey.shade800,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
