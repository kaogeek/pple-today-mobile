
import 'package:get/get.dart';
import '../controllers/webview_emergency_controller.dart';


class WebviewEmergencyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebviewEmergencyController>(() => WebviewEmergencyController());
        // Get.put<WebviewEmergencyController>(WebviewEmergencyController());
  }
}