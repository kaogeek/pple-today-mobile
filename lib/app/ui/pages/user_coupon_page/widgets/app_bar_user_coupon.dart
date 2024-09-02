import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_coupont_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class AppBarUserCoupon extends GetWidget<UserCouponController> implements PreferredSizeWidget {
  const AppBarUserCoupon({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: const BackButton(color: kPrimaryColor),
      title: Text(
        'คูปอง',
        style: TextStyle(
          fontSize: context.isPhone ? 24 : 32,
          fontFamily: Assets.assetsFontsAnakotmaiLight,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
      ),

      /// Tab bar
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: TabBar(
          tabs: const [
            Tab(text: 'พร้อมใช้งาน'),
            Tab(text: 'ใช้งานแล้ว'),
            Tab(text: 'หมดอายุ'),
          ],
          labelStyle: TextStyle(
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.grey.shade700,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: const EdgeInsets.all(5.0),
          indicatorColor: kPrimaryColor,
          onTap: (index) {
            switch (index) {
              case 0:
                controller.selectTab = 'REDEEM';
                break;
              case 1:
                controller.selectTab = 'USE_COUPON';
                break;
              case 2:
                controller.selectTab = 'COUPON_HAS_EXPIRED';
                break;
            }
          },
        ),
      ),
    );
  }
}
