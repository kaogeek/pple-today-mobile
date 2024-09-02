// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/response_model.dart';
import '../data/services/point_service.dart';


class PointProductDetailController extends GetxController {
  final _parameters = Get.parameters;
  get productId => _parameters['pointProductId']!;

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _selectTab = 0.obs;
  get selectTab => _selectTab.value;
  set selectTab(value) => _selectTab.value = value;

  late Rx<ResponseModel> dataModel, redeemCoupon, usedCoupon;

  @override
  void onInit() {
    isLoading = true;
    dataModel = ResponseModel().obs;
    redeemCoupon = ResponseModel().obs;
    usedCoupon = ResponseModel().obs;
    debugPrint('PRODUCT_ID: $productId', wrapWidth: 1024);
    super.onInit();
  }

  @override
  void onReady() {
    fetchSarchPointProductId().then((_) => isLoading = false);
    super.onReady();
  }

  Future<void> fetchSarchPointProductId() async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchPointProductId(productId: productId);

    if (response.isOk) {
      dataModel.value = ResponseModel.fromJson(response.body);
    } else {
      debugPrint(response.body, wrapWidth: 1024);
    }
  }

  Future<ResponseModel> fetchRedeemCoupon({
    required String title,
    required String detail,
    required int point,
  }) async {
    PointService service = Get.put(PointService());

    Response response = await service.redeemCoupon(
      title: title,
      detail: detail,
      point: point,
      productId: productId,
    );

    if (response.isOk) {
      return redeemCoupon.value = ResponseModel.fromJson({
        'status': response.body['status'],
        'message': response.body['message'],
        'data': {'redeemCoupon': response.body['data']},
      });
    } else {
      return redeemCoupon.value = ResponseModel.fromJson(response.body);
    }
  }

  Future<void> fetchUsedCoupon({required String couponId}) async {
    PointService service = Get.put(PointService());

    Response response = await service.usedCoupon(
      couponId: couponId,
      productId: productId,
    );

    if (response.isOk) {
      usedCoupon.value = ResponseModel.fromJson(response.body);
    } else {
      debugPrint(response.body, wrapWidth: 1024);
    }
  }
}
