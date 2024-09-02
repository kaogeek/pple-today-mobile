// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/first_page_controller.dart';
import '../../../controllers/dashboard_controller.dart';
import '../dashboard_page/widgets/dashboard_app_bar.dart';
import 'widgets/past_30_days_card.dart';
import 'widgets/past_7_days_card.dart';
import 'widgets/popular_news.dart';
import 'widgets/topic_card.dart';

class FirstPagePage extends GetView<FirstPageController> {
  FirstPagePage({super.key});

  @override
  FirstPageController controller = Get.put(FirstPageController());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    /// New code
    return Scaffold(
      body: CustomScrollView(
        controller: dashboardController.scrollController2,
        shrinkWrap: true,
        slivers: [
          DashboardAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                // TODO:  แก้ไขเป็นเช็คว่ามีข้อมูลหรือไม่ ถ้าไม่มีให้แสดงว่าไม่มีข้อมูล
                // if (controller.firstPageModel.value.data == null) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }

                if (controller.firstPageModel.value.data?.today == null &&
                    (controller.firstPageModel.value.data?.todayPast7Days ?? []).isEmpty &&
                    (controller.firstPageModel.value.data?.todayPast30Days ?? []).isEmpty &&
                    (controller.firstPageModel.value.data?.popularNews ?? []).isEmpty) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height - (kToolbarHeight - kBottomNavigationBarHeight - 16),
                    child: Center(
                      child: Text(
                        'ไม่มีข้อมูล',
                        style: TextStyle(fontSize: context.isPhone ? 24 : 32),
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TopicCard(),
                    Past7DaysCard(),
                    Past30DaysCard(),
                    PopularNews(),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );

    /// Old code
    /* return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        if (controller.firstPageModel.value.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.firstPageModel.value.data?.today == null &&
            (controller.firstPageModel.value.data?.todayPast7Days ?? []).isEmpty &&
            (controller.firstPageModel.value.data?.todayPast30Days ?? []).isEmpty &&
            (controller.firstPageModel.value.data?.popularNews ?? []).isEmpty) {
          return SizedBox(
            width: Get.width,
            height: Get.height - (kToolbarHeight - kBottomNavigationBarHeight - 16),
            child: Center(
              child: Text(
                'ไม่มีข้อมูล',
                style: TextStyle(fontSize: context.isPhone ? 24 : 32),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TopicCard(),
            Past7DaysCard(),
            Past30DaysCard(),
            PopularNews(),
          ],
        );
      }),
    ); */
  }
}
