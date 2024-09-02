import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'product_aggr.g.dart';

@JsonSerializable()
class ProductAggr {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final List<Product>? product;

  ProductAggr({
    this.id,
    this.title,
    this.product,
  });

  factory ProductAggr.fromJson(Map<String, dynamic> json) => _$ProductAggrFromJson(json);
  Map<String, dynamic> toJson() => _$ProductAggrToJson(this);
}
