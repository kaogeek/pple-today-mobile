
import 'package:get/get.dart';
import '../controllers/sync_page_social_controller.dart';


class SyncPageSocialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SyncPageSocialController>(() => SyncPageSocialController());
        // Get.put<SyncPageSocialController>(SyncPageSocialController());
  }
}