import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../component/convert_image_component.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/ranking_controller.dart';
import '../../../utils/assets.dart';
import 'my_ranking.dart';

class BodyRanking extends GetWidget<RankingController> {
  const BodyRanking({super.key});

  @override
  Widget build(BuildContext context) {
    final rankingPoint = controller.dataModel.value.data?.sortAccumulatePoint?.rankingPoint;

    if ((rankingPoint ?? []).isEmpty) {
      return Center(
        child: Text(
          'ไม่พบข้อมูล',
          style: TextStyle(
            fontSize: context.isPhone ? 24 : 32,
            fontFamily: Assets.assetsFontsAnakotmaiLight,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Padding(
        padding: EdgeInsets.all(context.isPhone ? 8.0 : 16.0),
        child: Column(
          children: [
            /// My Ranking
            const MyRanking(),

            /// Ranking List
            ...List.generate(rankingPoint!.length, (index) {
              final ranking = rankingPoint[index];

              return SafeArea(
                top: false,
                left: false,
                right: false,
                bottom: index == rankingPoint.length - 1,
                child: Container(
                  height: context.isPhone ? 56.0 : 72.0,
                  margin: EdgeInsets.symmetric(vertical: context.isPhone ? 2.0 : 4.0),
                  padding: EdgeInsets.symmetric(horizontal: context.isPhone ? 16.0 : 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      () {
                        switch (index + 1) {
                          case 1:
                            return Container(
                              width: context.isPhone ? 40.0 : 56.0,
                              height: context.isPhone ? 40.0 : 56.0,
                              // width: context.isPhone ? 56.0 : 80.0,
                              // height: context.isPhone ? 40.0 : 56.0,
                              margin: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Assets.assetsImagesRanking1),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );

                          case 2:
                            return Container(
                              width: context.isPhone ? 40.0 : 56.0,
                              height: context.isPhone ? 40.0 : 56.0,
                              // width: context.isPhone ? 56.0 : 80.0,
                              // height: context.isPhone ? 40.0 : 56.0,
                              margin: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Assets.assetsImagesRanking2),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );

                          case 3:
                            return Container(
                              width: context.isPhone ? 40.0 : 56.0,
                              height: context.isPhone ? 40.0 : 56.0,
                              // width: context.isPhone ? 56.0 : 80.0,
                              // height: context.isPhone ? 40.0 : 56.0,
                              margin: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Assets.assetsImagesRanking3),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );

                          default:
                            return Container(
                              width: context.isPhone ? 40.0 : 56.0,
                              height: context.isPhone ? 40.0 : 56.0,
                              // width: context.isPhone ? 56.0 : 80.0,
                              // height: context.isPhone ? 40.0 : 56.0,
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              margin: EdgeInsets.only(right: context.isPhone ? 16.0 : 24.0),
                              child: Center(
                                child: AutoSizeText(
                                  formatRankNumber(index + 1),
                                  presetFontSizes: const [26.0, 24.0, 22.0, 20.0, 16.0, 14.0, 12.0, 10.0, 8.0],
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                        }
                      }(),
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: context.isPhone ? 22.0 : 32.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: context.isPhone ? 20.0 : 30.0,
                                backgroundImage: NetworkImage(
                                  ConvertImageComponent.getImages(imageURL: ranking.user!.imageUrl!),
                                ),
                                child: (ranking.user?.imageUrl ?? '').isEmpty
                                    ? Icon(
                                        Icons.person,
                                        size: context.isPhone ? 32.0 : 36.0,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\t\t'
                                '${ranking.user!.displayName}',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: context.isPhone ? 16 : 24,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                  color: Colors.grey.shade800,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formatPoint(ranking.accumulatePoint ?? 0),
                        style: TextStyle(
                          fontSize: context.isPhone ? 20 : 24,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          color: Colors.grey.shade800,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Icon(
                      //   Icons.arrow_drop_up,
                      //   color: Colors.green,
                      //   size: context.isPhone ? 32.0 : 40.0,
                      // ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String formatRankNumber(int rankNumber) {
    if (rankNumber < 1000000) {
      return NumberFormat("#,###").format(rankNumber);
    } else {
      return '${(rankNumber / 1000000).toStringAsFixed(1)}M';
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
