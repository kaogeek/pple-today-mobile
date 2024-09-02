import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/point_event_detail_controller.dart';
import '../../../utils/assets.dart';

class CustomTabViewPointEventDetail extends GetWidget<PointEventDetailController> {
  const CustomTabViewPointEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final pointEventDetail = controller.dataModel.value.data!.pointEventDetail!;

    return Obx(() => Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: controller.selectTab == 0
              ? Text(
                  pointEventDetail.detail ?? '',
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
                    children: pointEventDetail.condition!.map((condition) {
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
