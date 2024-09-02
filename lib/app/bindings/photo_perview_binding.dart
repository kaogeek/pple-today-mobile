import 'package:get/get.dart';
import '../controllers/photo_perview_controller.dart';

class PhotoPerviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoPeriewController>(() => PhotoPeriewController());
    Get.put<PhotoPeriewController>(PhotoPeriewController());
  }
}
