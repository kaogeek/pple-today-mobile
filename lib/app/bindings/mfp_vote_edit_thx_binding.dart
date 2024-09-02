
import 'package:get/get.dart';
import '../controllers/mfp_vote_edit_thx_controller.dart';

class MfpVoteEditThxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteEditThxController>(() => MfpVoteEditThxController());
        // Get.put<MfpVoteEditThxController>(MfpVoteEditThxController());
  }
}