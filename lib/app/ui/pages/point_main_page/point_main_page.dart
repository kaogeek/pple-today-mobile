import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/point_main_controller.dart';
import 'widgets/app_bar_point_main.dart';
import 'widgets/banner_point_main.dart';
import 'widgets/body_point_main.dart';
import 'widgets/tab_bar_point_main.dart';

class PointMainPage extends GetView<PointMainController> {
  const PointMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPointMain(),
      body: Obx(() => controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TabBarPointMain(),
                  if ((controller.pointContentModel.value.data?.pointEvent ?? []).isEmpty &&
                      (controller.pointContentModel.value.data?.categoryProduct ?? []).isEmpty &&
                      (controller.pointContentModel.value.data?.productAggr ?? []).isEmpty)
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'ไม่มีข้อมูล',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  const BannerPointMain(),
                  const BodyPointMain(),
                ],
              ),
            )),
    );
  }
}
