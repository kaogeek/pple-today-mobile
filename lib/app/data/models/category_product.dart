import 'package:json_annotation/json_annotation.dart';

part 'category_product.g.dart';

@JsonSerializable()
class CategoryProduct {
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdDate;
  final String? title;
  final String? assetId;
  @JsonKey(name: 'coverPageURL')
  final String? coverPageUrl;
  @JsonKey(name: 's3CoverPageURL')
  final String? s3CoverPageUrl;

  CategoryProduct({
    this.id,
    this.createdDate,
    this.title,
    this.assetId,
    this.coverPageUrl,
    this.s3CoverPageUrl,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) => _$CategoryProductFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryProductToJson(this);
}
