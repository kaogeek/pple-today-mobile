import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdDate;
  final String? categoryId;
  final String? title;
  final String? detail;
  final int? point;
  final int? maximumLimit;
  final List<String>? condition;
  final String? userId;
  final String? assetId;
  @JsonKey(name: 'coverPageURL')
  final String? coverPageUrl;
  @JsonKey(name: 's3CoverPageURL')
  final String? s3CoverPageUrl;
  final String? categoryName;
  final DateTime? expiringDate;
  final DateTime? activeDate;
  int? receiverCoupon;
  final int? couponExpire;

  Product({
    this.id,
    this.createdDate,
    this.categoryId,
    this.title,
    this.detail,
    this.point,
    this.maximumLimit,
    this.condition,
    this.userId,
    this.assetId,
    this.coverPageUrl,
    this.s3CoverPageUrl,
    this.categoryName,
    this.expiringDate,
    this.activeDate,
    this.receiverCoupon,
    this.couponExpire,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
