// ignore_for_file: unnecessary_question_mark

import '../../component/convert_image_component.dart';

class ProfileUidModel {
  int? status;
  String? message;
  Data? data;

  ProfileUidModel({this.status, this.message, this.data});

  ProfileUidModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
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
  String? birthdate;
  int? gender;
  dynamic? customGender;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  int? following;
  int? followers;
  bool? isFollow;

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
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    uniqueId = json["uniqueId"];
    email = json["email"];
    displayName = json["displayName"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    birthdate = json["birthdate"];
    gender = json["gender"];
    customGender = json["customGender"];
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
    return data;
  }
}
