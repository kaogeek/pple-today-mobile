import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/models/response_model.dart';
import '../data/services/point_service.dart';

class UserPointController extends GetxController {
  final dataModel = ResponseModel().obs;

  final _selectTab = 0.obs;
  get selectTab => _selectTab.value;
  set selectTab(value) => _selectTab.value = value;

  final _biggest = 0.0.obs;
  double get biggest => _biggest.value;
  set biggest(double value) => _biggest.value = value;

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  DateFormat formatter = DateFormat('d MMM yyyy', 'th_TH');

  @override
  void onInit() {
    isLoading = true;
    super.onInit();
  }

  @override
  void onReady() {
    fetchSarchUserPoint().then((_) => isLoading = false);
    super.onReady();
  }

  Future<void> fetchSarchUserPoint({int offset = 0}) async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchUserPoint(offset: offset);

    if (response.isOk) {
      dataModel.value = ResponseModel.fromJson(response.body);
    } else {
      debugPrint('${response.body}', wrapWidth: 1024);
    }

    return;
  }
}
