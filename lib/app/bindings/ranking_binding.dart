import 'package:get/get.dart';
import '../controllers/ranking_controller.dart';

class RankingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingController>(() => RankingController());
    Get.put<RankingController>(RankingController());
  }
}
