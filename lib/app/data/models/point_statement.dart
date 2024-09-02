import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'point_statement.g.dart';

@JsonSerializable()
class PointStatement {
  @JsonKey(name: '_id')
  final String? id;
  final String? createdBy;
  final DateTime? createdDate;
  final DateTime? createdTime;
  final String? createdByUsername;
  final DateTime? updateDate;
  final DateTime? updateTime;
  final String? updateByUsername;
  final DateTime? expireDate;
  final DateTime? activeDate;
  final String? title;
  final String? detail;
  final int? point;
  final String? productId;
  final Product? product;
  final String? pointEventId;
  final String? type;
  final String? userId;
  final String? postId;
  final String? likeId;
  final String? commentId;
  final String? todayNewsId;

  PointStatement(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateTime,
      this.updateByUsername,
      this.expireDate,
      this.activeDate,
      this.title,
      this.detail,
      this.point,
      this.productId,
      this.product,
      this.pointEventId,
      this.type,
      this.userId,
      this.postId,
      this.likeId,
      this.commentId,
      this.todayNewsId});

  factory PointStatement.fromJson(Map<String, dynamic> json) => _$PointStatementFromJson(json);
  Map<String, dynamic> toJson() => _$PointStatementToJson(this);
}
