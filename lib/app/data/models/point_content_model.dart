import 'package:json_annotation/json_annotation.dart';

import 'data_point_content_model.dart';

part 'point_content_model.g.dart';

@JsonSerializable()
class PointContentModel {
  final int? status;
  final String? message;
  final DataPointContentModel? data;

  PointContentModel({this.status, this.message, this.data});

  factory PointContentModel.fromJson(Map<String, dynamic> json) => _$PointContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointContentModelToJson(this);
}
