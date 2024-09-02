import 'package:get/get.dart';
import '../controllers/mfp_vote_edit_controller.dart';

class MfpVoteEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteEditController>(() => MfpVoteEditController());
    Get.create<MfpVoteEditController>(() => MfpVoteEditController());
    // Get.put<MfpVoteEditController>(MfpVoteEditController());
  }
}
