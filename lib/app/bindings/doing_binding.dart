
import 'package:get/get.dart';
import '../controllers/doing_controller.dart';


class DoingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoingController>(() => DoingController());
        // Get.put<DoingController>(DoingController());
  }
}