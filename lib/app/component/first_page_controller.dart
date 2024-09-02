import 'dart:developer';

import 'package:get/get.dart';

import '../data/models/first_page_model.dart';
import '../data/services/today_service.dart';

class FirstPageController extends GetxController {
  final _service = TodayService();

  Rx<FirstPageModel> firstPageModel = FirstPageModel().obs;

  @override
  void onInit() {
    fetchContentMobile();
    super.onInit();
  }

  Future<void> fetchContentMobile() async {
    try {
      Response response = await _service.getMainContentMobile();

      firstPageModel.value = FirstPageModel.fromJson(response.body);
    } catch (e) {
      log('', error: e, name: 'fetchContentMobile');
      firstPageModel.value = FirstPageModel(
        status: 0,
        message: 'ขออภัย เกิดข้อผิดพลาดในการเชื่อมต่อระบบ',
        data: null,
      );
    }
    return;
  }
}
