import '../../component/convert_image_component.dart';

class CheckStatusModel {
  int? status;
  String? message;
  Data? data;

  CheckStatusModel({this.status, this.message, this.data});

  CheckStatusModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  User? user;
  String? token;
  String? mode;

  Data({this.user, this.token, this.mode});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["token"] is String) {
      token = json["token"];
    }
    if (json["mode"] is String) {
      mode = json["mode"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["token"] = token;
    _data["mode"] = mode;
    return _data;
  }
}

class User {
  String? createdDate;
  String? createdTime;
  String? updateDate;
  String? updateByUsername;
  String? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? displayName;
  String? uniqueId;
  String? citizenId;
  int? gender;
  dynamic customGender;
  bool? isAdmin;
  bool? isSubAdmin;
  String? birthdate;
  String? imageUrl;
  String? s3ImageUrl;
  String? coverUrl;
  String? s3CoverUrl;
  int? coverPosition;
  bool? banned;
  dynamic mergeFb;
  dynamic mergeTw;
  dynamic mergeGg;
  dynamic mergeAp;
  dynamic isSyncPage;
  String? province;
  bool? subscribeEmail;
  bool? subscribeNoti;
  dynamic ua;
  String? uaVersion;
  dynamic tos;
  String? tosVersion;
  bool? membership;
  String? signUrl;
  int? followings;
  int? followers;
  List<String>? authUser;
  MfpUser? mfpUser;

  User(
      {this.createdDate,
      this.createdTime,
      this.updateDate,
      this.updateByUsername,
      this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.displayName,
      this.uniqueId,
      this.citizenId,
      this.gender,
      this.customGender,
      this.isAdmin,
      this.isSubAdmin,
      this.birthdate,
      this.imageUrl,
      this.s3ImageUrl,
      this.coverUrl,
      this.s3CoverUrl,
      this.coverPosition,
      this.banned,
      this.mergeFb,
      this.mergeTw,
      this.mergeGg,
      this.mergeAp,
      this.isSyncPage,
      this.province,
      this.subscribeEmail,
      this.subscribeNoti,
      this.ua,
      this.uaVersion,
      this.tos,
      this.tosVersion,
      this.membership,
      this.signUrl,
      this.followings,
      this.followers,
      this.authUser,
      this.mfpUser});

  User.fromJson(Map<String, dynamic> json) {
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["username"] is String) {
      username = json["username"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    if (json["displayName"] is String) {
      displayName = json["displayName"];
    }
    if (json["uniqueId"] is String) {
      uniqueId = json["uniqueId"];
    }
    if (json["citizenId"] is String) {
      citizenId = json["citizenId"];
    }
    if (json["gender"] is int) {
      gender = json["gender"];
    }
    customGender = json["customGender"];
    if (json["isAdmin"] is bool) {
      isAdmin = json["isAdmin"];
    }
    if (json["isSubAdmin"] is bool) {
      isSubAdmin = json["isSubAdmin"];
    }
    if (json["birthdate"] is String) {
      birthdate = json["birthdate"];
    }
    if (json["imageURL"] is String) {
      imageUrl = (json["imageURL"] ?? '').toString().isNotEmpty ? ConvertImageComponent.getImages(imageURL: json["imageURL"]) : '';
      // : 'https://stbbankstown.syd.catholic.edu.au/wp-content/uploads/sites/130/2019/05/Person-icon.jpg';
    }
    if (json["s3ImageURL"] is String) {
      s3ImageUrl = json["s3ImageURL"];
    }
    if (json["coverURL"] is String) {
      coverUrl = json["coverURL"];
    }
    if (json["s3CoverURL"] is String) {
      s3CoverUrl = json["s3CoverURL"];
    }
    if (json["coverPosition"] is int) {
      coverPosition = json["coverPosition"];
    }
    if (json["banned"] is bool) {
      banned = json["banned"];
    }
    mergeFb = json["mergeFB"];
    mergeTw = json["mergeTW"];
    mergeGg = json["mergeGG"];
    mergeAp = json["mergeAP"];
    isSyncPage = json["isSyncPage"];
    if (json["province"] is String) {
      province = json["province"];
    }
    if (json["subscribeEmail"] is bool) {
      subscribeEmail = json["subscribeEmail"];
    }
    if (json["subscribeNoti"] is bool) {
      subscribeNoti = json["subscribeNoti"];
    }
    ua = json["ua"];
    if (json["uaVersion"] is String) {
      uaVersion = json["uaVersion"];
    }
    tos = json["tos"];
    if (json["tosVersion"] is String) {
      tosVersion = json["tosVersion"];
    }
    if (json["membership"] is bool) {
      membership = json["membership"];
    }
    if (json["signURL"] is String) {
      signUrl = json["signURL"];
    }
    if (json["followings"] is int) {
      followings = json["followings"];
    }
    if (json["followers"] is int) {
      followers = json["followers"];
    }
    if (json["authUser"] is List) {
      authUser = json["authUser"] == null ? null : List<String>.from(json["authUser"]);
    }
    if (json["mfpUser"] is Map) {
      mfpUser = json["mfpUser"] == null ? null : MfpUser.fromJson(json["mfpUser"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["id"] = id;
    _data["username"] = username;
    _data["email"] = email;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["displayName"] = displayName;
    _data["uniqueId"] = uniqueId;
    _data["citizenId"] = citizenId;
    _data["gender"] = gender;
    _data["customGender"] = customGender;
    _data["isAdmin"] = isAdmin;
    _data["isSubAdmin"] = isSubAdmin;
    _data["birthdate"] = birthdate;
    _data["imageURL"] = imageUrl;
    _data["s3ImageURL"] = s3ImageUrl;
    _data["coverURL"] = coverUrl;
    _data["s3CoverURL"] = s3CoverUrl;
    _data["coverPosition"] = coverPosition;
    _data["banned"] = banned;
    _data["mergeFB"] = mergeFb;
    _data["mergeTW"] = mergeTw;
    _data["mergeGG"] = mergeGg;
    _data["mergeAP"] = mergeAp;
    _data["isSyncPage"] = isSyncPage;
    _data["province"] = province;
    _data["subscribeEmail"] = subscribeEmail;
    _data["subscribeNoti"] = subscribeNoti;
    _data["ua"] = ua;
    _data["uaVersion"] = uaVersion;
    _data["tos"] = tos;
    _data["tosVersion"] = tosVersion;
    _data["membership"] = membership;
    _data["signURL"] = signUrl;
    _data["followings"] = followings;
    _data["followers"] = followers;
    if (authUser != null) {
      _data["authUser"] = authUser;
    }
    if (mfpUser != null) {
      _data["mfpUser"] = mfpUser?.toJson();
    }
    return _data;
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

  MfpUser({this.id, this.expiredAt, this.firstName, this.lastName, this.email, this.state, this.identification, this.mobile});

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
