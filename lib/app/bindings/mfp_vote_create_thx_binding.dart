
import 'package:get/get.dart';
import '../controllers/mfp_vote_create_thx_controller.dart';

class MfpVoteCreateThxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteCreateThxController>(() => MfpVoteCreateThxController());
        // Get.put<MfpVoteCreateThxController>(MfpVoteCreateThxController());
  }
}