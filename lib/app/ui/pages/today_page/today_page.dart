// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../controllers/today_controller.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../dashboard_page/widgets/dashboard_app_bar.dart';
import 'widgets/today_banner.dart';
import 'widgets/today_announcement.dart';
import 'widgets/today_time_line.dart';

class TodayPage extends GetView<TodayController> {
  TodayPage({Key? key}) : super(key: key);

  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    /// New code
    return Scaffold(
      body: CustomScrollView(
        controller: dashboardController.scrollController1,
        shrinkWrap: true,
        slivers: [
          DashboardAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const TodayAnnouncement(),
                TodayBanner(),
                Container(
                  width: Get.width,
                  height: kToolbarHeight,
                  color: primaryGrey,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Center(
                      child: Text(
                        'ประชาชนวันนี้',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                TodayTimeLine(),
              ],
            ),
          ),
        ],
      ),
    );

    /// Old code
    /* return Column(
      children: [
        const TodayAnnouncement(),
        TodayBanner(),
        Container(
          width: Get.width,
          height: kToolbarHeight,
          color: primaryGrey,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Text(
                'ประชาชนวันนี้',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
          ),
        ),
        TodayTimeLine(),
      ],
    ); */
  }
}
