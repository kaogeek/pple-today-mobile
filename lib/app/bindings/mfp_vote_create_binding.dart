import 'package:get/get.dart';
import '../controllers/mfp_vote_create_controller.dart';

class MfpVoteCreateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteCreateController>(() => MfpVoteCreateController());
    // Get.put<MfpVoteCreateController>(MfpVoteCreateController());
    Get.create<MfpVoteCreateController>(() => MfpVoteCreateController());
  }
}
