import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/response_model.dart';
import '../data/services/point_service.dart';

class PointCategoryController extends GetxController {
  final _parameters = Get.parameters;
  get categoryId => _parameters['categoryId'] ?? '';

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  var dataModel = ResponseModel().obs;

  @override
  void onInit() {
    isLoading = true;
    debugPrint('CATEGORY_ID: $categoryId', wrapWidth: 1024);
    super.onInit();
  }

  @override
  void onReady() {
    fetchPointCategoryId().then((_) => isLoading = false);
    super.onReady();
  }

  Future<void> fetchPointCategoryId() async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchPointCategoryId(categoryId: categoryId);

    if (response.isOk) {
      dataModel.value = ResponseModel.fromJson(response.body);
    } else {
      debugPrint(response.body, wrapWidth: 1024);
    }
  }
}
