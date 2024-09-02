import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/point_event_detail_controller.dart';
import '../../../utils/assets.dart';

class TextPointEventDetail extends GetWidget<PointEventDetailController> {
  const TextPointEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final pointEventDetail = controller.dataModel.value.data!.pointEventDetail!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${pointEventDetail.title ?? ''}'
          '\n',
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: context.isPhone ? 16 : 24,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
            color: Colors.grey.shade800,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(
          height: context.isPhone ? 32.0 : 48.0,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
