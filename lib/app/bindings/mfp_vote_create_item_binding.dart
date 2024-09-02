import 'package:get/get.dart';
import '../controllers/mfp_vote_create_item_controller.dart';

class MfpVoteCreateItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MfpVoteCreateItemController>(() => MfpVoteCreateItemController());
    // Get.put<MfpVoteCreateItemController>(MfpVoteCreateItemController());
    Get.create<MfpVoteCreateItemController>(() => MfpVoteCreateItemController());
  }
}
