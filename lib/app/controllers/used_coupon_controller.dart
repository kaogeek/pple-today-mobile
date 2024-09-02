import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/response_model.dart';
import '../data/services/point_service.dart';



class UsedCouponController extends GetxController {
  final _parameters = Get.parameters;
  get couponId => _parameters['couponId']!;
  get productId => _parameters['productId']!;
  get _expireDate => _parameters['expireDate']!;

  final _expireDay = '-\nวัน'.obs;
  get expireDay => _expireDay.value;
  set expireDay(value) => _expireDay.value = value;

  final _expireHours = '-\nชั่วโมง'.obs;
  get expireHours => _expireHours.value;
  set expireHours(value) => _expireHours.value = value;

  final _expireMinutes = '-\nนาที'.obs;
  get expireMinutes => _expireMinutes.value;
  set expireMinutes(value) => _expireMinutes.value = value;

  final _expireSeconds = '-\nวินาที'.obs;
  get expireSeconds => _expireSeconds.value;
  set expireSeconds(value) => _expireSeconds.value = value;

  late Timer _timer;
  late Rx<ResponseModel> usedCouponModel;

  @override
  void onInit() {
    usedCouponModel = ResponseModel().obs;
    debugPrint('COUPON_ID: $couponId', wrapWidth: 1024);
    debugPrint('PRODUCT_ID: $productId', wrapWidth: 1024);
    debugPrint('EXPIRE_DATE: $_expireDate', wrapWidth: 1024);
    super.onInit();
  }

  @override
  void onReady() {
    startCountdownExpireDate();
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void startCountdownExpireDate() {
    DateTime expireDate = DateTime.parse(_expireDate);

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      DateTime now = DateTime.now();
      Duration difference = expireDate.difference(now);

      if (difference.isNegative) {
        expireDay = '-\nวัน';
        expireHours = '-\nชั่วโมง';
        expireMinutes = '-\nนาที';
        expireSeconds = '-\nวินาที';
        debugPrint('Expired !');
        t.cancel();
      } else {
        expireDay = '${difference.inDays}\nวัน';
        expireHours = '${difference.inHours % 24}\nชั่วโมง';
        expireMinutes = '${difference.inMinutes % 60}\nนาที';
        expireSeconds = '${difference.inSeconds % 60}\nวินาที';
      }
    });
  }

  Future<ResponseModel> fetchUsedCoupon() async {
    PointService service = Get.put(PointService());

    Response response = await service.usedCoupon(
      couponId: couponId,
      productId: productId,
    );

    if (response.isOk) {
      return usedCouponModel.value = ResponseModel.fromJson(response.body);
    } else {
      return usedCouponModel.value = ResponseModel.fromJson({
        'status': response.body['status'],
        'message': response.body['message'],
      });
    }
  }
}
