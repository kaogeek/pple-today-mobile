
import 'package:get/get.dart';
import '../controllers/used_coupon_controller.dart';

class UsedCouponBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsedCouponController>(() => UsedCouponController());
        // Get.put<UsedCouponController>(UsedCouponController());
  }
}