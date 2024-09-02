
import 'package:get/get.dart';
import '../controllers/point_category_controller.dart';

class PointCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointCategoryController>(() => PointCategoryController());
        // Get.put<PointCategoryController>(PointCategoryController());
  }
}