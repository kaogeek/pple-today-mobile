
import 'package:get/get.dart';
import '../controllers/mfp_vote_edit_item_controller.dart';

class MfpVoteEditItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteEditItemController>(() => MfpVoteEditItemController());
        // Get.put<MfpVoteEditItemController>(MfpVoteEditItemController());
  }
}