import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/response_model.dart';
import '../data/services/point_service.dart';

class PointEventDetailController extends GetxController {
  final _parameters = Get.parameters;
  get eventId => _parameters['pointEventId'] ?? '';

  late Rx<ResponseModel> dataModel, receivePoint;

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _selectTab = 0.obs;
  get selectTab => _selectTab.value;
  set selectTab(value) => _selectTab.value = value;

  @override
  void onInit() {
    isLoading = true;

    dataModel = ResponseModel().obs;
    receivePoint = ResponseModel().obs;

    debugPrint('EVENT_ID: $eventId', wrapWidth: 1024);
    super.onInit();
  }

  @override
  void onReady() {
    fetchPointEventId().then((_) => isLoading = false);
    super.onReady();
  }

  Future<void> fetchPointEventId() async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchPointEventId(eventId: eventId);

    if (response.isOk) {
      dataModel.value = ResponseModel.fromJson(response.body);
    } else {
      debugPrint(response.body);
    }
  }

  Future<ResponseModel> fetchReceivePointCoupon({
    required String title,
    required String detail,
    required int point,
  }) async {
    PointService service = Get.put(PointService());

    Response response = await service.receivePointCoupon(
      title: title,
      detail: detail,
      point: point,
      eventId: eventId,
    );

    if (response.isOk) {
      return receivePoint.value = ResponseModel.fromJson({
        'status': response.body['status'],
        'message': response.body['message'],
        'data': {'receivePoint': response.body['data']},
      });
    } else {
      return receivePoint.value = ResponseModel.fromJson(response.body);
    }
  }
}
