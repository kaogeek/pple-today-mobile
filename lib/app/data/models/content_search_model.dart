// ignore_for_file: unnecessary_question_mark

import '../../component/convert_image_component.dart';

class ContentSearchModel {
  int? status;
  String? message;
  List<Data>? data;

  ContentSearchModel({
    this.status,
    this.message,
    this.data,
  });

  ContentSearchModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  Page? page;
  Post? post;

  Data({
    this.user,
    this.page,
    this.post,
  });

  Data.fromJson(Map<String, dynamic> json) {
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    page = json["page"] == null ? null : Page.fromJson(json["page"]);
    post = json["post"] == null ? null : Post.fromJson(json["post"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) data["user"] = user?.toJson();
    if (page != null) data["page"] = page?.toJson();
    if (post != null) data["post"] = post?.toJson();
    return data;
  }
}

class Post {
  String? id;
  String? title;
  String? detail;
  bool? isDraft;
  bool? hidden;
  String? type;
  List<dynamic>? userTags;
  String? coverImage;
  bool? pinned;
  bool? deleted;
  String? ownerUser;
  int? commentCount;
  int? repostCount;
  int? shareCount;
  int? likeCount;
  int? viewCount;
  DateTime? createdDate;
  DateTime? startDateTime;
  Story? story;
  String? pageId;
  String? referencePost;
  String? rootReferencePost;
  dynamic? visibility;
  dynamic? ranges;
  DateTime? updateDate;
  List<Gallery>? gallery;
  List<dynamic>? needs;
  List<dynamic>? fulfillment;
  List<dynamic>? caseFulfillment;
  List<dynamic>? caseNeeds;
  List<dynamic>? socialPosts;
  List<HashTags>? hashTags;
  String? coverImageSignUrl;
  bool? islike;

  Post({
    this.id,
    this.title,
    this.detail,
    this.isDraft,
    this.hidden,
    this.type,
    this.userTags,
    this.coverImage,
    this.pinned,
    this.deleted,
    this.ownerUser,
    this.commentCount,
    this.repostCount,
    this.shareCount,
    this.likeCount,
    this.viewCount,
    this.createdDate,
    this.startDateTime,
    this.story,
    this.pageId,
    this.referencePost,
    this.rootReferencePost,
    this.visibility,
    this.ranges,
    this.updateDate,
    this.gallery,
    this.needs,
    this.fulfillment,
    this.caseFulfillment,
    this.caseNeeds,
    this.socialPosts,
    this.hashTags,
    this.coverImageSignUrl,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    detail = json["detail"];
    isDraft = json["isDraft"];
    hidden = json["hidden"];
    type = json["type"];
    userTags = json["userTags"] ?? [];
    coverImage = json["coverImage"];
    pinned = json["pinned"];
    deleted = json["deleted"];
    ownerUser = json["ownerUser"];
    commentCount = json["commentCount"] ?? 0;
    repostCount = json["repostCount"] ?? 0;
    shareCount = json["shareCount"] ?? 0;
    likeCount = json["likeCount"] ?? 0;
    viewCount = json["viewCount"] ?? 0;
    createdDate = DateTime.parse(json["createdDate"]);
    startDateTime = DateTime.parse(json["startDateTime"]);
    story = json["story"] == null ? null : Story.fromJson(json["story"]);
    pageId = json["pageId"];
    referencePost = json["referencePost"];
    rootReferencePost = json["rootReferencePost"];
    visibility = json["visibility"];
    ranges = json["ranges"];
    updateDate = DateTime.parse(json["updateDate"]);
    gallery = json["gallery"] == null ? null : (json["gallery"] as List).map((e) => Gallery.fromJson(e)).toList();
    needs = json["needs"] ?? [];
    fulfillment = json["fulfillment"] ?? [];
    caseFulfillment = json["caseFulfillment"] ?? [];
    caseNeeds = json["caseNeeds"] ?? [];
    socialPosts = json["socialPosts"] ?? [];
    hashTags = json["hashTags"] == null ? null : (json["hashTags"] as List).map((e) => HashTags.fromJson(e)).toList();
    coverImageSignUrl = json["coverImageSignURL"];
    islike = json["isLike"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["title"] = title;
    data["detail"] = detail;
    data["isDraft"] = isDraft;
    data["hidden"] = hidden;
    data["type"] = type;
    if (userTags != null) data["userTags"] = userTags;
    data["coverImage"] = coverImage;
    data["pinned"] = pinned;
    data["deleted"] = deleted;
    data["ownerUser"] = ownerUser;
    data["commentCount"] = commentCount;
    data["repostCount"] = repostCount;
    data["shareCount"] = shareCount;
    data["likeCount"] = likeCount;
    data["viewCount"] = viewCount;
    data["createdDate"] = createdDate;
    data["startDateTime"] = startDateTime;
    if (story != null) data["story"] = story?.toJson();
    data["pageId"] = pageId;
    data["referencePost"] = referencePost;
    data["rootReferencePost"] = rootReferencePost;
    data["visibility"] = visibility;
    data["ranges"] = ranges;
    data["updateDate"] = updateDate;
    if (gallery != null) {
      data["gallery"] = gallery?.map((e) => e.toJson()).toList();
    }
    if (needs != null) data["needs"] = needs;
    if (fulfillment != null) data["fulfillment"] = fulfillment;
    if (caseFulfillment != null) data["caseFulfillment"] = caseFulfillment;
    if (caseNeeds != null) data["caseNeeds"] = caseNeeds;
    if (socialPosts != null) data["socialPosts"] = socialPosts;
    if (hashTags != null) {
      data["hashTags"] = hashTags?.map((e) => e.toJson()).toList();
    }
    data["coverImageSignURL"] = coverImageSignUrl;
    data["isLike"] = islike;
    return data;
  }
}

class HashTags {
  String? name;

  HashTags({this.name});

  HashTags.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    return data;
  }
}

class Gallery {
  String? id;
  String? post;
  String? fileId;
  String? imageUrl;
  int? ordering;

  Gallery({
    this.id,
    this.post,
    this.fileId,
    this.imageUrl,
    this.ordering,
  });

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    post = json["post"];
    fileId = json["fileId"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    ordering = json["ordering"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["post"] = post;
    data["fileId"] = fileId;
    data["imageURL"] = imageUrl;
    data["ordering"] = ordering;
    return data;
  }
}

class Story {
  Story();

  Story.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}

class Page {
  String? createdDate;
  String? updateDate;
  String? updateByUsername;
  String? id;
  String? name;
  String? pageUsername;
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
  String? mobileNo;
  String? address;
  String? email;

  Page({
    this.createdDate,
    this.updateDate,
    this.updateByUsername,
    this.id,
    this.name,
    this.pageUsername,
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
    this.mobileNo,
    this.address,
    this.email,
  });

  Page.fromJson(Map<String, dynamic> json) {
    createdDate = json["createdDate"];
    updateDate = json["updateDate"];
    updateByUsername = json["updateByUsername"];
    id = json["id"];
    name = json["name"];
    pageUsername = json["pageUsername"];
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
    mobileNo = json["mobileNo"];
    address = json["address"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createdDate"] = createdDate;
    data["updateDate"] = updateDate;
    data["updateByUsername"] = updateByUsername;
    data["id"] = id;
    data["name"] = name;
    data["pageUsername"] = pageUsername;
    data["imageURL"] = imageUrl;
    data["coverURL"] = coverUrl;
    data["coverPosition"] = coverPosition;
    data["ownerUser"] = ownerUser;
    data["isOfficial"] = isOfficial;
    data["category"] = category;
    data["banned"] = banned;
    data["lineId"] = lineId;
    data["facebookURL"] = facebookUrl;
    data["twitterURL"] = twitterUrl;
    data["websiteURL"] = websiteUrl;
    data["mobileNo"] = mobileNo;
    data["address"] = address;
    data["email"] = email;
    return data;
  }
}

class User {
  String? displayName;
  String? imageUrl;
  String? email;
  bool? isAdmin;
  String? uniqueId;

  User({
    this.displayName,
    this.imageUrl,
    this.email,
    this.isAdmin,
    this.uniqueId,
  });

  User.fromJson(Map<String, dynamic> json) {
    displayName = json["displayName"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    email = json["email"];
    isAdmin = json["isAdmin"];
    uniqueId = json["uniqueId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["displayName"] = displayName;
    data["imageURL"] = imageUrl;
    data["email"] = email;
    data["isAdmin"] = isAdmin;
    data["uniqueId"] = uniqueId;
    return data;
  }
}
