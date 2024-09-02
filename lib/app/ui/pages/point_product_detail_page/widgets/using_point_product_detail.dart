import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/point_product_detail_controller.dart';
import '../../../utils/assets.dart';

class UsingPointProductDetail extends GetWidget<PointProductDetailController> {
  const UsingPointProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetail = controller.dataModel.value.data!.productDetail!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'คะแนนที่ต้องใช้',
                maxLines: 1,
                style: TextStyle(
                  fontSize: context.isPhone ? 14 : 20,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 32.0),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.isPhone ? 4.0 : 8.0),
                  child: Image.asset(
                    Assets.assetsImagesPoint,
                    width: context.isPhone ? 16.0 : 24.0,
                    height: context.isPhone ? 16.0 : 24.0,
                  ),
                ),
                Text(
                  formatPoint(productDetail.point ?? 0),
                  style: TextStyle(
                    fontSize: context.isPhone ? 14 : 20,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          height: context.isPhone ? 32.0 : 48.0,
          color: Colors.grey.shade300,
        ),
      ],
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
}
