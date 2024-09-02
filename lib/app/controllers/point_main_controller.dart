import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/point_content_model.dart';
import '../data/services/point_service.dart';

class PointMainController extends GetxController {
  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  late Rx<PointContentModel> pointContentModel;
  late ConfettiController confettiController;

  @override
  void onInit() {
    isLoading = true;
    pointContentModel = PointContentModel().obs;
    confettiController = ConfettiController(duration: const Duration(seconds: 1));
    super.onInit();
  }

  @override
  void onReady() {
    getPointContent().then((_) => isLoading = false);
    super.onReady();
  }

  Future<void> getPointContent() async {
    PointService service = Get.put(PointService());

    Response response = await service.getPointContent();

    if (response.isOk) {
      pointContentModel.value = PointContentModel.fromJson(response.body);
    } else {
      debugPrint(response.body);
    }
    return;
  }
}
