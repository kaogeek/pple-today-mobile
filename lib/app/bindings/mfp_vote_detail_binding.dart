import 'package:get/get.dart';
import '../controllers/mfp_vote_detail_controller.dart';

class MfpVoteDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteDetailController>(() => MfpVoteDetailController());
    // Get.put<MfpVoteDetailController>(MfpVoteDetailController());
    Get.create<MfpVoteDetailController>(() => MfpVoteDetailController());
  }
}
