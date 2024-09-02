
import 'package:get/get.dart';
import '../controllers/mfp_vote_post_all_controller.dart';

class MfpVotePostAllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVotePostAllController>(() => MfpVotePostAllController());
        // Get.put<MfpVotePostAllController>(MfpVotePostAllController());
  }
}