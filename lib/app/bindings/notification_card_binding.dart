
import 'package:get/get.dart';
import '../controllers/notification_card_controller.dart';


class NotificationCardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationCardController>(() => NotificationCardController());
        // Get.put<NotificationCardController>(NotificationCardController());
  }
}