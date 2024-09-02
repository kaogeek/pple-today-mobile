
import 'package:get/get.dart';
import '../controllers/user_point_controller.dart';

class UserPointBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPointController>(() => UserPointController());
        // Get.put<UserPointController>(UserPointController());
  }
}