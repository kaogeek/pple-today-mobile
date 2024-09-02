import 'package:json_annotation/json_annotation.dart';

part 'point_event.g.dart';

@JsonSerializable()
class PointEvent {
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdDate;
  final String? title;
  final String? detail;
  final int? point;
  final int? maximumLimit;
  final List<String>? condition;
  final String? assetId;
  @JsonKey(name: 'coverPageURL')
  final String? coverPageUrl;
  @JsonKey(name: 's3CoverPageURL')
  final String? s3CoverPageUrl;
  final String? link;
  final int? receiver;

  PointEvent({
    this.id,
    this.createdDate,
    this.title,
    this.detail,
    this.point,
    this.maximumLimit,
    this.condition,
    this.assetId,
    this.coverPageUrl,
    this.s3CoverPageUrl,
    this.link,
    this.receiver,
  });

  factory PointEvent.fromJson(Map<String, dynamic> json) => _$PointEventFromJson(json);
  Map<String, dynamic> toJson() => _$PointEventToJson(this);
}
