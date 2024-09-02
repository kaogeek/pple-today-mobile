import 'package:json_annotation/json_annotation.dart';

import 'point_statement.dart';

part 'accumulate_point.g.dart';

@JsonSerializable()
class AccumulatePoint {
  @JsonKey(name: '_id')
  final String? id;
  final String? createdDate;
  final String? updatedDate;
  final String? userId;
  int? accumulatePoint;
  final int? usedPoint;
  final int? totalPoint;
  final List<PointStatement>? totalPointStatement;
  final List<PointStatement>? receivePointStatement;
  final List<PointStatement>? redeemPointStatement;

  AccumulatePoint({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.userId,
    this.accumulatePoint,
    this.usedPoint,
    this.totalPoint,
    this.totalPointStatement,
    this.receivePointStatement,
    this.redeemPointStatement,
  });

  factory AccumulatePoint.fromJson(Map<String, dynamic> json) => _$AccumulatePointFromJson(json);
  Map<String, dynamic> toJson() => _$AccumulatePointToJson(this);
}
