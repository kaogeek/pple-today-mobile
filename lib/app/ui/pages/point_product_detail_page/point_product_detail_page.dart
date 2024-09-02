import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/point_product_detail_controller.dart';
import '../../utils/assets.dart';
import 'widgets/app_bar_point_product_detail.dart';
import 'widgets/banner_image_point_product_detail.dart';
import 'widgets/button_bottom_navigation_point_product_detail.dart';
import 'widgets/custom_tab_bar_point_product_detail.dart';
import 'widgets/custom_tab_view_point_product_detail.dart';
import 'widgets/linear_progress_point_product_detail.dart';
import 'widgets/text_point_product_detail.dart';
import 'widgets/using_point_product_detail.dart';

class PointProductDetailPage extends GetView<PointProductDetailController> {
  const PointProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPointPointProductDetail(),
      body: Obx(() {
        final productDetail = controller.dataModel.value.data?.productDetail;

        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (productDetail == null) {
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
                const BannerImagePointProductDetail(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TextPointProductDetail(),
                      UsingPointProductDetail(),
                      LinearProgressPointProductDetail(),
                      CustomTabBarPointProductDetail(),
                      CustomTabViewPointProductDetail(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: const ButtonBottomNavigationPointProductDetail(),
    );
  }
}
