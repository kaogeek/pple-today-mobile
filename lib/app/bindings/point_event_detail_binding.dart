
import 'package:get/get.dart';
import '../controllers/point_event_detail_controller.dart';

class PointEventDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointEventDetailController>(() => PointEventDetailController());
        // Get.put<PointEventDetailController>(PointEventDetailController());
  }
}