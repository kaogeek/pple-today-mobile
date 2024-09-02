import '../../component/convert_image_component.dart';

class SyncPageModel {
  int? status;
  String? message;
  Data? data;

  SyncPageModel({this.status, this.message, this.data});

  SyncPageModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
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

  void clear() {
    status = 0;
    message = '';
    data = null;
  }
}

class Data {
  String? createdDate;
  String? id;
  String? name;
  dynamic pageUsername;
  dynamic subTitle;
  dynamic backgroundStory;
  dynamic detail;
  String? imageUrl;
  String? coverUrl;
  dynamic coverPosition;
  String? ownerUser;
  bool? isOfficial;
  dynamic color;
  String? category;
  bool? banned;
  String? email;

  Data({
    this.createdDate,
    this.id,
    this.name,
    this.pageUsername,
    this.subTitle,
    this.backgroundStory,
    this.detail,
    this.imageUrl,
    this.coverUrl,
    this.coverPosition,
    this.ownerUser,
    this.isOfficial,
    this.color,
    this.category,
    this.banned,
    this.email,
  });

  Data.fromJson(Map<String, dynamic> json) {
    createdDate = json["createdDate"];
    id = json["id"];
    name = json["name"];
    pageUsername = json["pageUsername"];
    subTitle = json["subTitle"];
    backgroundStory = json["backgroundStory"];
    detail = json["detail"];
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
    coverPosition = json["coverPosition"];
    ownerUser = json["ownerUser"];
    isOfficial = json["isOfficial"];
    color = json["color"];
    category = json["category"];
    banned = json["banned"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdDate"] = createdDate;
    _data["id"] = id;
    _data["name"] = name;
    _data["pageUsername"] = pageUsername;
    _data["subTitle"] = subTitle;
    _data["backgroundStory"] = backgroundStory;
    _data["detail"] = detail;
    _data["imageURL"] = imageUrl;
    _data["coverURL"] = coverUrl;
    _data["coverPosition"] = coverPosition;
    _data["ownerUser"] = ownerUser;
    _data["isOfficial"] = isOfficial;
    _data["color"] = color;
    _data["category"] = category;
    _data["banned"] = banned;
    _data["email"] = email;
    return _data;
  }
}
