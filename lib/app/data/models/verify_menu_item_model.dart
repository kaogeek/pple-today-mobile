import 'package:json_annotation/json_annotation.dart';

part 'verify_menu_item_model.g.dart';

@JsonSerializable()
class VerifyMenuItemModel {
  @JsonKey(defaultValue: true)
  final bool? personnel;

  @JsonKey(defaultValue: true)
  final bool? about;

  @JsonKey(defaultValue: true)
  final bool? contact;

  @JsonKey(defaultValue: true)
  final bool? vote;

  @JsonKey(defaultValue: true)
  final bool? point;

  VerifyMenuItemModel({
    this.personnel,
    this.about,
    this.contact,
    this.vote,
    this.point,
  });

  factory VerifyMenuItemModel.fromJson(Map<String, dynamic> json) => _$VerifyMenuItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyMenuItemModelToJson(this);
}
