// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../component/convert_image_component.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../../controllers/user_point_controller.dart';

class AppBarUserPoint extends GetWidget<UserPointController> {
  const AppBarUserPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: (context.isPhone ? 384.0 : 440.0),
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor: kPrimaryColor,
      leading: BackButton(color: Colors.white),
      title: Text(
        'ประวัติ',
        style: TextStyle(
          fontSize: context.isPhone ? 24 : 32,
          fontFamily: Assets.assetsFontsAnakotmaiLight,
          color: Colors.white,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      flexibleSpace: _buildFlexibleSpace(),
      bottom: _buildTabBar(context),
    );
  }

  Widget _buildFlexibleSpace() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final biggestHeight = constraints.biggest.height;

        if (controller.biggest == 0.0) controller.biggest = biggestHeight;

        final double paddingBottom;
        if ((144.0 - (controller.biggest - biggestHeight)) <= 0.0) {
          paddingBottom = 0.0;
        } else {
          paddingBottom = 144.0 - (controller.biggest - biggestHeight);
        }

        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(
            left: 16.0,
            bottom: paddingBottom,
            right: 16.0,
          ),
          expandedTitleScale: 1.0,
          centerTitle: true,
          title: SafeArea(
            bottom: false,
            child: Container(
              margin: const EdgeInsets.only(top: 60.0),
              width: double.infinity,
              height: context.isPhone ? 180.0 : 228.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Obx(() {
                final user = controller.dataModel.value.data?.user;
                final accumulatePoint = controller.dataModel.value.data?.accumulatePoint;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: context.isPhone ? 28.0 : 32.0,
                            backgroundImage: NetworkImage(
                              ConvertImageComponent.getImages(imageURL: user?.imageUrl ?? ''),
                            ),
                            child: (user?.imageUrl ?? '').isEmpty
                                ? Icon(
                                    Icons.person,
                                    size: context.isPhone ? 32.0 : 36.0,
                                  )
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              user?.displayName ?? '',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: context.isPhone ? 24.0 : 32.0,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.4,
                      color: Colors.grey.shade300,
                    ),
                    _buildCustomListTile(
                      context,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: 'คะแนนที่ได้รับ',
                      trailing: formatPoint(accumulatePoint?.totalPoint ?? 0),
                    ),
                    _buildCustomListTile(
                      context,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      title: 'คะแนนที่ใช้ไป',
                      trailing: formatPoint(accumulatePoint?.usedPoint ?? 0),
                    ),
                    _buildCustomListTile(
                      context,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: 'คะแนนคงเหลือ',
                      titleStyle: TextStyle(
                        fontSize: context.isPhone ? 14 : 20,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: formatPoint(accumulatePoint?.accumulatePoint ?? 0),
                      trailingStyle: TextStyle(
                        fontSize: context.isPhone ? 20 : 32,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        color: kPrimaryColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomListTile(
    BuildContext context, {
    required EdgeInsetsGeometry padding,
    required String title,
    required String trailing,
    TextStyle? titleStyle,
    TextStyle? trailingStyle,
  }) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: () {
              if (titleStyle != null) return titleStyle;

              return TextStyle(
                fontSize: context.isPhone ? 14 : 20,
                fontFamily: Assets.assetsFontsAnakotmaiLight,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              );
            }(),
          ),
          Text(
            trailing,
            maxLines: 1,
            style: () {
              if (trailingStyle != null) return trailingStyle;

              return TextStyle(
                fontSize: context.isPhone ? 16 : 24,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              );
            }(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildTabBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(132.0),
      // preferredSize: const Size.fromHeight(124.0),
      // preferredSize: const Size.fromHeight(96.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 8.0),
              child: Text(
                'ประวัติการใช้คะแนน',
                style: TextStyle(
                  fontSize: context.isPhone ? 20 : 24,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    indicatorWeight: 8.0,
                    onTap: (index) {
                      controller.selectTab = index;
                    },
                    tabs: [
                      Tab(
                        child: Container(
                          width: (context.width / 3) - 5.3,
                          height: 36,
                          decoration: BoxDecoration(
                            color: controller.selectTab == 0 ? kPrimaryMFPColor : null,
                            border: Border.all(
                              color: controller.selectTab == 0 ? kPrimaryMFPColor : Colors.grey,
                              width: 0.2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              bottomLeft: Radius.circular(50.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'ทั้งหมด',
                              style: TextStyle(
                                fontSize: context.isPhone ? 14 : 20,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                color: controller.selectTab == 0 ? Colors.white : Colors.grey.shade800,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: (context.width / 3) - 5.3,
                          height: 36,
                          decoration: BoxDecoration(
                            color: controller.selectTab == 1 ? kPrimaryMFPColor : null,
                            border: Border.all(
                              color: controller.selectTab == 1 ? kPrimaryMFPColor : Colors.grey,
                              width: 0.2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'ได้คะแนน',
                              style: TextStyle(
                                fontSize: context.isPhone ? 14 : 20,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                color: controller.selectTab == 1 ? Colors.white : Colors.grey.shade800,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: (context.width / 3) - 5.3,
                          height: 36,
                          decoration: BoxDecoration(
                            color: controller.selectTab == 2 ? kPrimaryMFPColor : null,
                            border: Border.all(
                              color: controller.selectTab == 2 ? kPrimaryMFPColor : Colors.grey,
                              width: 0.2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'ใช้คะแนน',
                              style: TextStyle(
                                fontSize: context.isPhone ? 14 : 20,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                color: controller.selectTab == 2 ? Colors.white : Colors.grey.shade800,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String formatMemberId(String memberId) {
    if (memberId.length != 10) {
      debugPrint('MEMBERID.LENGTH: ${memberId.length}');
      throw const FormatException("The number must have 10 digits.");
    }

    return "${memberId.substring(0, 1)}-${memberId.substring(1, 4)}-${memberId.substring(4, 7)}-${memberId.substring(7, 10)}";
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
