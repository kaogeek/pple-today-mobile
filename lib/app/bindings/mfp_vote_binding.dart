
import 'package:get/get.dart';
import '../controllers/mfp_vote_controller.dart';

class MfpVoteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteController>(() => MfpVoteController());
        // Get.put<MfpVoteController>(MfpVoteController());
  }
}