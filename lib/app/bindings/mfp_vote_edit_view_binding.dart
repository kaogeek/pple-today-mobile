
import 'package:get/get.dart';
import '../controllers/mfp_vote_edit_view_controller.dart';

class MfpVoteEditViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteEditViewController>(() => MfpVoteEditViewController());
        // Get.put<MfpVoteEditViewController>(MfpVoteEditViewController());
  }
}