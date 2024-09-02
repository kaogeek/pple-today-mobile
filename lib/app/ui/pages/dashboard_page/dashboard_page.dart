import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../doing_page/doing_page.dart';
import '../first_page_page/first_page_page.dart';
import '../menu_page/menu_page.dart';
import '../today_page/today_page.dart';
import 'widgets/dashboard_bottom_navigation_bar.dart';

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key}) : super(key: key);

  final _screen = [
    TodayPage(),
    FirstPagePage(),
    DoingPage(),
    MenuPage(),
  ];

  final _itemBar = [
    {
      'icon': Assets.assetsImagesTodayIcon,
      'lable': 'Today',
    },
    {
      'icon': Assets.assetsImagesFirstPage,
      'lable': 'หน้าหนึ่ง',
    },
    {
      'icon': Assets.assetsImagesGroup107112x,
      'lable': 'กำลังทำ',
    },
    {
      'icon': Assets.assetsImagesGroup116142x,
      'lable': 'เมนู',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      showIgnore: false,
      showLater: false,
      showReleaseNotes: false,
      debugLogging: kDebugMode,
      durationToAlertAgain: Duration.zero,
      child: _buildDashboard(),
    );
    // GetBuilder<DashboardController>(
    //   init: DashboardController(),
    //   initState: (_) {},
    //   builder: (_) {
    //     return _.disabledUpdate
    //         ? _buildDashboard()
    //         : UpgradeAlert(
    //             showIgnore: false,
    //             showLater: false,
    //             showReleaseNotes: false,
    //             durationToAlertAgain: Duration.zero,
    //             child: _buildDashboard(),
    //           );
    //   },
    // );
  }

  Widget _buildDashboard() {
    /// New code
    return DefaultTabController(
      length: _screen.length,
      child: MainLayoutView(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: _screen,
        ),
        bottomNavigationBar: DashboardBottomNavigationBar(children: _itemBar),
      ),
    );

    /// Old code
    /* return DefaultTabController(
      length: _screen.length,
      child: MainLayoutView(
        body: RefreshIndicator(
          onRefresh: controller.onRefresh,
          color: kPrimaryColor,
          child: CustomScrollView(
            controller: controller.scrollController,
            shrinkWrap: true,
            slivers: [
              DashboardAppBar(),
              DashboardBody(children: _screen),
              // SliverFillRemaining(
              //   fillOverscroll: true,
              //   child: GetBuilder<DashboardController>(
              //     init: DashboardController(),
              //     initState: (_) {},
              //     builder: (_) {
              //       return TabBarView(
              //         physics: const NeverScrollableScrollPhysics(),
              //         children: _screen,
              //       );
              //     },
              //   ),
              // ),

              // SliverToBoxAdapter(
              //   child: Stack(
              //     children: _screen
              //         .asMap()
              //         .map((i, e) => MapEntry(
              //               i,
              //               GetBuilder<DashboardController>(
              //                 init: DashboardController(),
              //                 initState: (_) {},
              //                 builder: (_) {
              //                   print('i: $i');
              //                   print('controller.selectedIndex: ${controller.selectedIndex}');
              //                   return Offstage(
              //                     offstage: controller.selectedIndex != i,
              //                     child: e,
              //                   );
              //                 },
              //               ),
              //             ))
              //         .values
              //         .toList(),
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: DashboardBottomNavigationBar(children: _itemBar),
      ),
    ); */
  }
}
