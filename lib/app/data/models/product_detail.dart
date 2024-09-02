import 'package:json_annotation/json_annotation.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetail {
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdDate;
  final DateTime? createdTime;
  final String? createdBy;
  final String? createdByUsername;
  final DateTime? updateDate;
  final String? updateByUsername;
  final DateTime? activeDate;
  final String? categoryId;
  final String? categoryName;
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
  @JsonKey(name: 'username')
  final String? userName;
  final Uri? link;
  final int? receiverCoupon;
  final int? couponExpire;
  final bool? useCoupon;
  final bool? redeemCoupon;

  ProductDetail({
    this.id,
    this.createdDate,
    this.createdTime,
    this.createdBy,
    this.createdByUsername,
    this.updateDate,
    this.updateByUsername,
    this.activeDate,
    this.categoryId,
    this.categoryName,
    this.title,
    this.detail,
    this.point,
    this.maximumLimit,
    this.condition,
    this.userId,
    this.assetId,
    this.coverPageUrl,
    this.s3CoverPageUrl,
    this.userName,
    this.link,
    this.receiverCoupon,
    this.couponExpire,
    this.useCoupon,
    this.redeemCoupon,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => _$ProductDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}
