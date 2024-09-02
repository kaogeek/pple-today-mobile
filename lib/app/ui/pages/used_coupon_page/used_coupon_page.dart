// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/used_coupon_controller.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import 'widgets/bar_code_used_coupon.dart';
import 'widgets/button_used_coupon.dart';
import 'widgets/expire_date_time_used_coupon.dart';
import 'widgets/qr_code_used_coupon.dart';

class UsedCouponPage extends GetView<UsedCouponController> {
  const UsedCouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: kPrimaryColor),
        title: Text(
          'ใช้งานคูปอง',
          style: TextStyle(
            fontSize: context.isPhone ? 24 : 32,
            fontFamily: Assets.assetsFontsAnakotmaiLight,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.isPhone ? 8.0 : 16.0),
          child: Column(
            children: const [
              ExpireDateTimeUsedCoupon(),
              QRCodeUsedCoupon(),
              BarCodeUsedCoupon(),
              ButtonUsedCoupon(),
            ],
          ),
        ),
      ),
    );
  }
}
