import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../component/convert_image_component.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/ranking_controller.dart';

class MyRanking extends GetWidget<RankingController> {
  const MyRanking({super.key});

  @override
  Widget build(BuildContext context) {
    final myRanking = controller.dataModel.value.data?.sortAccumulatePoint?.self;

    return Container(
      width: double.infinity,
      height: context.isPhone ? 140.0 : 200.0,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(context.isPhone ? 16.0 : 24.0),
      margin: EdgeInsets.only(bottom: context.isPhone ? 8.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'อันดับของคุณ',
            style: TextStyle(
              fontSize: context.isPhone ? 24 : 32,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                width: context.isPhone ? 40.0 : 56.0,
                height: context.isPhone ? 40.0 : 56.0,
                // width: context.isPhone ? 56.0 : 80.0,
                // height: context.isPhone ? 40.0 : 56.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                child: Center(
                  child: AutoSizeText(
                    formatRankNumber(controller.dataModel.value.data!.sortAccumulatePoint!.selfOrder ?? 0),
                    presetFontSizes: const [26.0, 24.0, 22.0, 20.0, 16.0, 14.0, 12.0, 10.0, 8.0],
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: context.isPhone ? 12 : 16,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      color: kPrimaryColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              //   if (myRanking != null)
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: context.isPhone ? 22.0 : 32.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: context.isPhone ? 20.0 : 30.0,
                        backgroundImage: NetworkImage(
                          ConvertImageComponent.getImages(imageURL: myRanking?.user?.imageUrl ?? ''),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '\t\t' '${myRanking?.user?.displayName ?? ''}',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: context.isPhone ? 16 : 24,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formatPoint(myRanking?.accumulatePoint ?? 0),
                style: TextStyle(
                  fontSize: context.isPhone ? 20 : 24,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatRankNumber(int rankNumber) {
    if (rankNumber >= 1000000) {
      return '${(rankNumber / 1000000).toStringAsFixed(1)}M';
    } else {
      return NumberFormat("#,###").format(rankNumber);
    }
  }

  String formatPoint(int point) {
    BuildContext context = Get.context!;
    bool isNegative = false;

    if (point < 0) {
      isNegative = true;
      point = point * -1;
    }

    String formattedPoint;
    if (point >= 1000000) {
      formattedPoint = "${(point / 1000000).toStringAsFixed(2)}M";
    } else if (point >= 100000 && context.isPhone) {
      formattedPoint = "${(point / 1000).toStringAsFixed(0)}K";
    } else {
      formattedPoint = NumberFormat("#,###").format(point);
    }

    if (isNegative) {
      formattedPoint = "-$formattedPoint";
    }

    return formattedPoint;
  }
}
