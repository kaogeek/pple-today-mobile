
import 'package:get/get.dart';
import '../controllers/detail_first_controller.dart';

class DetailFirstBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailFirstController>(() => DetailFirstController());
        // Get.put<FirstController>(FirstController());
  }
}