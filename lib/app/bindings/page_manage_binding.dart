import 'package:get/get.dart';

import '../controllers/page_manage_body_controller.dart';
import '../controllers/page_manage_controller.dart';

class PageManageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageManageController>(() => PageManageController());
    // Get.put<PageManageController>(PageManageController());
    Get.create<PageManageBodyController>(() => PageManageBodyController());
  }
}
