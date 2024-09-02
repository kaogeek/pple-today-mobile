// ignore_for_file: unnecessary_question_mark

import '../../component/convert_image_component.dart';

class PagePostSearchModel {
  int? status;
  String? message;
  Data? data;

  PagePostSearchModel({
    this.status,
    this.message,
    this.data,
  });

  PagePostSearchModel.fromJson(Map<String, dynamic> json) {
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
  List<Posts>? posts;

  Data({this.posts});

  Data.fromJson(Map<String, dynamic> json) {
    posts = json["posts"] == null ? null : (json["posts"] as List).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data["posts"] = posts?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Posts {
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
  OwnerUser? ownerUser;
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
  List<Comment>? comment;
  List<Gallery>? gallery;
  List<dynamic>? needs;
  List<dynamic>? fulfillment;
  List<dynamic>? caseFulfillment;
  List<dynamic>? caseNeeds;
  List<dynamic>? socialPosts;
  List<HashTags>? hashTags;
  bool? isRepost;
  bool? isLike;
  bool? likeAsPage;
  bool? isComment;

  Posts({
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
    this.comment,
    this.gallery,
    this.needs,
    this.fulfillment,
    this.caseFulfillment,
    this.caseNeeds,
    this.socialPosts,
    this.hashTags,
    this.isRepost,
    this.isLike,
    this.likeAsPage,
    this.isComment,
  });

  Posts.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"].toString().trim();
    detail = json["detail"].toString().trim();
    isDraft = json["isDraft"];
    hidden = json["hidden"];
    type = json["type"] ?? 'GENERAL';
    userTags = json["userTags"] ?? [];
    coverImage = json["coverImage"];
    pinned = json["pinned"];
    deleted = json["deleted"];
    ownerUser = json["ownerUser"] == null ? null : OwnerUser.fromJson(json["ownerUser"]);
    commentCount = json["commentCount"];
    repostCount = json["repostCount"];
    shareCount = json["shareCount"];
    likeCount = json["likeCount"];
    viewCount = json["viewCount"];
    createdDate = DateTime.parse(json["createdDate"]);
    startDateTime = DateTime.parse(json["startDateTime"]);
    story = json["story"] == null ? null : Story.fromJson(json["story"]);
    pageId = json["pageId"];
    referencePost = json["referencePost"];
    rootReferencePost = json["rootReferencePost"];
    visibility = json["visibility"];
    ranges = json["ranges"];
    updateDate = json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]);
    comment = json["comment"] == null ? null : (json["comment"] as List).map((e) => Comment.fromJson(e)).toList();
    gallery = json["gallery"] == null ? null : (json["gallery"] as List).map((e) => Gallery.fromJson(e)).toList();
    needs = json["needs"] ?? [];
    fulfillment = json["fulfillment"] ?? [];
    caseFulfillment = json["caseFulfillment"] ?? [];
    caseNeeds = json["caseNeeds"] ?? [];
    socialPosts = json["socialPosts"] ?? [];
    hashTags = json["hashTags"] == null ? null : (json["hashTags"] as List).map((e) => HashTags.fromJson(e)).toList();
    isRepost = json["isRepost"];
    isLike = json["isLike"];
    likeAsPage = json["likeAsPage"];
    isComment = json["isComment"];
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
    if (ownerUser != null) data["ownerUser"] = ownerUser?.toJson();
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
    if (comment != null) {
      data["comment"] = comment?.map((e) => e.toJson()).toList();
    }
    if (gallery != null) {
      data["gallery"] = gallery?.map((e) => e.toJson()).toList();
    }
    if (needs != null) data["needs"] = needs;
    if (fulfillment != null) data["fulfillment"] = fulfillment;
    if (caseFulfillment != null) {
      data["caseFulfillment"] = caseFulfillment;
    }
    if (caseNeeds != null) data["caseNeeds"] = caseNeeds;
    if (socialPosts != null) data["socialPosts"] = socialPosts;
    if (hashTags != null) {
      data["hashTags"] = hashTags?.map((e) => e.toJson()).toList();
    }
    data["isRepost"] = isRepost;
    data["isLike"] = isLike;
    data["likeAsPage"] = likeAsPage;
    data["isComment"] = isComment;
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
    s3ImageUrl = json["s3ImageURL"];
    ordering = json["ordering"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["post"] = post;
    data["fileId"] = fileId;
    data["imageURL"] = imageUrl;
    data["s3ImageURL"] = s3ImageUrl;
    data["ordering"] = ordering;
    return data;
  }
}

class Comment {
  String? id;
  String? comment;
  String? mediaUrl;
  String? post;
  String? user;
  int? likeCount;
  bool? deleted;
  String? commentAsPage;
  String? createdDate;

  Comment({
    this.id,
    this.comment,
    this.mediaUrl,
    this.post,
    this.user,
    this.likeCount,
    this.deleted,
    this.commentAsPage,
    this.createdDate,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    comment = json["comment"];
    mediaUrl = json["mediaURL"];
    post = json["post"];
    user = json["user"];
    likeCount = json["likeCount"];
    deleted = json["deleted"];
    commentAsPage = json["commentAsPage"];
    createdDate = json["createdDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["comment"] = comment;
    data["mediaURL"] = mediaUrl;
    data["post"] = post;
    data["user"] = user;
    data["likeCount"] = likeCount;
    data["deleted"] = deleted;
    data["commentAsPage"] = commentAsPage;
    data["createdDate"] = createdDate;
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

class OwnerUser {
  String? id;
  String? uniqueId;
  String? imageUrl;
  String? displayName;

  OwnerUser({
    this.id,
    this.uniqueId,
    this.imageUrl,
    this.displayName,
  });

  OwnerUser.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    uniqueId = json["uniqueId"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    displayName = json["displayName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["uniqueId"] = uniqueId;
    data["imageURL"] = imageUrl;
    data["displayName"] = displayName;
    return data;
  }
}
