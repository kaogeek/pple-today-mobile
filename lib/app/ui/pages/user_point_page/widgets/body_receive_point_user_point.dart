import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';
import '../../../../controllers/user_point_controller.dart';
import '../../../utils/assets.dart';

class BodyReceivePointUserPoint extends GetWidget<UserPointController> {
  const BodyReceivePointUserPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final receivePointStatement = controller.dataModel.value.data?.accumulatePoint?.receivePointStatement;

      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        );
      }

      if ((receivePointStatement ?? []).isEmpty) {
        return Center(
          child: Text(
            'ไม่มีข้อมูล',
            style: TextStyle(
              fontSize: 24,
              fontFamily: Assets.assetsFontsAnakotmaiLight,
              color: kPrimaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }

      return ListView(
        controller: ScrollController(),
        padding: EdgeInsets.zero,
        children: ListTile.divideTiles(
            context: context,
            tiles: receivePointStatement!.map((e) {
              return SizedBox(
                height: context.isPhone ? null : 88.0,
                child: ListTile(
                  dense: context.isPhone,
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          (e.title ?? '').trim(),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: context.isPhone ? 16 : 24,
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
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.asset(
                              Assets.assetsImagesPoint,
                              width: 16.0,
                              height: 16.0,
                            ),
                          ),
                          Text(
                            '+${formatPoint(e.point!)}',
                            style: TextStyle(
                              fontSize: context.isPhone ? 16 : 24,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              color: Colors.green,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ได้รับคะแนน',
                          style: TextStyle(
                            fontSize: context.isPhone ? 12 : 16,
                            fontFamily: Assets.assetsFontsAnakotmaiLight,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32.0),
                      Text(
                        controller.formatter.format(e.createdDate!),
                        style: TextStyle(
                          fontSize: context.isPhone ? 12 : 16,
                          fontFamily: Assets.assetsFontsAnakotmaiLight,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })).toList(),
      );
    });
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
