
import 'package:get/get.dart';
import '../controllers/privacy_policy_controller.dart';


class PrivacyPolicyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());
        // Get.put<PrivacyPolicyController>(PrivacyPolicyController());
  }
}