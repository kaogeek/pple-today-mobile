import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/point_event_detail_controller.dart';
import '../../utils/assets.dart';
import 'widgets/app_bar_point_event_detail.dart';
import 'widgets/banner_image_point_event_detail.dart';
import 'widgets/button_bottom_navigation_point_event_detail.dart';
import 'widgets/custom_tab_bar_point_event_detail.dart';
import 'widgets/custom_tab_view_point_event_detail.dart';
import 'widgets/text_point_event_detail.dart';

class PointEventDetailPage extends GetView<PointEventDetailController> {
  const PointEventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPointPointEventDetail(),
      body: Obx(() {
        final pointEventDetail = controller.dataModel.value.data?.pointEventDetail;

        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (pointEventDetail == null) {
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

        return DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BannerImagePointEventDetail(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TextPointEventDetail(),
                      // LinearProgressPointEventDetail(),
                      CustomTabBarPointEventDetail(),
                      CustomTabViewPointEventDetail(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: const ButtonBottomNavigationPointEventDetail(),
    );
  }
}
