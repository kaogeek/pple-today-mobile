import '../../component/convert_image_component.dart';

class LoginWithEmailModel {
  int? status;
  String? code;
  String? message;
  Data? data;

  LoginWithEmailModel({this.status, this.code, this.message, this.data});

  LoginWithEmailModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? authUser;
  bool? membership;
  MfpUser? mfpUser;

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
    this.authUser,
    this.membership,
    this.mfpUser,
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
    authUser = json["authUser"] == null ? null : List<String>.from(json["authUser"]);
    membership = json["membership"] ?? false;
    mfpUser = json["mfpUser"] == null ? null : MfpUser.fromJson(json["mfpUser"]);
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
    data["authUser"] = authUser;
    data["membership"] = membership;
    data["mfpUser"] = mfpUser?.toJson();
    return data;
  }
}

class MfpUser {
  int? id;
  String? expiredAt;
  String? firstName;
  String? lastName;
  String? email;
  String? state;
  String? identification;
  String? mobile;

  MfpUser(
      {this.id,
      this.expiredAt,
      this.firstName,
      this.lastName,
      this.email,
      this.state,
      this.identification,
      this.mobile});

  MfpUser.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["expiredAt"] is String) {
      expiredAt = json["expiredAt"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["state"] is String) {
      state = json["state"];
    }
    if (json["identification"] is String) {
      identification = json["identification"];
    }
    if (json["mobile"] is String) {
      mobile = json["mobile"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["expiredAt"] = expiredAt;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["email"] = email;
    _data["state"] = state;
    _data["identification"] = identification;
    _data["mobile"] = mobile;
    return _data;
  }
}
