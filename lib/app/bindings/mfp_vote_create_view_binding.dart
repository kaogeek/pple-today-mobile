
import 'package:get/get.dart';
import '../controllers/mfp_vote_create_view_controller.dart';

class MfpVoteCreateViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteCreateViewController>(() => MfpVoteCreateViewController());
        // Get.put<MfpVoteCreateViewController>(MfpVoteCreateViewController());
  }
}