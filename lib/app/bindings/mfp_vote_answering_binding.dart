import 'package:get/get.dart';

import '../controllers/mfp_vote_answering_controller.dart';

class MfpVoteAnsweringBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteAnsweringController>(() => MfpVoteAnsweringController());
    // Get.put<AnsweringController>(AnsweringController());
    Get.create<MfpVoteAnsweringController>(() => MfpVoteAnsweringController());
  }
}
