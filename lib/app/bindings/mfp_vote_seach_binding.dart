
import 'package:get/get.dart';
import '../controllers/mfp_vote_seach_controller.dart';

class MfpVoteSeachBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteSeachController>(() => MfpVoteSeachController());
        // Get.put<MfpVoteSeachController>(MfpVoteSeachController());
  }
}