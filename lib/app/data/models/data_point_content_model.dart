import 'package:json_annotation/json_annotation.dart';

import 'accumulate_point.dart';
import 'category_product.dart';
import 'point_event.dart';
import 'product_aggr.dart';
import 'sort_accumulate_point.dart';

part 'data_point_content_model.g.dart';

@JsonSerializable()
class DataPointContentModel {
  final AccumulatePoint? accumulatePoint;
  final int? userCoupon;
  final SortAccumulatePoint? sortAccumulatePoint;
  final List<PointEvent>? pointEvent;
  final List<CategoryProduct>? categoryProduct;
  final List<ProductAggr>? productAggr;

  DataPointContentModel({
    this.accumulatePoint,
    this.userCoupon,
    this.sortAccumulatePoint,
    this.pointEvent,
    this.categoryProduct,
    this.productAggr,
  });

  factory DataPointContentModel.fromJson(Map<String, dynamic> json) => _$DataPointContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataPointContentModelToJson(this);
}
