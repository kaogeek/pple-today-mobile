// ignore_for_file: unnecessary_question_mark

import '../../component/convert_image_component.dart';

class PostSearchModel {
  int? status;
  String? message;
  List<Data>? data;

  PostSearchModel({this.status, this.message, this.data});

  PostSearchModel.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
  String? startDateTime;
  Story? story;
  Objective? objective;
  String? objectiveTag;
  String? pageId;
  dynamic? referencePost;
  dynamic? rootReferencePost;
  dynamic? visibility;
  dynamic? ranges;
  String? updateDate;
  EmergencyEvent? emergencyEvent;
  String? emergencyEventTag;
  List<String>? postHashTag;
  String? s3CoverImage;
  List<Page>? page;
  List<dynamic>? comment;
  List<Gallery>? gallery;
  List<dynamic>? needs;
  List<dynamic>? fulfillment;
  List<dynamic>? caseFulfillment;
  List<dynamic>? caseNeeds;
  List<dynamic>? socialPosts;
  List<HashTags>? hashTags;
  bool? isRepost;
  late bool isLike;
  bool? likeAsPage;
  bool? isComment;

  Data({
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
    this.objective,
    this.objectiveTag,
    this.pageId,
    this.referencePost,
    this.rootReferencePost,
    this.visibility,
    this.ranges,
    this.updateDate,
    this.emergencyEvent,
    this.emergencyEventTag,
    this.postHashTag,
    this.s3CoverImage,
    this.page,
    this.comment,
    this.gallery,
    this.needs,
    this.fulfillment,
    this.caseFulfillment,
    this.caseNeeds,
    this.socialPosts,
    this.hashTags,
    this.isRepost,
    this.isLike = false,
    this.likeAsPage,
    this.isComment,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    ownerUser = json["ownerUser"] == null ? null : OwnerUser.fromJson(json["ownerUser"]);
    commentCount = json["commentCount"];
    repostCount = json["repostCount"];
    shareCount = json["shareCount"];
    likeCount = json["likeCount"];
    viewCount = json["viewCount"];
    createdDate = json["createdDate"];
    startDateTime = json["startDateTime"];
    story = json["story"] == null ? null : Story.fromJson(json["story"]);
    objective = json["objective"] == null ? null : Objective.fromJson(json["objective"]);
    objectiveTag = json["objectiveTag"];
    pageId = json["pageId"];
    referencePost = json["referencePost"];
    rootReferencePost = json["rootReferencePost"];
    visibility = json["visibility"];
    ranges = json["ranges"];
    updateDate = json["updateDate"];
    emergencyEvent = json["emergencyEvent"] == null ? null : EmergencyEvent.fromJson(json["emergencyEvent"]);
    emergencyEventTag = json["emergencyEventTag"];
    postHashTag = json["postHashTag"] == null ? null : List<String>.from(json["postHashTag"]);
    s3CoverImage = json["s3CoverImage"];
    page = json["page"] == null ? null : (json["page"] as List).map((e) => Page.fromJson(e)).toList();
    comment = json["comment"] ?? [];
    gallery = json["gallery"] == null ? null : (json["gallery"] as List).map((e) => Gallery.fromJson(e)).toList();
    needs = json["needs"] ?? [];
    fulfillment = json["fulfillment"] ?? [];
    caseFulfillment = json["caseFulfillment"] ?? [];
    caseNeeds = json["caseNeeds"] ?? [];
    socialPosts = json["socialPosts"] ?? [];
    hashTags = json["hashTags"] == null ? null : (json["hashTags"] as List).map((e) => HashTags.fromJson(e)).toList();
    isRepost = json["isRepost"];
    isLike = json["isLike"] ?? false;
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
    if (userTags != null) {
      data["userTags"] = userTags;
    }
    data["coverImage"] = coverImage;
    data["pinned"] = pinned;
    data["deleted"] = deleted;
    if (ownerUser != null) {
      data["ownerUser"] = ownerUser?.toJson();
    }
    data["commentCount"] = commentCount;
    data["repostCount"] = repostCount;
    data["shareCount"] = shareCount;
    data["likeCount"] = likeCount;
    data["viewCount"] = viewCount;
    data["createdDate"] = createdDate;
    data["startDateTime"] = startDateTime;
    if (story != null) {
      data["story"] = story?.toJson();
    }
    if (objective != null) {
      data["objective"] = objective?.toJson();
    }
    data["objectiveTag"] = objectiveTag;
    data["pageId"] = pageId;
    data["referencePost"] = referencePost;
    data["rootReferencePost"] = rootReferencePost;
    data["visibility"] = visibility;
    data["ranges"] = ranges;
    data["updateDate"] = updateDate;
    if (emergencyEvent != null) {
      data["emergencyEvent"] = emergencyEvent?.toJson();
    }
    data["emergencyEventTag"] = emergencyEventTag;
    if (postHashTag != null) {
      data["postHashTag"] = postHashTag;
    }
    data["s3CoverImage"] = s3CoverImage;
    if (page != null) {
      data["page"] = page?.map((e) => e.toJson()).toList();
    }
    if (comment != null) {
      data["comment"] = comment;
    }
    if (gallery != null) {
      data["gallery"] = gallery?.map((e) => e.toJson()).toList();
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

class Page {
  String? id;
  String? name;
  String? pageUsername;
  dynamic? subTitle;
  dynamic? backgroundStory;
  dynamic? detail;
  String? ownerUser;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  dynamic? color;
  String? category;
  bool? isOfficial;
  bool? banned;
  String? createdDate;
  String? updateDate;
  String? address;
  String? facebookUrl;
  dynamic? instagramUrl;
  String? lineId;
  String? mobileNo;
  String? twitterUrl;
  String? websiteUrl;
  String? email;
  String? updateByUsername;

  Page({
    this.id,
    this.name,
    this.pageUsername,
    this.subTitle,
    this.backgroundStory,
    this.detail,
    this.ownerUser,
    this.imageUrl,
    this.coverUrl,
    this.coverPosition,
    this.color,
    this.category,
    this.isOfficial,
    this.banned,
    this.createdDate,
    this.updateDate,
    this.address,
    this.facebookUrl,
    this.instagramUrl,
    this.lineId,
    this.mobileNo,
    this.twitterUrl,
    this.websiteUrl,
    this.email,
    this.updateByUsername,
  });

  Page.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    pageUsername = json["pageUsername"];
    subTitle = json["subTitle"];
    backgroundStory = json["backgroundStory"];
    detail = json["detail"];
    ownerUser = json["ownerUser"];
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
    color = json["color"];
    category = json["category"];
    isOfficial = json["isOfficial"];
    banned = json["banned"];
    createdDate = json["createdDate"];
    updateDate = json["updateDate"];
    address = json["address"];
    facebookUrl = json["facebookURL"];
    instagramUrl = json["instagramURL"];
    lineId = json["lineId"];
    mobileNo = json["mobileNo"];
    twitterUrl = json["twitterURL"];
    websiteUrl = json["websiteURL"];
    email = json["email"];
    updateByUsername = json["updateByUsername"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["pageUsername"] = pageUsername;
    data["subTitle"] = subTitle;
    data["backgroundStory"] = backgroundStory;
    data["detail"] = detail;
    data["ownerUser"] = ownerUser;
    data["imageURL"] = imageUrl;
    data["coverURL"] = coverUrl;
    data["coverPosition"] = coverPosition;
    data["color"] = color;
    data["category"] = category;
    data["isOfficial"] = isOfficial;
    data["banned"] = banned;
    data["createdDate"] = createdDate;
    data["updateDate"] = updateDate;
    data["address"] = address;
    data["facebookURL"] = facebookUrl;
    data["instagramURL"] = instagramUrl;
    data["lineId"] = lineId;
    data["mobileNo"] = mobileNo;
    data["twitterURL"] = twitterUrl;
    data["websiteURL"] = websiteUrl;
    data["email"] = email;
    data["updateByUsername"] = updateByUsername;
    return data;
  }
}

class EmergencyEvent {
  String? id;
  String? hashTag;
  String? s3CoverPageUrl;

  EmergencyEvent({this.id, this.hashTag, this.s3CoverPageUrl});

  EmergencyEvent.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    hashTag = json["hashTag"];
    s3CoverPageUrl = json["s3CoverPageURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["hashTag"] = hashTag;
    data["s3CoverPageURL"] = s3CoverPageUrl;
    return data;
  }
}

class Objective {
  String? id;
  String? hashTag;
  String? s3IconUrl;

  Objective({
    this.id,
    this.hashTag,
    this.s3IconUrl,
  });

  Objective.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    hashTag = json["hashTag"];
    s3IconUrl = json["s3IconURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["hashTag"] = hashTag;
    data["s3IconURL"] = s3IconUrl;
    return data;
  }
}

class Story {
  String? story;
  List<StoryAry>? storyAry;

  Story({this.story, this.storyAry});

  Story.fromJson(Map<String, dynamic> json) {
    story = json["story"];
    storyAry = json["storyAry"] == null ? null : (json["storyAry"] as List).map((e) => StoryAry.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["story"] = story;
    if (storyAry != null) {
      data["storyAry"] = storyAry?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class StoryAry {
  String? htmlType;
  String? text;
  Style? style;
  String? value;
  String? image64;

  StoryAry({
    this.htmlType,
    this.text,
    this.style,
    this.value,
    this.image64,
  });

  StoryAry.fromJson(Map<String, dynamic> json) {
    htmlType = json["htmlType"];
    text = json["text"];
    style = json["style"] == null ? null : Style.fromJson(json["style"]);
    value = json["value"];
    image64 = json["image64"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["htmlType"] = htmlType;
    data["text"] = text;
    if (style != null) {
      data["style"] = style?.toJson();
    }
    data["value"] = value;
    data["image64"] = image64;
    return data;
  }
}

class Style {
  String? textalign;
  String? fontsize;

  Style({this.textalign, this.fontsize});

  Style.fromJson(Map<String, dynamic> json) {
    textalign = json["textalign"];
    fontsize = json["fontsize"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["textalign"] = textalign;
    data["fontsize"] = fontsize;
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
