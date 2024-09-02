
import 'package:get/get.dart';
import '../controllers/account_merge_controller.dart';


class AccountMergeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountMergeController>(() => AccountMergeController());
        // Get.put<AccountMergeController>(AccountMergeController());
  }
}