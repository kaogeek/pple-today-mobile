import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/point_category_controller.dart';
import 'widgets/app_bar_point_category.dart';
import 'widgets/body_point_category.dart';

class PointCategoryPage extends GetView<PointCategoryController> {
  const PointCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCategory(),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const BodyPointCategory();
      }),
    );
  }

  

  

  

  

  
}
