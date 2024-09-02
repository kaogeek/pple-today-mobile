import '../../component/convert_image_component.dart';

class UserAccessPageModel {
  int? status;
  String? message;
  List<Data>? data;

  UserAccessPageModel({this.status, this.message, this.data});

  UserAccessPageModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (this.data != null) {
      data["data"] = this.data?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Page? page;
  User? user;
  String? level;

  Data({this.page, this.user, this.level});

  Data.fromJson(Map<String, dynamic> json) {
    page = json["page"] == null ? null : Page.fromJson(json["page"]);
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    level = json["level"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (page != null) data["page"] = page?.toJson();
    if (user != null) data["user"] = user?.toJson();
    data["level"] = level;
    return data;
  }
}

class User {
  String? id;
  String? displayName;
  String? imageUrl;

  User({
    this.id,
    this.displayName,
    this.imageUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    displayName = json["displayName"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["displayName"] = displayName;
    data["imageURL"] = imageUrl;
    return data;
  }
}

class Page {
  String? id;
  String? name;
  String? pageUsername;
  String? imageUrl;
  bool? isOfficial;

  Page({
    this.id,
    this.name,
    this.pageUsername,
    this.imageUrl,
    this.isOfficial,
  });

  Page.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    pageUsername = json["pageUsername"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    isOfficial = json["isOfficial"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["pageUsername"] = pageUsername;
    data["imageURL"] = imageUrl;
    data["isOfficial"] = isOfficial;
    return data;
  }
}
