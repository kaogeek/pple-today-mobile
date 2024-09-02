import '../../component/convert_image_component.dart';

class PageModel {
  int? status;
  String? message;
  Data? data;

  PageModel({this.status, this.message, this.data});

  PageModel.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
  String? updateDate;
  String? updateByUsername;
  String? name;
  String? pageUsername;
  String? subTitle;
  String? backgroundStory;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  String? ownerUser;
  bool? isOfficial;
  String? category;
  bool? banned;
  String? lineId;
  String? facebookUrl;
  String? twitterUrl;
  String? websiteUrl;
  String? email;
  String? categoryName;
  int? followers;
  bool? isFollow;
  List<PageObjectives>? pageObjectives;
  List<dynamic>? needs;

  Data({
    this.id,
    this.createdDate,
    this.updateDate,
    this.updateByUsername,
    this.name,
    this.pageUsername,
    this.subTitle,
    this.backgroundStory,
    this.imageUrl,
    this.coverUrl,
    this.coverPosition,
    this.ownerUser,
    this.isOfficial,
    this.category,
    this.banned,
    this.lineId,
    this.facebookUrl,
    this.twitterUrl,
    this.websiteUrl,
    this.email,
    this.categoryName,
    this.followers,
    this.isFollow,
    this.pageObjectives,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdDate = json["createdDate"];
    updateDate = json["updateDate"];
    updateByUsername = json["updateByUsername"];
    name = json["name"] ?? '';
    pageUsername = json["pageUsername"] ?? '';
    subTitle = json["subTitle"] ?? '';
    backgroundStory = json["backgroundStory"];
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
    ownerUser = json["ownerUser"];
    isOfficial = json["isOfficial"];
    category = json["category"];
    banned = json["banned"];
    lineId = json["lineId"];
    facebookUrl = json["facebookURL"];
    twitterUrl = json["twitterURL"];
    websiteUrl = json["websiteURL"];
    email = json["email"];
    categoryName = json["categoryName"];
    followers = json["followers"];
    isFollow = json["isFollow"] ?? false;
    pageObjectives = json["pageObjectives"] == null
        ? null
        : (json["pageObjectives"] as List).map((e) => PageObjectives.fromJson(e)).toList();
    needs = json["needs"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["createdDate"] = createdDate;
    data["updateDate"] = updateDate;
    data["updateByUsername"] = updateByUsername;
    data["name"] = name;
    data["pageUsername"] = pageUsername;
    data["subTitle"] = subTitle;
    data["backgroundStory"] = backgroundStory;
    data["imageURL"] = imageUrl;
    data["coverURL"] = coverUrl;
    data["coverPosition"] = coverPosition;
    data["ownerUser"] = ownerUser;
    data["isOfficial"] = isOfficial;
    data["category"] = category;
    data["banned"] = banned;
    data["facebookURL"] = facebookUrl;
    data["email"] = email;
    data["categoryName"] = categoryName;
    data["followers"] = followers;
    data["isFollow"] = isFollow;
    if (pageObjectives != null) {
      data["pageObjectives"] = pageObjectives?.map((e) => e.toJson()).toList();
    }
    if (needs != null) {
      data["needs"] = needs;
    }
    return data;
  }
}

class PageObjectives {
  String? createdDate;
  String? id;
  String? pageId;
  String? title;
  String? iconUrl;
  String? hashTag;

  PageObjectives({
    this.createdDate,
    this.id,
    this.pageId,
    this.title,
    this.iconUrl,
    this.hashTag,
  });

  PageObjectives.fromJson(Map<String, dynamic> json) {
    createdDate = json["createdDate"];
    id = json["id"];
    pageId = json["pageId"];
    title = json["title"];
    iconUrl = (json["iconSignURL"] ?? '').toString().startsWith('http')
        ? json["iconSignURL"]
        : (json["iconURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["iconURL"])
            : '';
    hashTag = json["hashTag"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createdDate"] = createdDate;
    data["id"] = id;
    data["pageId"] = pageId;
    data["title"] = title;
    data["iconURL"] = iconUrl;
    data["hashTag"] = hashTag;
    return data;
  }
}
