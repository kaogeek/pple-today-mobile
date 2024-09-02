import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/used_coupon_controller.dart';

class ExpireDateTimeUsedCoupon extends GetWidget<UsedCouponController> {
  const ExpireDateTimeUsedCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: context.isPhone ? double.infinity : context.width / 2,
      width: double.infinity,
      height: context.isPhone ? 64.0 : 88.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'หมดอายุใน',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.isPhone ? 16 : 24,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              color: Colors.red,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 24.0),
          Obx(() => buildExpireDateTime(
                context,
                expireDateTime: controller.expireDay,
              )),
          buildDivider(),
          Obx(() => buildExpireDateTime(
                context,
                expireDateTime: controller.expireHours,
              )),
          buildDivider(),
          Obx(() => buildExpireDateTime(
                context,
                expireDateTime: controller.expireMinutes,
              )),
          buildDivider(),
          Obx(() => buildExpireDateTime(
                context,
                expireDateTime: controller.expireSeconds,
              )),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const SizedBox(
      height: 32.0,
      child: VerticalDivider(
        width: 24.0,
        color: kPrimaryColor,
      ),
    );
  }

  Widget buildExpireDateTime(BuildContext context, {required String expireDateTime}) {
    return Text(
      expireDateTime,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: context.isPhone ? 16 : 24,
        fontFamily: Assets.assetsFontsAnakotmaiMedium,
        color: kPrimaryColor,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
