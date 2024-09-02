import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/response_model.dart';
import '../data/services/point_service.dart';

class UserCouponController extends GetxController {
  late Rx<ResponseModel> readyCouponModel, alreadyCouponModel, expireCouponModel;

  ScrollController scrollController = ScrollController();

  final DateTime now = DateTime.now();

  final _isLoading1 = true.obs;
  get isLoading1 => _isLoading1.value;
  set isLoading1(value) => _isLoading1.value = value;

  final _isLoading2 = true.obs;
  get isLoading2 => _isLoading2.value;
  set isLoading2(value) => _isLoading2.value = value;

  final _isLoading3 = true.obs;
  get isLoading3 => _isLoading3.value;
  set isLoading3(value) => _isLoading3.value = value;

  final _selectTab = 'REDEEM'.obs;
  get selectTab => _selectTab.value;
  set selectTab(value) => _selectTab.value = value;

  @override
  void onInit() {
    isLoading1 = true;
    isLoading2 = true;
    isLoading3 = true;

    readyCouponModel = ResponseModel().obs;
    alreadyCouponModel = ResponseModel().obs;
    expireCouponModel = ResponseModel().obs;

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        debugPrint('Load more', wrapWidth: 1024);
        switch (selectTab) {
          case 'REDEEM':
            fetchSarchUserCouponRedeem(offset: readyCouponModel.value.data!.readyCoupon!.length);
            break;

          case 'USE_COUPON':
            fetchSarchUserCouponUse(offset: alreadyCouponModel.value.data!.alreadyCoupon!.length);
            break;

          case 'COUPON_HAS_EXPIRED':
            fetchSarchUserCouponExpired(offset: expireCouponModel.value.data!.expireCoupon!.length);
            break;
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    fetchSarchUserCouponRedeem().then((_) => isLoading1 = false);
    fetchSarchUserCouponUse().then((_) => isLoading2 = false);
    fetchSarchUserCouponExpired().then((_) => isLoading3 = false);
    super.onReady();
  }

  Future<void> fetchSarchUserCouponRedeem({int offset = 0, String? type}) async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchUserCoupon(
      limit: 10,
      offset: offset,
      type: "REDEEM",
    );

    if (response.isOk) {
      offset == 0
          ? readyCouponModel.value = ResponseModel.fromJson(response.body)
          : readyCouponModel.update((val) {
              val!.data!.readyCoupon!.addAll(ResponseModel.fromJson(response.body).data?.readyCoupon ?? []);
            });
    } else {
      debugPrint('${response.body}', wrapWidth: 1024);
    }

    return;
  }

  Future<void> fetchSarchUserCouponUse({int offset = 0, String? type}) async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchUserCoupon(
      limit: 10,
      offset: offset,
      type: "USE_COUPON",
    );

    if (response.isOk) {
      offset == 0
          ? alreadyCouponModel.value = ResponseModel.fromJson(response.body)
          : alreadyCouponModel.update((val) {
              val!.data!.alreadyCoupon!.addAll(ResponseModel.fromJson(response.body).data?.alreadyCoupon ?? []);
            });
    } else {
      debugPrint('${response.body}', wrapWidth: 1024);
    }

    return;
  }

  Future<void> fetchSarchUserCouponExpired({int offset = 0, String? type}) async {
    PointService service = Get.put(PointService());

    Response response = await service.sarchUserCoupon(
      limit: 10,
      offset: offset,
      type: "COUPON_HAS_EXPIRED",
    );

    if (response.isOk) {
      offset == 0
          ? expireCouponModel.value = ResponseModel.fromJson(response.body)
          : expireCouponModel.update((val) {
              val!.data!.expireCoupon!.addAll(ResponseModel.fromJson(response.body).data?.expireCoupon ?? []);
            });
    } else {
      debugPrint('${response.body}', wrapWidth: 1024);
    }

    return;
  }
}
