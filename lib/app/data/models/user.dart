import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? uniqueId;
  final String? identificationNumber;
  final String? email;
  final String? phone;
  @JsonKey(name: 'imageURL')
  final String? imageUrl;
  @JsonKey(name: 's3ImageURL')
  final String? s3ImageUrl;
  final String? providerName;
  @JsonKey(name: 'birthdate')
  final DateTime? birthDate;
  @JsonKey(name: 'membership')
  final bool? memberShip;
  

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.displayName,
    this.uniqueId,
    this.identificationNumber,
    this.email,
    this.phone,
    this.imageUrl,
    this.s3ImageUrl,
    this.providerName,
    this.birthDate,
    this.memberShip,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
