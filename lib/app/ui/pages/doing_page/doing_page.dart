// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../controllers/doing_controller.dart';
import '../../utils/colors.dart';
import '../dashboard_page/widgets/dashboard_app_bar.dart';
import 'widgets/doing_ever_done.dart';
import 'widgets/doing_month_ago.dart';

class DoingPage extends GetView<DoingController> {
  DoingPage({Key? key}) : super(key: key);

  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    /// New code
    return Scaffold(
      body: CustomScrollView(
        controller: dashboardController.scrollController3,
        shrinkWrap: true,
        slivers: [
          DashboardAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: kPrimaryColor,
                  width: Get.width,
                  height: 60,
                  child: const Center(
                    child: Text(
                      'สิ่งที่ "พรรคประชาชน" กำลังทำอยู่',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const DoingMonthAgo(),
                const DoingEverDone(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Divider(
                    color: Colors.grey[200],
                    height: 10,
                    thickness: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    /// Old code
    /*  return Column(
      children: [
        Container(
          color: kPrimaryColor,
          width: Get.width,
          height: 60,
          child: const Center(
            child: Text(
              'สิ่งที่ "พรรคประชาชน" กำลังทำอยู่',
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ),
        const DoingMonthAgo(),
        const DoingEverDone(),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Divider(
            color: Colors.grey[200],
            height: 10,
            thickness: 9,
          ),
        ),
      ],
    ); */
  }
}
