import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/dashboard_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class DashboardBottomNavigationBar extends StatelessWidget {
  final List children;

  const DashboardBottomNavigationBar({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    /// New code
    /// Tab bar Bottom
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (controller) {
        return TabBar(
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            fontFamily: Assets.assetsFontsAnakotmaiLight,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          // indicatorPadding: const EdgeInsets.all(8.0),
          indicatorColor: Colors.transparent,
          padding: const EdgeInsets.only(bottom: 8.0),
          onTap: controller.onItemTapped,
          tabs: children
              .asMap()
              .map((index, value) {
                return MapEntry(
                  index,
                  Tab(
                    icon: Image.asset(
                      value['icon'],
                      color: index == controller.selectedIndex ? kPrimaryColor : Colors.grey,
                      height: 17,
                    ),
                    text: value['lable'],
                  ),
                );
              })
              .values
              .toList(),
        );
      },
    );

    /// Old code
    /* return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (controller) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
          items: children
              .asMap()
              .map((index, value) {
                return MapEntry(
                  index,
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Image.asset(
                        value['icon'],
                        color: index == controller.selectedIndex ? kPrimaryColor : Colors.grey,
                        height: 17,
                      ),
                    ),
                    label: value['lable'],
                    tooltip: value['lable'],
                  ),
                );
              })
              .values
              .toList(),
          currentIndex: controller.selectedIndex,
          onTap: controller.onItemTapped,
        );
      },
    ); */
  }
}
