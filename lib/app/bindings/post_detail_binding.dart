
import 'package:get/get.dart';
import '../controllers/post_detail_controller.dart';


class PostDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailController>(() => PostDetailController());
        // Get.put<PostDetailController>(PostDetailController());
  }
}