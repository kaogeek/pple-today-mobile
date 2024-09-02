import '../../component/convert_image_component.dart';

class RecommendUserModel {
  int? status;
  String? message;
  List<Data>? data;

  RecommendUserModel({this.status, this.message, this.data});

  RecommendUserModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? username;
  String? email;
  String? uniqueId;
  String? imageUrl;
  String? displayName;
  String? type;
  String? name;
  String? pageUsername;
  bool? isOfficial;
  bool? isFollow;

  Data({
    this.id,
    this.username,
    this.email,
    this.uniqueId,
    this.imageUrl,
    this.displayName,
    this.type,
    this.name,
    this.pageUsername,
    this.isOfficial,
    this.isFollow,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    username = json["username"];
    email = json["email"];
    uniqueId = json["uniqueId"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    displayName = json["displayName"];
    type = json["type"];
    name = json["name"] ?? '';
    pageUsername = json["pageUsername"] == null || json["pageUsername"] == '' ? '' : '@' + json["pageUsername"];
    isOfficial = json["isOfficial"];
    isFollow = json["isFollowed"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["username"] = username;
    data["email"] = email;
    data["uniqueId"] = uniqueId;
    data["imageURL"] = imageUrl;
    data["displayName"] = displayName;
    data["type"] = type;
    data["name"] = name;
    data["pageUsername"] = pageUsername;
    data["isOfficial"] = isOfficial;
    data["isFollow"] = isFollow;
    return data;
  }
}
