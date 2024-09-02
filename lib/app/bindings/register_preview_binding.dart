
import 'package:get/get.dart';
import '../controllers/register_preview_controller.dart';


class RegisterPreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPreviewController>(() => RegisterPreviewController());
        // Get.put<RegisterPreviewController>(RegisterPreviewController());
  }
}