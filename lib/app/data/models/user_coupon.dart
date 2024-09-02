import 'package:json_annotation/json_annotation.dart';

import 'point_statement.dart';

part 'user_coupon.g.dart';

@JsonSerializable()
class UserCoupon {
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final String? userId;
  final String? productId;
  final DateTime? expireDate;
  final DateTime? activeDate;
  final PointStatement? pointStatement;
  final int? count;

  UserCoupon({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.userId,
    this.productId,
    this.expireDate,
    this.activeDate,
    this.pointStatement,
    this.count,
  });

  factory UserCoupon.fromJson(Map<String, dynamic> json) => _$UserCouponFromJson(json);
  Map<String, dynamic> toJson() => _$UserCouponToJson(this);
}
