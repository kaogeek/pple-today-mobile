import 'package:json_annotation/json_annotation.dart';

part 'point_event_detail.g.dart';

@JsonSerializable()
class PointEventDetail {
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdDate;
  final DateTime? createdTime;
  final String? createdBy;
  final String? createdByUsername;
  final DateTime? updateDate;
  final String? updateByUsername;
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
  final int? receiver;

  PointEventDetail({
    this.id,
    this.createdDate,
    this.createdTime,
    this.createdBy,
    this.createdByUsername,
    this.updateDate,
    this.updateByUsername,
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
    this.receiver,
  });

  factory PointEventDetail.fromJson(Map<String, dynamic> json) => _$PointEventDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PointEventDetailToJson(this);
}
