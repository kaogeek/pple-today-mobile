import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/point_event_detail_controller.dart';

class LinearProgressPointEventDetail extends GetWidget<PointEventDetailController> {
  const LinearProgressPointEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final pointEventDetail = controller.dataModel.value.data!.pointEventDetail!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: context.isPhone ? 8.0 : 16.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: LinearProgressIndicator(
              value: (pointEventDetail.receiver ?? 0) / (pointEventDetail.maximumLimit ?? 0),
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'เหลือ\t'
              '${pointEventDetail.maximumLimit! - pointEventDetail.receiver!}',
              style: TextStyle(
                fontSize: context.isPhone ? 12 : 16,
                fontFamily: Assets.assetsFontsAnakotmaiLight,
                color: Colors.grey.shade800,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Divider(
          thickness: 8.0,
          height: 32.0,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
