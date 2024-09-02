import 'package:json_annotation/json_annotation.dart';

part 'redeem_coupon.g.dart';

@JsonSerializable()
class RedeemCoupon {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? detail;
  final int? point;
  final String? productId;
  final String? pointEventId;
  final String? type;
  final String? userId;
  final DateTime? createdDate;
  final DateTime? createdTime;

  RedeemCoupon({
    this.id,
    this.title,
    this.detail,
    this.point,
    this.productId,
    this.pointEventId,
    this.type,
    this.userId,
    this.createdDate,
    this.createdTime,
  });

  factory RedeemCoupon.fromJson(Map<String, dynamic> json) => _$RedeemCouponFromJson(json);
  Map<String, dynamic> toJson() => _$RedeemCouponToJson(this);
}
