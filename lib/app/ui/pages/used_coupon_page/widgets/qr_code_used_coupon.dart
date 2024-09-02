import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../controllers/used_coupon_controller.dart';

class QRCodeUsedCoupon extends GetWidget<UsedCouponController> {
  const QRCodeUsedCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.isPhone ? 16.0 : 32.0),
      child: SizedBox(
        height: context.isPhone ? 160.0 : 240.0,
        child: SfBarcodeGenerator(
          value: controller.couponId,
          symbology: QRCode(),
        ),
      ),
    );
  }
}
