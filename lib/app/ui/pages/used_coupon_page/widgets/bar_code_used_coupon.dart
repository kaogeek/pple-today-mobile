import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../controllers/used_coupon_controller.dart';

class BarCodeUsedCoupon extends GetWidget<UsedCouponController> {
  const BarCodeUsedCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.isPhone ? 16.0 : 32.0),
      child: SizedBox(
        width: context.isPhone ? null : context.width / 2,
        height: context.isPhone ? 48.0 : 64.0,
        child: SfBarcodeGenerator(
          value: controller.couponId,
          symbology: Code128C(),
        ),
      ),
    );
  }
}
