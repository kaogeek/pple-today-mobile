
import 'package:get/get.dart';
import '../controllers/profile_detail_social_controller.dart';


class ProfileDetailSocialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileDetailSocialController>(() => ProfileDetailSocialController());
        // Get.put<ProfileDetailSocialController>(ProfileDetailSocialController());
  }
}