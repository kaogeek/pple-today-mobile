
import 'package:get/get.dart';
import '../controllers/login_register_controller.dart';


class LoginRegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRegisterController>(() => LoginRegisterController());
        // Get.put<LoginRegisterController>(LoginRegisterController());
  }
}