import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/point_product_detail_controller.dart';
import '../../../utils/assets.dart';

class TextPointProductDetail extends GetWidget<PointProductDetailController> {
  const TextPointProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetail = controller.dataModel.value.data!.productDetail!;

    return Text(
      '${productDetail.title ?? ''}'
      '\n',
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontSize: context.isPhone ? 16 : 24,
        fontFamily: Assets.assetsFontsAnakotmaiMedium,
        color: Colors.grey.shade800,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
