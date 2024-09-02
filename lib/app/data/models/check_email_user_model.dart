import '../../component/convert_image_component.dart';

class CheckEmailUserModel {
  int? status;
  String? message;
  Data? data;
  List<String>? authUser;
  List<String>? pic;

  CheckEmailUserModel({
    this.status,
    this.message,
    this.data,
    this.authUser,
    this.pic,
  });

  CheckEmailUserModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? 4;
    message = json["message"];
    authUser = json["authUser"] == null ? null : List<String>.from(json["authUser"]);
    pic = json["pic"] == null ? null : List<String>.from(json["pic"]);
    data = json["data"] == null
        ? null
        : json["data"]["user"] == null
            ? Data.fromJson(json["data"])
            : Data.fromJson(json["data"]["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    if (authUser != null) {
      _data["authUser"] = authUser;
    }
    if (pic != null) {
      _data["pic"] = pic;
    }
    return _data;
  }

  void clear() {
    status = 4;
    message = '';
    data = null;
    authUser = null;
    pic = null;
  }
}

class Data {
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? displayName;
  String? uniqueId;
  bool? isAdmin;
  bool? isSubAdmin;
  String? birthdate;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  bool? banned;

  Data({
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.displayName,
    this.uniqueId,
    this.isAdmin,
    this.isSubAdmin,
    this.birthdate,
    this.imageUrl,
    this.coverUrl,
    this.coverPosition,
    this.banned,
  });

  Data.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    displayName = json["displayName"];
    uniqueId = json["uniqueId"];
    isAdmin = json["isAdmin"];
    isSubAdmin = json["isSubAdmin"];
    birthdate = json["birthdate"];
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
    coverPosition = json["coverPosition"].toDouble();
    banned = json["banned"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["username"] = username;
    _data["email"] = email;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["displayName"] = displayName;
    _data["uniqueId"] = uniqueId;
    _data["isAdmin"] = isAdmin;
    _data["isSubAdmin"] = isSubAdmin;
    _data["birthdate"] = birthdate;
    _data["imageURL"] = imageUrl;
    _data["coverURL"] = coverUrl;
    _data["coverPosition"] = coverPosition;
    _data["banned"] = banned;
    return _data;
  }
}
