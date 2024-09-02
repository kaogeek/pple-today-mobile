
import 'package:get/get.dart';
import '../controllers/connect_social_media_controller.dart';


class ConnectSocialMediaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectSocialMediaController>(() => ConnectSocialMediaController());
        // Get.put<ConnectSocialMediaController>(ConnectSocialMediaController());
  }
}