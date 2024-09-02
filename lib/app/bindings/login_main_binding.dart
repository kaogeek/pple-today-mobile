
import 'package:get/get.dart';
import '../controllers/login_main_controller.dart';


class LoginMainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginMainController>(() => LoginMainController());
        // Get.put<LoginMainController>(LoginMainController());
  }
}