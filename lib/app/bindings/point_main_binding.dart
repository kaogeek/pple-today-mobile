import 'package:get/get.dart';
import '../controllers/point_main_controller.dart';

class PointMainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointMainController>(() => PointMainController());
    Get.put<PointMainController>(PointMainController());
  }
}
