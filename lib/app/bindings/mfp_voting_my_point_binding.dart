
import 'package:get/get.dart';
import '../controllers/mfp_voting_my_point_controller.dart';

class MfpVotingMyPointBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVotingMyPointController>(() => MfpVotingMyPointController());
        // Get.put<MfpVotingMyPointController>(MfpVotingMyPointController());
  }
}