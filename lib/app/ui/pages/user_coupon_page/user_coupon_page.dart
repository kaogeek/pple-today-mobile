import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_coupont_controller.dart';
import 'widgets/already_body_user_coupon.dart';
import 'widgets/app_bar_user_coupon.dart';
import 'widgets/expire_body_user_coupon.dart';
import 'widgets/ready_body_user_coupon.dart';

class UserCouponPage extends GetView<UserCouponController> {
  const UserCouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const AppBarUserCoupon(),
        body: TabBarView(
          children: [
            ReadyBodyUserCoupon(),
            AlreadyBodyUserCoupon(),
            ExpireBodyUserCoupon(),
          ],
        ),
      ),
    );
  }
}
