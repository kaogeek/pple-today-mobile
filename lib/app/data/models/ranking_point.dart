import 'package:json_annotation/json_annotation.dart';
import 'user.dart';

part 'ranking_point.g.dart';

@JsonSerializable()
class RankingPoint {
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdDate;
  final String? userId;
  @JsonKey(fromJson: toInt)
  final int? accumulatePoint;
  final User? user;

  RankingPoint({
    this.id,
    this.createdDate,
    this.userId,
    this.accumulatePoint,
    this.user,
  });

  factory RankingPoint.fromJson(Map<String, dynamic> json) => _$RankingPointFromJson(json);
  Map<String, dynamic> toJson() => _$RankingPointToJson(this);
}

int toInt(dynamic number) {
  if (number == null) return 0;

  if (number is String) return int.parse(number);

  if (number is double) return number.toInt();

  if (number is int) return number;

  return 0;
}
