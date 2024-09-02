import '../../component/convert_image_component.dart';

class UserSupportVoteModel {
  int? status;
  String? message;
  Data? data;

  UserSupportVoteModel({this.status, this.message, this.data});

  UserSupportVoteModel.fromJson(Map<String, dynamic> json) {
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
  List<UserSupport>? userSupport;
  int? count;

  Data({this.userSupport, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["userSupport"] is List) {
      userSupport = json["userSupport"] == null ? null : (json["userSupport"] as List).map((e) => UserSupport.fromJson(e)).toList();
    }
    if (json["count"] is int) {
      count = json["count"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (userSupport != null) {
      _data["userSupport"] = userSupport?.map((e) => e.toJson()).toList();
    }
    _data["count"] = count ?? 0;
    return _data;
  }
}

class UserSupport {
  String? createdDate;
  User? user;

  UserSupport({this.createdDate, this.user});

  UserSupport.fromJson(Map<String, dynamic> json) {
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdDate"] = createdDate;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    return _data;
  }
}

class User {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? displayName;
  String? imageUrl;
  String? s3ImageUrl;

  User({this.id, this.username, this.firstName, this.lastName, this.displayName, this.imageUrl, this.s3ImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["username"] is String) {
      username = json["username"];
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
    if (json["imageURL"] is String) {
      imageUrl = ConvertImageComponent.getImages(imageURL: (json["imageURL"] as String));
    }
    if (json["s3ImageURL"] is String) {
      s3ImageUrl = json["s3ImageURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["username"] = username;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["displayName"] = displayName;
    _data["imageURL"] = imageUrl;
    _data["s3ImageURL"] = s3ImageUrl;
    return _data;
  }
}
