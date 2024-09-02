import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';
import '../../../../controllers/point_main_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

class TabBarPointMain extends GetWidget<PointMainController> {
  const TabBarPointMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isPhone ? 16.0 : 24.0,
          vertical: context.isPhone ? 16.0 : 24.0,
        ),
        child: Obx(() {
          final data = controller.pointContentModel.value.data;

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildCardItem(
                width: context.isPhone ? 220.0 : 320.0,
                icon: Assets.assetsImagesPoint,
                title: formatPoint(data?.accumulatePoint?.accumulatePoint ?? 0),
                subTitle: 'คะแนน',
                onTap: () {
                  Get.toNamed(AppRoutes.USER_POINT);
                },
              ),
              _buildCardItem(
                width: context.isPhone ? 160.0 : 240.0,
                icon: Assets.assetsImagesVector,
                iconWidth: context.isPhone ? 32.0 : 40.0,
                iconHeight: context.isPhone ? 24.0 : 32.0,
                title: NumberFormat("#,###").format(data?.userCoupon ?? 0),
                subTitle: 'คูปองพร้อมใช้',
                onTap: () {
                  Get.toNamed(AppRoutes.USER_COUPON);
                },
              ),
              _buildCardItem(
                width: context.isPhone ? 180.0 : 260.0,
                icon: Assets.assetsImagesRanking,
                title: 'จัดอันดับ',
                subTitle: 'การมีส่วนร่วม',
                onTap: () {
                  Get.toNamed(AppRoutes.RANKING);
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  String formatPoint(int point) {
    // BuildContext context = Get.context!;
    bool isNegative = false;

    if (point < 0) {
      isNegative = true;
      point = point * -1;
    }

    String formattedPoint;
    if (point >= 1000000) {
      formattedPoint = "${(point / 1000000).toStringAsFixed(2)}M";
      // } else if (point >= 100000 && context.isPhone) {
      //   formattedPoint = "${(point / 1000).toStringAsFixed(0)}K";
    } else {
      formattedPoint = NumberFormat("#,###").format(point);
    }

    if (isNegative) {
      formattedPoint = "-$formattedPoint";
    }

    return formattedPoint;
  }

  Widget _buildCardItem({
    required double width,
    required String icon,
    double? iconWidth,
    double? iconHeight,
    required String title,
    required String subTitle,
    required GestureTapCallback? onTap,
  }) {
    BuildContext context = Get.context!;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon,
                    width: iconWidth ?? (context.isPhone ? 32.0 : 40.0),
                    height: iconHeight ?? (context.isPhone ? 32.0 : 40.0),
                    fit: BoxFit.fill,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: context.isPhone ? 24 : 32,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: primaryBlue,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: context.isPhone ? 16 : 24,
                  fontFamily: Assets.assetsFontsAnakotmaiLight,
                  color: primaryBlue,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
