
import 'package:get/get.dart';
import '../controllers/hash_tag_controller.dart';


class HashTagBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HashTagController>(() => HashTagController());
        // Get.put<HashTagController>(HashTagController());
  }
}