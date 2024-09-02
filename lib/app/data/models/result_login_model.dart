import '../../component/convert_image_component.dart';

class ResultLoginModel {
  int? status;
  String? code;
  String? message;
  Data? data;

  ResultLoginModel({this.status, this.code, this.message, this.data});

  ResultLoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    code = json["code"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["code"] = code;
    data["message"] = message;
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }

  void clear() {
    status = null;
    code = null;
    message = null;
    data = null;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    if (user != null) {
      data["user"] = user?.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? uniqueId;
  String? email;
  String? displayName;
  String? firstName;
  String? lastName;
  String? birthdate;
  String? gender;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  bool? banned;
  bool? isAdmin;
  bool? isSubAdmin;
  int? followings;
  int? followers;

  User({
    this.id,
    this.username,
    this.uniqueId,
    this.email,
    this.displayName,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.gender,
    this.imageUrl,
    this.coverUrl,
    this.coverPosition,
    this.banned,
    this.isAdmin,
    this.isSubAdmin,
    this.followings,
    this.followers,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    uniqueId = json["uniqueId"];
    email = json["email"];
    displayName = json["displayName"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    birthdate = json["birthdate"];
    gender = json["gender"].toString();
    imageUrl = (json["imageURL"] ?? '').toString().isNotEmpty
        ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
        : 'https://stbbankstown.syd.catholic.edu.au/wp-content/uploads/sites/130/2019/05/Person-icon.jpg';
    coverUrl = (json["coverSignURL"] ?? '').toString().startsWith('http')
        ? json["coverSignURL"]
        : (json["coverURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["coverURL"])
            : '';
    coverPosition = (json["coverPosition"] ?? 0).toDouble();
    banned = json["banned"];
    isAdmin = json["isAdmin"];
    isSubAdmin = json["isSubAdmin"];
    followings = json["followings"];
    followers = json["followers"];
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
    data["imageURL"] = imageUrl;
    data["coverURL"] = coverUrl;
    data["coverPosition"] = coverPosition;
    data["banned"] = banned;
    data["isAdmin"] = isAdmin;
    data["isSubAdmin"] = isSubAdmin;
    data["followings"] = followings;
    data["followers"] = followers;
    return data;
  }
}
