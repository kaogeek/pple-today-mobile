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
    double topSafeAreaHeight = MediaQuery.of(context).padding.top;
    debugPrint('TOP_SAFE_AREA_HEIGHT: $topSafeAreaHeight', wrapWidth: 1024);

    return Theme(
      data: ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
      ),
      child: Obx(() {
        final userPoing = controller.dataModel.value.data?.accumulatePoint;

        return SliverAppBar(
          expandedHeight: (context.isPhone ? 384.0 : 440.0),
          floating: true,
          snap: true,
          pinned: true,
          backgroundColor: kPrimaryColor,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final maxHeight = constraints.maxHeight;
              debugPrint('MAX_HEIGHT: $maxHeight', wrapWidth: 1024);

              final minHeight = constraints.minHeight;
              debugPrint('MIN_HEIGHT: $minHeight', wrapWidth: 1024);

              final biggestHeight = constraints.biggest.height;
              debugPrint('BIGGEST_HEIGHT: $biggestHeight', wrapWidth: 1024);

              final deflate = constraints.deflate(EdgeInsets.only(top: topSafeAreaHeight + 96, bottom: 144.0)).maxHeight;
              debugPrint('DEFLATE: $deflate', wrapWidth: 1024);

              final enforce = constraints.enforce(const BoxConstraints(maxHeight: 404.0, minHeight: 404.0)).maxHeight;
              debugPrint('ENFORCE: $enforce', wrapWidth: 1024);

              final smallest = constraints.smallest.height;
              debugPrint('SMALLEST: $smallest', wrapWidth: 1024);

              final constrainHeight = constraints.constrainHeight(404.0);
              debugPrint('CONSTRAIN_HEIGHT: $constrainHeight', wrapWidth: 1024);

              debugPrint('-', wrapWidth: 1024);

              return FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 144.0,
                  right: 16.0,
                ),
                expandedTitleScale: 1.0,
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (((context.isPhone ? 180.0 : 228.0) - (404.0 - biggestHeight)) >= 0.0)
                      SafeArea(
                        bottom: false,
                        child: SizedBox(
                          height: 60.0,
                          child: Center(
                            child: Text(
                              'ประวัติ',
                              style: TextStyle(
                                fontSize: context.isPhone ? 24 : 32,
                                fontFamily: Assets.assetsFontsAnakotmaiLight,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      height: biggestHeight > 403.9
                          ? context.isPhone
                              ? 180.0
                              : 228.0
                          : ((context.isPhone ? 180.0 : 228.0) - (404.0 - biggestHeight)) < 0.0
                              ? 0.0
                              : (context.isPhone ? 180.0 : 228.0) - (404.0 - biggestHeight),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          if (biggestHeight > 240.0)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: biggestHeight > 320.0
                                        ? context.isPhone
                                            ? 28.0
                                            : 32.0
                                        : 0.0,
                                    backgroundImage: NetworkImage(
                                      ConvertImageComponent.getImages(imageURL: controller.dataModel.value.data?.user?.imageUrl ?? ''),
                                    ),
                                  ),
                                  if (biggestHeight > 265.0)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        controller.dataModel.value.data?.user?.displayName ?? '',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: context.isPhone
                                              ? (biggestHeight > 297.0 ? 24.0 : 16.0)
                                              : biggestHeight > 297.0
                                                  ? 32.0
                                                  : 24.0,
                                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          if (biggestHeight > 312.0)
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey.shade300,
                            ),
                          if (biggestHeight > 342.0)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'คะแนนที่ใช้ได้',
                                    style: TextStyle(
                                      fontSize: context.isPhone ? 14 : 20,
                                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    formatPoint(userPoing?.accumulatePoint ?? 0),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: context.isPhone ? 20 : 32,
                                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                      color: kPrimaryColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (biggestHeight > 373.0)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'คะแนนที่ใช้ไป',
                                    style: TextStyle(
                                      fontSize: context.isPhone ? 14 : 20,
                                      fontFamily: Assets.assetsFontsAnakotmaiLight,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    formatPoint(userPoing?.usedPoint ?? 0),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: context.isPhone ? 16 : 24,
                                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (biggestHeight > 400.0)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'คะแนนสะสม',
                                    style: TextStyle(
                                      fontSize: context.isPhone ? 14 : 20,
                                      fontFamily: Assets.assetsFontsAnakotmaiLight,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    formatPoint(userPoing?.totalPoint ?? 0),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: context.isPhone ? 16 : 24,
                                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(132.0),
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
                      'ประวัติการใช้แต้ม',
                      style: TextStyle(
                        fontSize: context.isPhone ? 20 : 24,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TabBar(
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 8.0,
                      tabs: [
                        Tab(
                          child: Container(
                            width: (context.width / 3) - 5.3,
                            height: 36,
                            decoration: BoxDecoration(
                              color: kPrimaryMFPColor,
                              border: Border.all(
                                color: Colors.blue,
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
                                  fontSize: 12,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                  color: Colors.white,
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
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'รับแต้ม',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                  color: Colors.grey.shade800,
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
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'ใช้แต้ม',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                  color: Colors.grey.shade800,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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
    bool isNegative = false;

    if (point < 0) {
      isNegative = true;
      point = point * -1;
    }

    String formattedPoint;
    if (point >= 1000000) {
      formattedPoint = "${(point / 1000000).toStringAsFixed(2)}M";
    } else {
      formattedPoint = NumberFormat("#,###").format(point);
    }

    if (isNegative) {
      formattedPoint = "-$formattedPoint";
    }

    return formattedPoint;
  }
}
