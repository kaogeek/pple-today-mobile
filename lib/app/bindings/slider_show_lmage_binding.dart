import 'package:get/get.dart';

import '../controllers/slider_show_image_controller.dart';

class SliderShowImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SliderShowImageController>(() => SliderShowImageController());
    // Get.put<SliderShowLmageController>(SliderShowLmageController());
  }
}
