import 'package:get/get.dart';
import '../controllers/mfp_vote_dashboard_controller.dart';

class MfpVoteDashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteDashboardController>(() => MfpVoteDashboardController());
    // Get.put<MfpVoteDashboardController>(MfpVoteDashboardController());
  }
}
