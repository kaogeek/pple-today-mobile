import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/point_product_detail_controller.dart';
import '../../../utils/assets.dart';

class CustomTabViewPointProductDetail extends GetWidget<PointProductDetailController> {
  const CustomTabViewPointProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetail = controller.dataModel.value.data!.productDetail!;

    return Obx(() => Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: controller.selectTab == 0
              ? Text(
                  productDetail.detail ?? '',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: context.isPhone ? 14 : 20,
                    fontFamily: Assets.assetsFontsAnakotmaiLight,
                    color: Colors.grey.shade800,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : RichText(
                  text: TextSpan(
                    children: productDetail.condition!.map((condition) {
                      return TextSpan(
                        text: '・\t' '$condition\n',
                        style: TextStyle(
                          fontSize: context.isPhone ? 14 : 20,
                          fontFamily: Assets.assetsFontsAnakotmaiLight,
                          color: Colors.grey.shade800,
                          overflow: TextOverflow.visible,
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ));
  }
}
