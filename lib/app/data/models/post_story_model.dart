// ignore_for_file: unnecessary_question_mark

import '../../component/convert_image_component.dart';

class PostStoryModel {
  int? status;
  String? message;
  List<Data>? data;

  PostStoryModel({this.status, this.message, this.data});

  PostStoryModel.fromJson(Map<String, dynamic> json) {
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
  Post? post;

  Data({this.user, this.post});

  Data.fromJson(Map<String, dynamic> json) {
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    post = json["post"] == null ? null : Post.fromJson(json["post"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data["user"] = user?.toJson();
    }

    if (post != null) {
      data["post"] = post?.toJson();
    }
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
  dynamic? referencePost;
  dynamic? rootReferencePost;
  dynamic? visibility;
  dynamic? ranges;
  DateTime? updateDate;
  int? total;
  List<Gallery>? gallery;
  List<dynamic>? needs;
  List<dynamic>? fulfillment;
  List<dynamic>? caseFulfillment;
  List<dynamic>? caseNeeds;
  List<dynamic>? socialPosts;
  List<dynamic>? hashTags;
  String? coverImageSignUrl;
  dynamic? postAsPage;
  bool? isLike;
  Page? page;

  Post(
      {this.id,
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
      this.total,
      this.gallery,
      this.needs,
      this.fulfillment,
      this.caseFulfillment,
      this.caseNeeds,
      this.socialPosts,
      this.hashTags,
      this.coverImageSignUrl,
      this.postAsPage,
      this.isLike,
      this.page});

  Post.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"] == null || json["title"].toString().toUpperCase() == 'NULL'
        ? ''
        : json["title"].toString().trim();
    detail = json["detail"] == null || json["detail"].toString().toUpperCase() == 'NULL'
        ? ''
        : json["detail"].toString().trim();
    isDraft = json["isDraft"];
    hidden = json["hidden"];
    type = json["type"] ?? 'GENERAL';
    userTags = json["userTags"] ?? [];
    coverImage = json["coverImage"];
    pinned = json["pinned"];
    deleted = json["deleted"];
    ownerUser = json["ownerUser"];
    commentCount = json["commentCount"];
    repostCount = json["repostCount"];
    shareCount = json["shareCount"];
    likeCount = json["likeCount"] ?? 0;
    viewCount = json["viewCount"];
    createdDate = json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]);
    startDateTime = json["startDateTime"] == null ? null : DateTime.parse(json["startDateTime"]);
    story = json["story"] == null ? null : Story.fromJson(json["story"]);
    pageId = json["pageId"];
    referencePost = json["referencePost"];
    rootReferencePost = json["rootReferencePost"];
    visibility = json["visibility"];
    ranges = json["ranges"];
    updateDate = json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]);
    total = json["total"];
    gallery = json["gallery"] == null ? null : (json["gallery"] as List).map((e) => Gallery.fromJson(e)).toList();
    needs = json["needs"] ?? [];
    fulfillment = json["fulfillment"] ?? [];
    caseFulfillment = json["caseFulfillment"] ?? [];
    caseNeeds = json["caseNeeds"] ?? [];
    socialPosts = json["socialPosts"] ?? [];
    hashTags = json["hashTags"] ?? [];
    coverImageSignUrl = json["coverImageSignURL"];
    postAsPage = json["postAsPage"];
    isLike = json["isLike"] ?? false;
    page = json["page"] == null || json["page"].toString() == '{}' ? null : Page.fromJson(json["page"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["title"] = title;
    data["detail"] = detail;
    data["isDraft"] = isDraft;
    data["hidden"] = hidden;
    data["type"] = type;
    if (userTags != null) {
      data["userTags"] = userTags;
    }
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
    data["story"] = story;
    data["pageId"] = pageId;
    data["referencePost"] = referencePost;
    data["rootReferencePost"] = rootReferencePost;
    data["visibility"] = visibility;
    data["ranges"] = ranges;
    data["updateDate"] = updateDate;
    data["total"] = total;
    if (gallery != null) {
      data["gallery"] = gallery;
    }
    if (needs != null) {
      data["needs"] = needs;
    }
    if (fulfillment != null) {
      data["fulfillment"] = fulfillment;
    }
    if (caseFulfillment != null) {
      data["caseFulfillment"] = caseFulfillment;
    }
    if (caseNeeds != null) {
      data["caseNeeds"] = caseNeeds;
    }
    if (socialPosts != null) {
      data["socialPosts"] = socialPosts;
    }
    if (hashTags != null) {
      data["hashTags"] = hashTags;
    }
    data["coverImageSignURL"] = coverImageSignUrl;
    data["postAsPage"] = postAsPage;
    data["isLike"] = isLike;
    if (page != null) {
      data["page"] = page?.toJson();
    }
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

class Gallery {
  String? id;
  String? post;
  String? fileId;
  String? imageUrl;
  String? s3ImageUrl;
  int? ordering;

  Gallery({
    this.id,
    this.post,
    this.fileId,
    this.imageUrl,
    this.s3ImageUrl,
    this.ordering,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["_id"],
        post: json["post"],
        fileId: json["fileId"],
        imageUrl: (json["signURL"] ?? '').toString().startsWith('http')
            ? json["signURL"]
            : (json["coverSignURL"] ?? '').toString().startsWith('http')
                ? json["coverSignURL"]
                : (json["imageURL"] ?? '').toString().isNotEmpty
                    ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                    : '',
        s3ImageUrl: json["s3ImageURL"],
        ordering: json["ordering"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post": post,
        "fileId": fileId,
        "imageURL": imageUrl,
        "s3ImageURL": s3ImageUrl,
        "ordering": ordering,
      };
}

class Page {
  String? createdDate;
  String? id;
  String? name;
  String? pageUsername;
  String? imageUrl;
  String? coverUrl;
  String? ownerUser;
  bool? isOfficial;
  String? category;
  bool? banned;
  String? email;

  Page({
    this.createdDate,
    this.id,
    this.name,
    this.pageUsername,
    this.imageUrl,
    this.coverUrl,
    this.ownerUser,
    this.isOfficial,
    this.category,
    this.banned,
    this.email,
  });

  Page.fromJson(Map<String, dynamic> json) {
    createdDate = json["createdDate"];
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
    ownerUser = json["ownerUser"];
    isOfficial = json["isOfficial"];
    category = json["category"];
    banned = json["banned"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createdDate"] = createdDate;
    data["id"] = id;
    data["name"] = name;
    data["pageUsername"] = pageUsername;
    data["imageURL"] = imageUrl;
    data["coverURL"] = coverUrl;
    data["ownerUser"] = ownerUser;
    data["isOfficial"] = isOfficial;
    data["category"] = category;
    data["banned"] = banned;
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
