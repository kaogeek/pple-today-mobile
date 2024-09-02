import 'package:get/get.dart';
import '../controllers/user_coupont_controller.dart';

class UserCouponBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCouponController>(() => UserCouponController());
    Get.put<UserCouponController>(UserCouponController());
  }
}
