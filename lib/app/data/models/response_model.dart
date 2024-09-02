import 'package:json_annotation/json_annotation.dart';

import 'data_model.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  final int? status;
  final String? message;
  final DataModel? data;

  ResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
