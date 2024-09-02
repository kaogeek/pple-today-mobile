import 'package:json_annotation/json_annotation.dart';

import 'accumulate_point.dart';
import 'category_products.dart';
import 'point_event_detail.dart';
import 'product_detail.dart';
import 'redeem_coupon.dart';
import 'sort_accumulate_point.dart';
import 'user.dart';
import 'user_coupon.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel {
  // final List<UserCoupon>? userCoupon;
  final List<UserCoupon>? readyCoupon;
  final List<UserCoupon>? alreadyCoupon;
  final List<UserCoupon>? expireCoupon;
  final SortAccumulatePoint? sortAccumulatePoint;
  final AccumulatePoint? accumulatePoint;
  final User? user;
  final PointEventDetail? pointEventDetail;
  final ProductDetail? productDetail;
  final CategoryProducts? categoryProducts;
  final RedeemCoupon? redeemCoupon;
  final RedeemCoupon? receivePoint;

  DataModel({
    // this.userCoupon,
    this.readyCoupon,
    this.alreadyCoupon,
    this.expireCoupon,
    this.sortAccumulatePoint,
    this.accumulatePoint,
    this.user,
    this.pointEventDetail,
    this.productDetail,
    this.categoryProducts,
    this.redeemCoupon,
    this.receivePoint,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
