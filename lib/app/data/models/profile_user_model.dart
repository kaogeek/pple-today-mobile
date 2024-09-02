// ignore_for_file: unnecessary_question_mark

import '../../component/convert_image_component.dart';

class ProfileModel {
  int? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data {
  String? id;
  String? username;
  String? uniqueId;
  String? email;
  String? displayName;
  String? firstName;
  String? lastName;
  DateTime? birthdate;
  dynamic? gender;
  dynamic? customGender;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  int? following;
  int? followers;
  bool? isFollow;
  bool? memberShip;
  List<String>? authUser;
  MFPUser? mfpUser;

  Data({
    this.id,
    this.username,
    this.uniqueId,
    this.email,
    this.displayName,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.gender,
    this.customGender,
    this.imageUrl,
    this.coverUrl,
    this.coverPosition,
    this.following,
    this.followers,
    this.isFollow,
    this.memberShip,
    this.authUser,
    this.mfpUser,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    uniqueId = json["uniqueId"];
    email = json["email"];
    displayName = json["displayName"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    birthdate = json["birthdate"] != null && json["birthdate"] != '' ? DateTime.parse(json["birthdate"]) : null;
    gender = json["gender"];
    customGender = json["customGender"];
    // imageUrl = json["imageURL"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["imageURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
            : '';
    coverUrl = (json["coverSignURL"] ?? '').toString().startsWith('http')
        ? json["coverSignURL"]
        : (json["coverURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["coverURL"])
            : '';
    coverPosition = (json["coverPosition"] ?? 0).toDouble();
    following = json["following"];
    followers = json["followers"];
    isFollow = json["isFollow"];
    memberShip = json["membership"];
    authUser = json["authUser"] == null ? null : List<String>.from(json["authUser"]);
    mfpUser = json["mfpUser"] == null ? null : MFPUser.fromJson(json["mfpUser"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["username"] = username;
    data["uniqueId"] = uniqueId;
    data["email"] = email;
    data["displayName"] = displayName;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["birthdate"] = birthdate;
    data["gender"] = gender;
    data["customGender"] = customGender;
    data["imageURL"] = imageUrl;
    data["coverURL"] = coverUrl;
    data["coverPosition"] = coverPosition;
    data["following"] = following;
    data["followers"] = followers;
    data["isFollow"] = isFollow;
    data["membership"] = memberShip;
    data["authUser"] = authUser;
    if (mfpUser != null) data["mfpUser"] = mfpUser?.toJson();
    return data;
  }
}

class MFPUser {
  String? id;
  DateTime? expiredAt;
  String? firstName;
  String? lastName;
  String? email;
  String? status;
  String? personCardId;
  String? phoneNumber;

  MFPUser({this.id, this.expiredAt, this.firstName, this.lastName, this.email, this.status, this.personCardId, this.phoneNumber});

  MFPUser.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    expiredAt = json["expiredAt"] != null && json["expiredAt"] != '' ? DateTime.parse(json["expiredAt"]) : null;
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    status = json["state"];
    personCardId = json["identification"];
    phoneNumber = json["mobile"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["expiredAt"] = expiredAt;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["state"] = status;
    data["identification"] = personCardId;
    data["mobile"] = phoneNumber;
    return data;
  }
}
