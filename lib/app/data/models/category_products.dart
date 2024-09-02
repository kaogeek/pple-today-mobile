import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'category_products.g.dart';

@JsonSerializable()
class CategoryProducts {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  @JsonKey(name: 'coverPageURL')
  final String? coverPageUrl;
  @JsonKey(name: 's3CoverPageURL')
  final String? s3CoverPageUrl;
  final List<Product>? product;

  CategoryProducts({
    this.id,
    this.title,
    this.coverPageUrl,
    this.s3CoverPageUrl,
    this.product,
  });

  factory CategoryProducts.fromJson(Map<String, dynamic> json) => _$CategoryProductsFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryProductsToJson(this);
}
