
import 'package:get/get.dart';
import '../component/first_page_controller.dart';

class FirstPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstPageController>(() => FirstPageController());
        // Get.put<FirstPageController>(FirstPageController());
  }
}