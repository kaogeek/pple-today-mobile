
import 'package:get/get.dart';
import '../controllers/web_view_login_mfp_controller.dart';


class WebViewLoginMfpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebViewLoginMfpController>(() => WebViewLoginMfpController());
        // Get.put<WebViewLoginMfpController>(WebViewLoginMfpController());
  }
}