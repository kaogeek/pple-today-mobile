
import 'package:get/get.dart';
import '../controllers/mfp_vote_resultes_controller.dart';

class MfpVoteResultesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteResultesController>(() => MfpVoteResultesController());
        // Get.put<MfpVoteResultesController>(MfpVoteResultesController());
  }
}