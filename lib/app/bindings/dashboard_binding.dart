import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/today_controller.dart';
import '../controllers/today_recommend_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<TodayController>(() => TodayController());

    Get.create<TodayRecommendController>(() => TodayRecommendController());
    // Get.put<DashboardController>(DashboardController());
  }
}
