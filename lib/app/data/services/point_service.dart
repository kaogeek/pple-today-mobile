import 'dart:convert';

import 'package:get/get.dart';

import 'base_service.dart';

class PointService extends BaseService {
  Future<Response> getPointContent() async {
    Response response = await get('/api/point/mfp/content');

    return response;
  }

  Future<Response> sarchUserPoint({required int offset, int limit = 10}) async {
    Map<String, dynamic> body = {
      "offset": offset,
      "limit": limit,
    };

    Response response = await post(
      '/api/point/accumulate/search',
      jsonEncode(body),
    );

    return response;
  }

  Future<Response> sarchUserCoupon({required int offset, int limit = 10, String? type}) async {
    Map<String, dynamic> body = {
      "offset": offset,
      "limit": limit,
      if (type == 'REDEEM')
        "whereConditions": {
          "type": "REDEEM",
          "active": false,
          "activeDate": null,
        },
      if (type == 'USE_COUPON')
        "whereConditions": {
          "type": "USE_COUPON",
          "active": true,
          "activeDate": "not_null",
        },
      if (type == 'COUPON_HAS_EXPIRED')
        "whereConditions": {
          "type": "COUPON_HAS_EXPIRED",
          "active": false,
          "activeDate": "not_null",
        },
    };

    Response response = await post(
      '/api/point/coupon/search',
      jsonEncode(body),
    );

    return response;
  }

  Future<Response> sarchRanking({required int offset, int limit = 10}) async {
    Map<String, dynamic> body = {
      "offset": offset,
      "limit": limit,
    };

    Response response = await post(
      '/api/point/sort/accumulate/search',
      jsonEncode(body),
    );

    return response;
  }

  Future<Response> sarchPointCategoryId({required String categoryId}) async {
    Response response = await get('/api/point/category/product/$categoryId');

    return response;
  }

  Future<Response> sarchPointEventId({required String eventId}) async {
    Response response = await get('/api/point/event/$eventId');

    return response;
  }

  Future<Response> sarchPointProductId({required String productId}) async {
    Response response = await get('/api/point/product/$productId');

    return response;
  }

  Future<Response> redeemCoupon({required String title, required String detail, required int point, required String? productId}) async {
    Map<String, dynamic> body = {
      "title": title,
      "detail": detail,
      "point": point,
      "productId": productId,
      "type": "REDEEM",
    };

    Response response = await post(
      '/api/point/statement',
      jsonEncode(body),
    );

    return response;
  }

  Future<Response> receivePointCoupon({required String title, required String detail, required int point, required String? eventId}) async {
    Map<String, dynamic> body = {
      "title": title,
      "detail": detail,
      "point": point,
      "pointEventId": eventId,
      "type": "RECEIVE_POINT",
    };

    Response response = await post(
      '/api/point/statement',
      jsonEncode(body),
    );

    return response;
  }

  Future<Response> usedCoupon({required String couponId, required String productId}) async {
    Map<String, dynamic> body = {
      "couponId": couponId,
      "productId": productId,
    };

    Response response = await post(
      '/api/point/used/coupon',
      jsonEncode(body),
    );

    return response;
  }
}
