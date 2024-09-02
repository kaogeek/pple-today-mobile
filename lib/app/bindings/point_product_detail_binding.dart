
import 'package:get/get.dart';
import '../controllers/point_product_detail_controller.dart';

class PointProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointProductDetailController>(() => PointProductDetailController());
        // Get.put<PointProductDetailController>(PointProductDetailController());
  }
}