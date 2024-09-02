import 'package:get/get.dart';

import '../data/models/recommend_user_model.dart';
import 'today_controller.dart';

class TodayRecommendController extends GetxController {
  final _todayController = Get.find<TodayController>();

  var recommend = RecommendUserModel().obs;

  void setData(RecommendUserModel data) {
    recommend.value = data;
  }

  void fetchFollowed({required String pageId, required String type}) {
    _todayController.fetchFollowed(pageId: pageId, type: type);
  }
}
