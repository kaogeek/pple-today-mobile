import 'package:json_annotation/json_annotation.dart';

import 'ranking_point.dart';

part 'sort_accumulate_point.g.dart';

@JsonSerializable()
class SortAccumulatePoint {
  final int? selfOrder;
  final RankingPoint? self;
  final List<RankingPoint>? rankingPoint;

  SortAccumulatePoint({
    this.selfOrder,
    this.self,
    this.rankingPoint,
  });

  factory SortAccumulatePoint.fromJson(Map<String, dynamic> json) => _$SortAccumulatePointFromJson(json);
  Map<String, dynamic> toJson() => _$SortAccumulatePointToJson(this);
}
