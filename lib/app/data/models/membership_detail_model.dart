import 'package:json_annotation/json_annotation.dart';

part 'membership_detail_model.g.dart';

@JsonSerializable()
class MembershipDetailModel {
  final String? memberId;
  final String? memberType;
  final DateTime? membershipDate;
  final DateTime? expireDate;
  final int? totalDonation;

  MembershipDetailModel({
    this.memberId,
    this.memberType,
    this.membershipDate,
    this.expireDate,
    this.totalDonation,
  });

  factory MembershipDetailModel.fromJson(Map<String, dynamic> json) => _$MembershipDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipDetailModelToJson(this);
}
