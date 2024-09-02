class HashTagPostModel {
  int? status;
  String? message;
  List<Data>? data;

  HashTagPostModel({this.status, this.message, this.data});

  HashTagPostModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  void clean() {
    status = null;
    message = null;
    data = null;
  }
}

class Data {
  User? user;
  Post? post;

  Data({this.user, this.post});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["post"] is Map) {
      post = json["post"] == null ? null : Post.fromJson(json["post"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (post != null) {
      _data["post"] = post?.toJson();
    }
    return _data;
  }
}

class Post {
  String? id;
  dynamic createdBy;
  DateTime? createdDate;
  DateTime? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? pageId;
  String? title;
  String? detail;
  dynamic story;
  bool? isDraft;
  bool? pinned;
  bool? deleted;
  bool? hidden;
  String? type;
  String? ownerUser;
  dynamic referencePost;
  dynamic rootReferencePost;
  dynamic referenceMode;
  int? commentCount;
  int? repostCount;
  int? shareCount;
  bool? isLike;
  int? likeCount;
  int? viewCount;
  String? coverImage;
  dynamic s3CoverImage;
  int? commentCountFb;
  int? shareCountFb;
  int? likeCountFb;
  int? summationScore;
  bool? newsFlag;
  EmergencyEvent? emergencyEvent;
  dynamic objectiveTag;
  String? emergencyEventTag;
  List<dynamic>? userTags;
  String? startDateTime;
  dynamic postAsPage;
  dynamic visibility;
  dynamic ranges;
  dynamic feedReachCount;
  dynamic linkReachCount;
  dynamic reachCount;
  dynamic banned;
  Page? page;
  List<Gallery>? gallery;
  List<dynamic>? needs;
  List<dynamic>? fulfillment;
  List<dynamic>? caseFulfillment;
  List<dynamic>? caseNeeds;
  List<SocialPosts>? socialPosts;
  List<HashTags>? hashTags;
  String? coverImageSignUrl;

  Post(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.pageId,
      this.title,
      this.detail,
      this.story,
      this.isDraft,
      this.pinned,
      this.deleted,
      this.hidden,
      this.type,
      this.ownerUser,
      this.referencePost,
      this.rootReferencePost,
      this.referenceMode,
      this.commentCount,
      this.repostCount,
      this.shareCount,
      this.isLike,
      this.likeCount,
      this.viewCount,
      this.coverImage,
      this.s3CoverImage,
      this.commentCountFb,
      this.shareCountFb,
      this.likeCountFb,
      this.summationScore,
      this.newsFlag,
      this.emergencyEvent,
      this.objectiveTag,
      this.emergencyEventTag,
      this.userTags,
      this.startDateTime,
      this.postAsPage,
      this.visibility,
      this.ranges,
      this.feedReachCount,
      this.linkReachCount,
      this.reachCount,
      this.banned,
      this.page,
      this.gallery,
      this.needs,
      this.fulfillment,
      this.caseFulfillment,
      this.caseNeeds,
      this.socialPosts,
      this.hashTags,
      this.coverImageSignUrl});

  Post.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    createdBy = json["createdBy"];
    if (json["createdDate"] is String) {
      createdDate = DateTime.parse(json["createdDate"]);
    }
    if (json["createdTime"] is String) {
      createdTime = DateTime.parse(json["createdTime"]);
    }
    createdByUsername = json["createdByUsername"];
    updateDate = json["updateDate"];
    updateByUsername = json["updateByUsername"];
    if (json["pageId"] is String) {
      pageId = json["pageId"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    story = json["story"];
    if (json["isDraft"] is bool) {
      isDraft = json["isDraft"];
    }
    if (json["pinned"] is bool) {
      pinned = json["pinned"];
    }
    if (json["deleted"] is bool) {
      deleted = json["deleted"];
    }
    if (json["hidden"] is bool) {
      hidden = json["hidden"];
    }
    if (json["type"] is String) {
      type = json["type"] ?? 'GENERAL';
    }
    if (json["ownerUser"] is String) {
      ownerUser = json["ownerUser"];
    }
    referencePost = json["referencePost"];
    rootReferencePost = json["rootReferencePost"];
    referenceMode = json["referenceMode"];
    if (json["commentCount"] is int) {
      commentCount = json["commentCount"];
    }
    if (json["repostCount"] is int) {
      repostCount = json["repostCount"];
    }
    if (json["shareCount"] is int) {
      shareCount = json["shareCount"];
    }
    if (json["isLike"] is bool) {
      isLike = json["isLike"] ?? false;
    }
    if (json["likeCount"] is int) {
      likeCount = json["likeCount"];
    }
    if (json["viewCount"] is int) {
      viewCount = json["viewCount"];
    }
    if (json["coverImage"] is String) {
      coverImage = json["coverImage"];
    }
    s3CoverImage = json["s3CoverImage"];
    if (json["commentCountFB"] is int) {
      commentCountFb = json["commentCountFB"];
    }
    if (json["shareCountFB"] is int) {
      shareCountFb = json["shareCountFB"];
    }
    if (json["likeCountFB"] is int) {
      likeCountFb = json["likeCountFB"];
    }
    if (json["summationScore"] is int) {
      summationScore = json["summationScore"];
    }
    if (json["newsFlag"] is bool) {
      newsFlag = json["newsFlag"];
    }
    if (json["emergencyEvent"] is Map) {
      emergencyEvent = json["emergencyEvent"] == null ? null : EmergencyEvent.fromJson(json["emergencyEvent"]);
    }
    objectiveTag = json["objectiveTag"];
    if (json["emergencyEventTag"] is String) {
      emergencyEventTag = json["emergencyEventTag"];
    }
    if (json["userTags"] is List) {
      userTags = json["userTags"] ?? [];
    }
    if (json["startDateTime"] is String) {
      startDateTime = json["startDateTime"];
    }
    postAsPage = json["postAsPage"];
    visibility = json["visibility"];
    ranges = json["ranges"];
    feedReachCount = json["feedReachCount"];
    linkReachCount = json["linkReachCount"];
    reachCount = json["reachCount"];
    banned = json["banned"];
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
    }
    if (json["gallery"] is List) {
      gallery = json["gallery"] == null ? null : (json["gallery"] as List).map((e) => Gallery.fromJson(e)).toList();
    }
    if (json["needs"] is List) {
      needs = json["needs"] ?? [];
    }
    if (json["fulfillment"] is List) {
      fulfillment = json["fulfillment"] ?? [];
    }
    if (json["caseFulfillment"] is List) {
      caseFulfillment = json["caseFulfillment"] ?? [];
    }
    if (json["caseNeeds"] is List) {
      caseNeeds = json["caseNeeds"] ?? [];
    }
    if (json["socialPosts"] is List) {
      socialPosts = json["socialPosts"] == null
          ? null
          : (json["socialPosts"] as List).map((e) => SocialPosts.fromJson(e)).toList();
    }
    if (json["hashTags"] is List) {
      hashTags = json["hashTags"] == null ? null : (json["hashTags"] as List).map((e) => HashTags.fromJson(e)).toList();
    }
    if (json["coverImageSignURL"] is String) {
      coverImageSignUrl = json["coverImageSignURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["pageId"] = pageId;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["story"] = story;
    _data["isDraft"] = isDraft;
    _data["pinned"] = pinned;
    _data["deleted"] = deleted;
    _data["hidden"] = hidden;
    _data["type"] = type;
    _data["ownerUser"] = ownerUser;
    _data["referencePost"] = referencePost;
    _data["rootReferencePost"] = rootReferencePost;
    _data["referenceMode"] = referenceMode;
    _data["commentCount"] = commentCount;
    _data["repostCount"] = repostCount;
    _data["shareCount"] = shareCount;
    _data["isLike"] = isLike;
    _data["likeCount"] = likeCount;
    _data["viewCount"] = viewCount;
    _data["coverImage"] = coverImage;
    _data["s3CoverImage"] = s3CoverImage;
    _data["commentCountFB"] = commentCountFb;
    _data["shareCountFB"] = shareCountFb;
    _data["likeCountFB"] = likeCountFb;
    _data["summationScore"] = summationScore;
    _data["newsFlag"] = newsFlag;
    if (emergencyEvent != null) {
      _data["emergencyEvent"] = emergencyEvent?.toJson();
    }
    _data["objectiveTag"] = objectiveTag;
    _data["emergencyEventTag"] = emergencyEventTag;
    if (userTags != null) {
      _data["userTags"] = userTags;
    }
    _data["startDateTime"] = startDateTime;
    _data["postAsPage"] = postAsPage;
    _data["visibility"] = visibility;
    _data["ranges"] = ranges;
    _data["feedReachCount"] = feedReachCount;
    _data["linkReachCount"] = linkReachCount;
    _data["reachCount"] = reachCount;
    _data["banned"] = banned;
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    if (gallery != null) {
      _data["gallery"] = gallery?.map((e) => e.toJson()).toList();
    }
    if (needs != null) {
      _data["needs"] = needs;
    }
    if (fulfillment != null) {
      _data["fulfillment"] = fulfillment;
    }
    if (caseFulfillment != null) {
      _data["caseFulfillment"] = caseFulfillment;
    }
    if (caseNeeds != null) {
      _data["caseNeeds"] = caseNeeds;
    }
    if (socialPosts != null) {
      _data["socialPosts"] = socialPosts?.map((e) => e.toJson()).toList();
    }
    if (hashTags != null) {
      _data["hashTags"] = hashTags?.map((e) => e.toJson()).toList();
    }
    _data["coverImageSignURL"] = coverImageSignUrl;
    return _data;
  }
}

class HashTags {
  String? name;

  HashTags({this.name});

  HashTags.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    return _data;
  }
}

class SocialPosts {
  dynamic createdBy;
  String? createdDate;
  String? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  dynamic id;
  String? socialType;
  String? socialId;
  dynamic link;
  dynamic photos;

  SocialPosts(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.id,
      this.socialType,
      this.socialId,
      this.link,
      this.photos});

  SocialPosts.fromJson(Map<String, dynamic> json) {
    createdBy = json["createdBy"];
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    createdByUsername = json["createdByUsername"];
    updateDate = json["updateDate"];
    updateByUsername = json["updateByUsername"];
    id = json["id"];
    if (json["socialType"] is String) {
      socialType = json["socialType"];
    }
    if (json["socialId"] is String) {
      socialId = json["socialId"];
    }
    link = json["link"];
    photos = json["photos"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["id"] = id;
    _data["socialType"] = socialType;
    _data["socialId"] = socialId;
    _data["link"] = link;
    _data["photos"] = photos;
    return _data;
  }
}

class Gallery {
  String? id;
  String? post;
  String? fileId;
  int? ordering;
  String? imageUrl;
  String? signUrl;

  Gallery({this.id, this.post, this.fileId, this.ordering, this.imageUrl, this.signUrl});

  Gallery.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["post"] is String) {
      post = json["post"];
    }
    if (json["fileId"] is String) {
      fileId = json["fileId"];
    }
    if (json["ordering"] is int) {
      ordering = json["ordering"];
    }
    if (json["signURL"] is String) {
      imageUrl = json["signURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["post"] = post;
    _data["fileId"] = fileId;
    _data["ordering"] = ordering;
    _data["imageURL"] = imageUrl;
    _data["signURL"] = signUrl;
    return _data;
  }
}

class Page {
  String? id;
  dynamic createdBy;
  String? createdDate;
  dynamic createdTime;
  dynamic createdByUsername;
  String? updateDate;
  String? updateByUsername;
  String? name;
  String? pageUsername;
  dynamic subTitle;
  dynamic backgroundStory;
  dynamic detail;
  String? imageUrl;
  String? coverUrl;
  int? coverPosition;
  String? ownerUser;
  bool? isOfficial;
  dynamic color;
  String? category;
  bool? banned;
  dynamic lineId;
  dynamic facebookUrl;
  dynamic twitterUrl;
  dynamic instagramUrl;
  dynamic websiteUrl;
  dynamic mobileNo;
  dynamic address;
  String? email;
  String? group;
  String? province;
  String? signUrl;
  String? coverSignUrl;

  Page(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
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
      this.lineId,
      this.facebookUrl,
      this.twitterUrl,
      this.instagramUrl,
      this.websiteUrl,
      this.mobileNo,
      this.address,
      this.email,
      this.group,
      this.province,
      this.signUrl,
      this.coverSignUrl});

  Page.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    createdBy = json["createdBy"];
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    createdTime = json["createdTime"];
    createdByUsername = json["createdByUsername"];
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["pageUsername"] is String) {
      pageUsername = json["pageUsername"];
    }
    subTitle = json["subTitle"];
    backgroundStory = json["backgroundStory"];
    detail = json["detail"];
    if (json["imageURL"] is String) {
      imageUrl = json["imageURL"];
    }
    if (json["coverURL"] is String) {
      coverUrl = json["coverURL"];
    }
    if (json["coverPosition"] is int) {
      coverPosition = json["coverPosition"];
    }
    if (json["ownerUser"] is String) {
      ownerUser = json["ownerUser"];
    }
    if (json["isOfficial"] is bool) {
      isOfficial = json["isOfficial"];
    }
    color = json["color"];
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["banned"] is bool) {
      banned = json["banned"];
    }
    lineId = json["lineId"];
    facebookUrl = json["facebookURL"];
    twitterUrl = json["twitterURL"];
    instagramUrl = json["instagramURL"];
    websiteUrl = json["websiteURL"];
    mobileNo = json["mobileNo"];
    address = json["address"];
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["group"] is String) {
      group = json["group"];
    }
    if (json["province"] is String) {
      province = json["province"];
    }
    if (json["signURL"] is String) {
      signUrl = json["signURL"];
    }
    if (json["coverSignURL"] is String) {
      coverSignUrl = json["coverSignURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
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
    _data["lineId"] = lineId;
    _data["facebookURL"] = facebookUrl;
    _data["twitterURL"] = twitterUrl;
    _data["instagramURL"] = instagramUrl;
    _data["websiteURL"] = websiteUrl;
    _data["mobileNo"] = mobileNo;
    _data["address"] = address;
    _data["email"] = email;
    _data["group"] = group;
    _data["province"] = province;
    _data["signURL"] = signUrl;
    _data["coverSignURL"] = coverSignUrl;
    return _data;
  }
}

class EmergencyEvent {
  String? id;
  dynamic createdBy;
  String? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? hashTag;
  String? s3CoverPageUrl;
  int? ordering;
  dynamic startDateTime;
  dynamic endDateTime;

  EmergencyEvent(
      {this.id,
      this.createdBy,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.hashTag,
      this.s3CoverPageUrl,
      this.ordering,
      this.startDateTime,
      this.endDateTime});

  EmergencyEvent.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    createdBy = json["createdBy"];
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    createdByUsername = json["createdByUsername"];
    updateDate = json["updateDate"];
    updateByUsername = json["updateByUsername"];
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["ordering"] is int) {
      ordering = json["ordering"];
    }
    startDateTime = json["startDateTime"];
    endDateTime = json["endDateTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdBy"] = createdBy;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["hashTag"] = hashTag;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["ordering"] = ordering;
    _data["startDateTime"] = startDateTime;
    _data["endDateTime"] = endDateTime;
    return _data;
  }
}

class User {
  String? displayName;
  String? imageUrl;
  String? email;
  bool? isAdmin;
  String? uniqueId;

  User({this.displayName, this.imageUrl, this.email, this.isAdmin, this.uniqueId});

  User.fromJson(Map<String, dynamic> json) {
    if (json["displayName"] is String) {
      displayName = json["displayName"];
    }
    if (json["imageURL"] is String) {
      imageUrl = json["imageURL"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["isAdmin"] is bool) {
      isAdmin = json["isAdmin"];
    }
    if (json["uniqueId"] is String) {
      uniqueId = json["uniqueId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["displayName"] = displayName;
    _data["imageURL"] = imageUrl;
    _data["email"] = email;
    _data["isAdmin"] = isAdmin;
    _data["uniqueId"] = uniqueId;
    return _data;
  }
}
