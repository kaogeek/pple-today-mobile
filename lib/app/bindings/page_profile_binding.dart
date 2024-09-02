
import 'package:get/get.dart';
import '../controllers/page_profile_controller.dart';


class PageProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageProfileController>(() => PageProfileController());
        // Get.put<PageProfileController>(PageProfileController());
  }
}