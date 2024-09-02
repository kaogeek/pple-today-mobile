// ignore_for_file: unnecessary_this

import '../../component/convert_image_component.dart';

class ContentModel {
  int? status;
  String? message;
  Data? data;

  ContentModel({this.status, this.message, this.data});

  ContentModel.fromJson(Map<String, dynamic> json) {
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

  void clear() {
    status = null;
    message = null;
    data = null;
  }
}

class Data {
  EmergencyEvents? emergencyEvents;
  EmergencyPin? emergencyPin;
  PostSectionModel? postSectionModel;
  ObjectiveEvents? objectiveEvents;
  PageRoundRobin? pageRoundRobin;
  MajorTrend? majorTrend;
  KaokaiHashTag? kaokaiHashTag;
  KaokaiContent? kaokaiContent;
  KaokaiProvince? kaokaiProvince;
  List<SectionModels>? sectionModels;

  Data({
    this.emergencyEvents,
    this.emergencyPin,
    this.postSectionModel,
    this.objectiveEvents,
    this.pageRoundRobin,
    this.majorTrend,
    this.kaokaiHashTag,
    this.kaokaiContent,
    this.kaokaiProvince,
    this.sectionModels,
  });

  Data.fromJson(Map<String, dynamic> json) {
    emergencyEvents = json["emergencyEvents"] == null ? null : EmergencyEvents.fromJson(json["emergencyEvents"]);
    emergencyPin = json["emergencyPin"] == null ? null : EmergencyPin.fromJson(json["emergencyPin"]);
    postSectionModel = json["postSectionModel"] == null ? null : PostSectionModel.fromJson(json["postSectionModel"]);
    objectiveEvents = json["objectiveEvents"] == null ? null : ObjectiveEvents.fromJson(json["objectiveEvents"]);
    pageRoundRobin = json["pageRoundRobin"] == null ? null : PageRoundRobin.fromJson(json["pageRoundRobin"]);
    majorTrend = json["majorTrend"] == null ? null : MajorTrend.fromJson(json["majorTrend"]);
    kaokaiHashTag = json["kaokaiHashTag"] == null ? null : KaokaiHashTag.fromJson(json["kaokaiHashTag"]);
    kaokaiContent = json["kaokaiContent"] == null ? null : KaokaiContent.fromJson(json["kaokaiContent"]);
    kaokaiProvince = json["kaokaiProvince"] == null ? null : KaokaiProvince.fromJson(json["kaokaiProvince"]);
    sectionModels = json["sectionModels"] == null ? null : (json["sectionModels"] as List).map((e) => SectionModels.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emergencyEvents != null) {
      data["emergencyEvents"] = emergencyEvents?.toJson();
    }
    if (emergencyPin != null) data["emergencyPin"] = emergencyPin?.toJson();
    if (postSectionModel != null) {
      data["postSectionModel"] = postSectionModel?.toJson();
    }
    if (objectiveEvents != null) {
      data["objectiveEvents"] = objectiveEvents?.toJson();
    }
    if (pageRoundRobin != null) {
      data["pageRoundRobin"] = pageRoundRobin?.toJson();
    }
    if (majorTrend != null) {
      data["majorTrend"] = majorTrend?.toJson();
    }
    if (kaokaiHashTag != null) {
      data["kaokaiHashTag"] = kaokaiHashTag?.toJson();
    }
    if (kaokaiContent != null) {
      data["kaokaiContent"] = kaokaiContent?.toJson();
    }
    if (kaokaiProvince != null) {
      data["kaokaiProvince"] = kaokaiProvince?.toJson();
    }
    if (sectionModels != null) {
      data["sectionModels"] = sectionModels?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class KaokaiProvince {
  String? createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  String? title;
  String? subtitle;
  String? description;
  String? type;
  String? link;
  List<Contents>? contents;
  String? iconUrl;
  String? contentCount;
  String? dateTime;
  String? templateType;
  String? data;
  bool? isList;
  bool? isHighlight;
  int? position;
  String? majorTrendHashTags;
  String? mirrorTrends;
  String? isFollowing;
  String? owner;

  KaokaiProvince(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.title,
      this.subtitle,
      this.description,
      this.type,
      this.link,
      this.contents,
      this.iconUrl,
      this.contentCount,
      this.dateTime,
      this.templateType,
      this.data,
      this.isList,
      this.isHighlight,
      this.position,
      this.majorTrendHashTags,
      this.mirrorTrends,
      this.isFollowing,
      this.owner});

  KaokaiProvince.fromJson(Map<String, dynamic> json) {
    if (json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["createdByUsername"] is String) {
      createdByUsername = json["createdByUsername"];
    }
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["subtitle"] is String) {
      subtitle = json["subtitle"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
    if (json["contents"] is List) {
      contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents.fromJson(e)).toList();
    }
    if (json["iconUrl"] is String) {
      iconUrl = json["iconUrl"];
    }
    if (json["contentCount"] is String) {
      contentCount = json["contentCount"];
    }
    if (json["dateTime"] is String) {
      dateTime = json["dateTime"];
    }
    if (json["templateType"] is String) {
      templateType = json["templateType"];
    }
    if (json["data"] is String) {
      data = json["data"];
    }
    if (json["isList"] is bool) {
      isList = json["isList"];
    }
    if (json["isHighlight"] is bool) {
      isHighlight = json["isHighlight"];
    }
    if (json["position"] is int) {
      position = json["position"];
    }
    if (json["majorTrendHashTags"] is String) {
      majorTrendHashTags = json["majorTrendHashTags"];
    }
    if (json["mirrorTrends"] is String) {
      mirrorTrends = json["mirrorTrends"];
    }
    if (json["isFollowing"] is String) {
      isFollowing = json["isFollowing"];
    }
    if (json["owner"] is String) {
      owner = json["owner"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["title"] = title;
    _data["subtitle"] = subtitle;
    _data["description"] = description;
    _data["type"] = type;
    _data["link"] = link;
    if (contents != null) {
      _data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    _data["iconUrl"] = iconUrl;
    _data["contentCount"] = contentCount;
    _data["dateTime"] = dateTime;
    _data["templateType"] = templateType;
    _data["data"] = data;
    _data["isList"] = isList;
    _data["isHighlight"] = isHighlight;
    _data["position"] = position;
    _data["majorTrendHashTags"] = majorTrendHashTags;
    _data["mirrorTrends"] = mirrorTrends;
    _data["isFollowing"] = isFollowing;
    _data["owner"] = owner;
    return _data;
  }
}

class KaokaiContent {
  String? createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  String? title;
  String? subtitle;
  String? description;
  String? type;
  String? link;
  List<Contents>? contents;
  String? iconUrl;
  String? contentCount;
  String? dateTime;
  String? templateType;
  String? data;
  bool? isList;
  bool? isHighlight;
  int? position;
  String? majorTrendHashTags;
  String? mirrorTrends;
  String? isFollowing;
  String? owner;

  KaokaiContent(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.title,
      this.subtitle,
      this.description,
      this.type,
      this.link,
      this.contents,
      this.iconUrl,
      this.contentCount,
      this.dateTime,
      this.templateType,
      this.data,
      this.isList,
      this.isHighlight,
      this.position,
      this.majorTrendHashTags,
      this.mirrorTrends,
      this.isFollowing,
      this.owner});

  KaokaiContent.fromJson(Map<String, dynamic> json) {
    if (json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["createdByUsername"] is String) {
      createdByUsername = json["createdByUsername"];
    }
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["subtitle"] is String) {
      subtitle = json["subtitle"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
    if (json["contents"] is List) {
      contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents.fromJson(e)).toList();
    }
    if (json["iconUrl"] is String) {
      iconUrl = json["iconUrl"];
    }
    if (json["contentCount"] is String) {
      contentCount = json["contentCount"];
    }
    if (json["dateTime"] is String) {
      dateTime = json["dateTime"];
    }
    if (json["templateType"] is String) {
      templateType = json["templateType"];
    }
    if (json["data"] is String) {
      data = json["data"];
    }
    if (json["isList"] is bool) {
      isList = json["isList"];
    }
    if (json["isHighlight"] is bool) {
      isHighlight = json["isHighlight"];
    }
    if (json["position"] is int) {
      position = json["position"];
    }
    if (json["majorTrendHashTags"] is String) {
      majorTrendHashTags = json["majorTrendHashTags"];
    }
    if (json["mirrorTrends"] is String) {
      mirrorTrends = json["mirrorTrends"];
    }
    if (json["isFollowing"] is String) {
      isFollowing = json["isFollowing"];
    }
    if (json["owner"] is String) {
      owner = json["owner"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["title"] = title;
    _data["subtitle"] = subtitle;
    _data["description"] = description;
    _data["type"] = type;
    _data["link"] = link;
    if (contents != null) {
      _data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    _data["iconUrl"] = iconUrl;
    _data["contentCount"] = contentCount;
    _data["dateTime"] = dateTime;
    _data["templateType"] = templateType;
    _data["data"] = data;
    _data["isList"] = isList;
    _data["isHighlight"] = isHighlight;
    _data["position"] = position;
    _data["majorTrendHashTags"] = majorTrendHashTags;
    _data["mirrorTrends"] = mirrorTrends;
    _data["isFollowing"] = isFollowing;
    _data["owner"] = owner;
    return _data;
  }
}

class KaokaiHashTag {
  String? createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  String? title;
  String? subtitle;
  String? description;
  String? type;
  String? link;
  List<Contents>? contents;
  String? iconUrl;
  String? contentCount;
  String? dateTime;
  String? templateType;
  String? data;
  bool? isList;
  bool? isHighlight;
  int? position;
  String? majorTrendHashTags;
  String? mirrorTrends;
  String? isFollowing;
  String? owner;

  KaokaiHashTag(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.title,
      this.subtitle,
      this.description,
      this.type,
      this.link,
      this.contents,
      this.iconUrl,
      this.contentCount,
      this.dateTime,
      this.templateType,
      this.data,
      this.isList,
      this.isHighlight,
      this.position,
      this.majorTrendHashTags,
      this.mirrorTrends,
      this.isFollowing,
      this.owner});

  KaokaiHashTag.fromJson(Map<String, dynamic> json) {
    if (json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["createdByUsername"] is String) {
      createdByUsername = json["createdByUsername"];
    }
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["subtitle"] is String) {
      subtitle = json["subtitle"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
    if (json["contents"] is List) {
      contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents.fromJson(e)).toList();
    }
    if (json["iconUrl"] is String) {
      iconUrl = json["iconUrl"];
    }
    if (json["contentCount"] is String) {
      contentCount = json["contentCount"];
    }
    if (json["dateTime"] is String) {
      dateTime = json["dateTime"];
    }
    if (json["templateType"] is String) {
      templateType = json["templateType"];
    }
    if (json["data"] is String) {
      data = json["data"];
    }
    if (json["isList"] is bool) {
      isList = json["isList"];
    }
    if (json["isHighlight"] is bool) {
      isHighlight = json["isHighlight"];
    }
    if (json["position"] is int) {
      position = json["position"];
    }
    if (json["majorTrendHashTags"] is String) {
      majorTrendHashTags = json["majorTrendHashTags"];
    }
    if (json["mirrorTrends"] is String) {
      mirrorTrends = json["mirrorTrends"];
    }
    if (json["isFollowing"] is String) {
      isFollowing = json["isFollowing"];
    }
    if (json["owner"] is String) {
      owner = json["owner"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["title"] = title;
    _data["subtitle"] = subtitle;
    _data["description"] = description;
    _data["type"] = type;
    _data["link"] = link;
    if (contents != null) {
      _data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    _data["iconUrl"] = iconUrl;
    _data["contentCount"] = contentCount;
    _data["dateTime"] = dateTime;
    _data["templateType"] = templateType;
    _data["data"] = data;
    _data["isList"] = isList;
    _data["isHighlight"] = isHighlight;
    _data["position"] = position;
    _data["majorTrendHashTags"] = majorTrendHashTags;
    _data["mirrorTrends"] = mirrorTrends;
    _data["isFollowing"] = isFollowing;
    _data["owner"] = owner;
    return _data;
  }
}

class MajorTrend {
  String? createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  String? title;
  String? subtitle;
  String? description;
  String? type;
  String? link;
  List<Contents>? contents;
  String? iconUrl;
  String? contentCount;
  String? dateTime;
  String? templateType;
  String? data;
  bool? isList;
  bool? isHighlight;
  int? position;
  String? majorTrendHashTags;
  String? mirrorTrends;
  String? isFollowing;
  String? owner;

  MajorTrend(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.title,
      this.subtitle,
      this.description,
      this.type,
      this.link,
      this.contents,
      this.iconUrl,
      this.contentCount,
      this.dateTime,
      this.templateType,
      this.data,
      this.isList,
      this.isHighlight,
      this.position,
      this.majorTrendHashTags,
      this.mirrorTrends,
      this.isFollowing,
      this.owner});

  MajorTrend.fromJson(Map<String, dynamic> json) {
    if (json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["createdByUsername"] is String) {
      createdByUsername = json["createdByUsername"];
    }
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["subtitle"] is String) {
      subtitle = json["subtitle"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
    if (json["contents"] is List) {
      contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents.fromJson(e)).toList();
    }
    if (json["iconUrl"] is String) {
      iconUrl = json["iconUrl"];
    }
    if (json["contentCount"] is String) {
      contentCount = json["contentCount"];
    }
    if (json["dateTime"] is String) {
      dateTime = json["dateTime"];
    }
    if (json["templateType"] is String) {
      templateType = json["templateType"];
    }
    if (json["data"] is String) {
      data = json["data"];
    }
    if (json["isList"] is bool) {
      isList = json["isList"];
    }
    if (json["isHighlight"] is bool) {
      isHighlight = json["isHighlight"];
    }
    if (json["position"] is int) {
      position = json["position"];
    }
    if (json["majorTrendHashTags"] is String) {
      majorTrendHashTags = json["majorTrendHashTags"];
    }
    if (json["mirrorTrends"] is String) {
      mirrorTrends = json["mirrorTrends"];
    }
    if (json["isFollowing"] is String) {
      isFollowing = json["isFollowing"];
    }
    if (json["owner"] is String) {
      owner = json["owner"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["title"] = title;
    _data["subtitle"] = subtitle;
    _data["description"] = description;
    _data["type"] = type;
    _data["link"] = link;
    if (contents != null) {
      _data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    _data["iconUrl"] = iconUrl;
    _data["contentCount"] = contentCount;
    _data["dateTime"] = dateTime;
    _data["templateType"] = templateType;
    _data["data"] = data;
    _data["isList"] = isList;
    _data["isHighlight"] = isHighlight;
    _data["position"] = position;
    _data["majorTrendHashTags"] = majorTrendHashTags;
    _data["mirrorTrends"] = mirrorTrends;
    _data["isFollowing"] = isFollowing;
    _data["owner"] = owner;
    return _data;
  }
}

class SectionModels {
  String? title;
  String? subtitle;
  String? description;
  String? type;
  List<Contents4>? contents;
  String? iconUrl;
  String? dateTime;
  bool? isList;
  bool? isHighlight;

  SectionModels({this.title, this.subtitle, this.description, this.type, this.contents, this.iconUrl, this.dateTime, this.isList, this.isHighlight});

  SectionModels.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    subtitle = json["subtitle"];
    description = json["description"];
    type = json["type"];
    contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents4.fromJson(e)).toList();
    iconUrl = json["iconUrl"];
    dateTime = json["dateTime"];
    isList = json["isList"];
    isHighlight = json["isHighlight"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["subtitle"] = subtitle;
    data["description"] = description;
    data["type"] = type;
    if (contents != null) {
      data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    data["iconUrl"] = iconUrl;
    data["dateTime"] = dateTime;
    data["isList"] = isList;
    data["isHighlight"] = isHighlight;
    return data;
  }
}

class Contents4 {
  String? title;
  String? iconUrl;
  Owner2? owner;
  bool? isLike;
  bool? isRepost;
  bool? isComment;
  bool? isShare;
  Data4? data;

  Contents4({this.title, this.iconUrl, this.owner, this.isLike, this.isRepost, this.isComment, this.isShare, this.data});

  Contents4.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    iconUrl = json["iconUrl"];
    owner = json["owner"] == null ? null : Owner2.fromJson(json["owner"]);
    isLike = json["isLike"];
    isRepost = json["isRepost"];
    isComment = json["isComment"];
    isShare = json["isShare"];
    data = json["data"] == null ? null : Data4.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["iconUrl"] = iconUrl;
    if (owner != null) data["owner"] = owner?.toJson();
    data["isLike"] = isLike;
    data["isRepost"] = isRepost;
    data["isComment"] = isComment;
    data["isShare"] = isShare;
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data4 {
  String? objectiveId;

  Data4({this.objectiveId});

  Data4.fromJson(Map<String, dynamic> json) {
    objectiveId = json["objectiveId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["objectiveId"] = objectiveId;
    return data;
  }
}

class Owner2 {
  String? id;
  String? name;
  String? imageUrl;
  bool? isOfficial;
  String? uniqueId;
  String? type;

  Owner2({
    this.id,
    this.name,
    this.imageUrl,
    this.isOfficial,
    this.uniqueId,
    this.type,
  });

  Owner2.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    isOfficial = json["isOfficial"];
    uniqueId = json["uniqueId"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["imageURL"] = imageUrl;
    data["isOfficial"] = isOfficial;
    data["uniqueId"] = uniqueId;
    data["type"] = type;
    return data;
  }
}

class ObjectiveEvents {
  String? title;
  String? subtitle;
  String? description;
  String? type;
  List<Contents3>? contents;
  String? iconUrl;
  String? dateTime;
  bool? isList;
  bool? isHighlight;

  ObjectiveEvents({this.title, this.subtitle, this.description, this.type, this.contents, this.iconUrl, this.dateTime, this.isList, this.isHighlight});

  ObjectiveEvents.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    subtitle = json["subtitle"];
    description = json["description"];
    type = json["type"];
    contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents3.fromJson(e)).toList();
    iconUrl = json["iconUrl"];
    dateTime = json["dateTime"];
    isList = json["isList"];
    isHighlight = json["isHighlight"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["subtitle"] = subtitle;
    data["description"] = description;
    data["type"] = type;
    if (contents != null) {
      data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    data["iconUrl"] = iconUrl;
    data["dateTime"] = dateTime;
    data["isList"] = isList;
    data["isHighlight"] = isHighlight;
    return data;
  }
}

class Contents3 {
  String? title;
  String? iconUrl;
  String? iconSignUrl;
  List<Post1>? post;
  Owner1? owner;
  Data3? data;

  Contents3({this.title, this.iconUrl, this.iconSignUrl, this.post, this.owner, this.data});

  Contents3.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    iconUrl = json["iconUrl"];
    iconSignUrl = json["iconSignUrl"];
    post = json["post"] == null ? null : (json["post"] as List).map((e) => Post1.fromJson(e)).toList();
    owner = json["owner"] == null ? null : Owner1.fromJson(json["owner"]);
    data = json["data"] == null ? null : Data3.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["iconUrl"] = iconUrl;
    data["iconSignUrl"] = iconSignUrl;
    if (post != null) data["post"] = post?.map((e) => e.toJson()).toList();
    if (owner != null) data["owner"] = owner?.toJson();
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data3 {
  String? objectiveId;

  Data3({this.objectiveId});

  Data3.fromJson(Map<String, dynamic> json) {
    objectiveId = json["objectiveId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["objectiveId"] = objectiveId;
    return data;
  }
}

class Owner1 {
  String? id;
  String? name;
  String? imageUrl;
  bool? isOfficial;
  String? uniqueId;
  String? type;

  Owner1({
    this.id,
    this.name,
    this.imageUrl,
    this.isOfficial,
    this.uniqueId,
    this.type,
  });

  Owner1.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    isOfficial = json["isOfficial"];
    uniqueId = json["uniqueId"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["imageURL"] = imageUrl;
    data["isOfficial"] = isOfficial;
    data["uniqueId"] = uniqueId;
    data["type"] = type;
    return data;
  }
}

class Post1 {
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
  String? createdDate;
  String? startDateTime;
  List<String>? postsHashTags;
  String? pageId;
  dynamic referencePost;
  dynamic rootReferencePost;
  dynamic visibility;
  dynamic ranges;
  String? updateDate;
  dynamic emergencyEvent;
  dynamic emergencyEventTag;
  String? objective;
  String? objectiveTag;
  String? s3CoverImage;
  Page1? page;
  String? objectiveId;
  List<Objectives>? objectives;
  List<Gallery1>? gallery;

  Post1(
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
      this.postsHashTags,
      this.pageId,
      this.referencePost,
      this.rootReferencePost,
      this.visibility,
      this.ranges,
      this.updateDate,
      this.emergencyEvent,
      this.emergencyEventTag,
      this.objective,
      this.objectiveTag,
      this.s3CoverImage,
      this.page,
      this.objectiveId,
      this.objectives,
      this.gallery});

  Post1.fromJson(Map<String, dynamic> json) {
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
    commentCount = json["commentCount"];
    repostCount = json["repostCount"];
    shareCount = json["shareCount"];
    likeCount = json["likeCount"];
    viewCount = json["viewCount"];
    createdDate = json["createdDate"];
    startDateTime = json["startDateTime"];
    postsHashTags = json["postsHashTags"] == null ? null : List<String>.from(json["postsHashTags"]);
    pageId = json["pageId"];
    referencePost = json["referencePost"];
    rootReferencePost = json["rootReferencePost"];
    visibility = json["visibility"];
    ranges = json["ranges"];
    updateDate = json["updateDate"];
    emergencyEvent = json["emergencyEvent"];
    emergencyEventTag = json["emergencyEventTag"];
    objective = json["objective"];
    objectiveTag = json["objectiveTag"];
    s3CoverImage = json["s3CoverImage"];
    page = json["page"] == null ? null : Page1.fromJson(json["page"]);
    objectiveId = json["objectiveId"];
    objectives = json["objectives"] == null ? null : (json["objectives"] as List).map((e) => Objectives.fromJson(e)).toList();
    gallery = json["gallery"] == null ? null : (json["gallery"] as List).map((e) => Gallery1.fromJson(e)).toList();
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
    if (postsHashTags != null) data["postsHashTags"] = postsHashTags;
    data["pageId"] = pageId;
    data["referencePost"] = referencePost;
    data["rootReferencePost"] = rootReferencePost;
    data["visibility"] = visibility;
    data["ranges"] = ranges;
    data["updateDate"] = updateDate;
    data["emergencyEvent"] = emergencyEvent;
    data["emergencyEventTag"] = emergencyEventTag;
    data["objective"] = objective;
    data["objectiveTag"] = objectiveTag;
    data["s3CoverImage"] = s3CoverImage;
    if (page != null) data["page"] = page?.toJson();
    data["objectiveId"] = objectiveId;
    if (objectives != null) {
      data["objectives"] = objectives?.map((e) => e.toJson()).toList();
    }
    if (gallery != null) {
      data["gallery"] = gallery?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Gallery1 {
  String? id;
  String? post;
  String? fileId;
  String? imageUrl;
  String? s3ImageUrl;
  int? ordering;

  Gallery1({
    this.id,
    this.post,
    this.fileId,
    this.imageUrl,
    this.s3ImageUrl,
    this.ordering,
  });

  Gallery1.fromJson(Map<String, dynamic> json) {
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

class Objectives {
  String? id;
  String? pageId;
  String? title;
  dynamic detail;
  String? hashTag;
  String? iconUrl;
  String? s3IconUrl;
  String? createdDate;

  Objectives({
    this.id,
    this.pageId,
    this.title,
    this.detail,
    this.hashTag,
    this.iconUrl,
    this.s3IconUrl,
    this.createdDate,
  });

  Objectives.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    pageId = json["pageId"];
    title = json["title"];
    detail = json["detail"];
    hashTag = json["hashTag"];
    iconUrl = json["iconURL"];
    s3IconUrl = json["s3IconURL"];
    createdDate = json["createdDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["pageId"] = pageId;
    data["title"] = title;
    data["detail"] = detail;
    data["hashTag"] = hashTag;
    data["iconURL"] = iconUrl;
    data["s3IconURL"] = s3IconUrl;
    data["createdDate"] = createdDate;
    return data;
  }
}

class Page1 {
  String? id;
  String? name;
  String? pageUsername;
  dynamic subTitle;
  dynamic backgroundStory;
  dynamic detail;
  String? ownerUser;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  dynamic color;
  String? category;
  bool? isOfficial;
  bool? banned;
  String? createdDate;
  dynamic address;
  dynamic facebookUrl;
  dynamic instagramUrl;
  dynamic lineId;
  dynamic mobileNo;
  dynamic twitterUrl;
  dynamic websiteUrl;
  String? updateDate;
  String? updateByUsername;

  Page1({
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
    this.address,
    this.facebookUrl,
    this.instagramUrl,
    this.lineId,
    this.mobileNo,
    this.twitterUrl,
    this.websiteUrl,
    this.updateDate,
    this.updateByUsername,
  });

  Page1.fromJson(Map<String, dynamic> json) {
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
    address = json["address"];
    facebookUrl = json["facebookURL"];
    instagramUrl = json["instagramURL"];
    lineId = json["lineId"];
    mobileNo = json["mobileNo"];
    twitterUrl = json["twitterURL"];
    websiteUrl = json["websiteURL"];
    updateDate = json["updateDate"];
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
    data["address"] = address;
    data["facebookURL"] = facebookUrl;
    data["instagramURL"] = instagramUrl;
    data["lineId"] = lineId;
    data["mobileNo"] = mobileNo;
    data["twitterURL"] = twitterUrl;
    data["websiteURL"] = websiteUrl;
    data["updateDate"] = updateDate;
    data["updateByUsername"] = updateByUsername;
    return data;
  }
}

class PostSectionModel {
  String? title;
  String? subtitle;
  String? description;
  List<Contents2>? contents;
  String? iconUrl;
  dynamic dateTime;
  bool? isList;
  bool? isHighlight;

  PostSectionModel({
    this.title,
    this.subtitle,
    this.description,
    this.contents,
    this.iconUrl,
    this.dateTime,
    this.isList,
    this.isHighlight,
  });

  PostSectionModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    subtitle = json["subtitle"];
    description = json["description"];
    contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents2.fromJson(e)).toList();
    iconUrl = json["iconUrl"];
    dateTime = json["dateTime"];
    isList = json["isList"];
    isHighlight = json["isHighlight"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["subtitle"] = subtitle;
    data["description"] = description;
    if (contents != null) {
      data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    data["iconUrl"] = iconUrl;
    data["dateTime"] = dateTime;
    data["isList"] = isList;
    data["isHighlight"] = isHighlight;
    return data;
  }
}

class PageRoundRobin {
  dynamic createdBy;
  dynamic createdDate;
  dynamic createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? title;
  String? subtitle;
  String? description;
  dynamic type;
  dynamic link;
  List<Contents>? contents;
  String? iconUrl;
  dynamic contentCount;
  dynamic dateTime;
  dynamic templateType;
  dynamic data;
  bool? isList;
  bool? isHighlight;
  int? position;
  dynamic majorTrendHashTags;
  dynamic mirrorTrends;
  dynamic isFollowing;
  dynamic owner;

  PageRoundRobin(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.title,
      this.subtitle,
      this.description,
      this.type,
      this.link,
      this.contents,
      this.iconUrl,
      this.contentCount,
      this.dateTime,
      this.templateType,
      this.data,
      this.isList,
      this.isHighlight,
      this.position,
      this.majorTrendHashTags,
      this.mirrorTrends,
      this.isFollowing,
      this.owner});

  PageRoundRobin.fromJson(Map<String, dynamic> json) {
    createdBy = json["createdBy"];
    createdDate = json["createdDate"];
    createdTime = json["createdTime"];
    createdByUsername = json["createdByUsername"];
    updateDate = json["updateDate"];
    updateByUsername = json["updateByUsername"];
    title = json["title"];
    subtitle = json["subtitle"];
    description = json["description"];
    type = json["type"];
    link = json["link"];
    contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents.fromJson(e)).toList();
    iconUrl = json["iconUrl"];
    contentCount = json["contentCount"];
    dateTime = json["dateTime"];
    templateType = json["templateType"];
    data = json["data"];
    isList = json["isList"];
    isHighlight = json["isHighlight"];
    position = json["position"];
    majorTrendHashTags = json["majorTrendHashTags"];
    mirrorTrends = json["mirrorTrends"];
    isFollowing = json["isFollowing"];
    owner = json["owner"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["title"] = title;
    _data["subtitle"] = subtitle;
    _data["description"] = description;
    _data["type"] = type;
    _data["link"] = link;
    if (contents != null) {
      _data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    _data["iconUrl"] = iconUrl;
    _data["contentCount"] = contentCount;
    _data["dateTime"] = dateTime;
    _data["templateType"] = templateType;
    _data["data"] = data;
    _data["isList"] = isList;
    _data["isHighlight"] = isHighlight;
    _data["position"] = position;
    _data["majorTrendHashTags"] = majorTrendHashTags;
    _data["mirrorTrends"] = mirrorTrends;
    _data["isFollowing"] = isFollowing;
    _data["owner"] = owner;
    return _data;
  }
}

class Contents2 {
  String? coverPageUrl;
  Owner? owner;
  Post? post;

  Contents2({
    this.coverPageUrl,
    this.owner,
    this.post,
  });

  Contents2.fromJson(Map<String, dynamic> json) {
    coverPageUrl = json["coverPageUrl"];
    owner = json["owner"] == null ? null : Owner.fromJson(json["owner"]);
    post = json["post"] == null ? null : Post.fromJson(json["post"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["coverPageUrl"] = coverPageUrl;
    if (owner != null) data["owner"] = owner?.toJson();
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
  String? createdDate;
  String? startDateTime;
  List<String>? postsHashTags;
  String? pageId;
  dynamic referencePost;
  dynamic rootReferencePost;
  dynamic visibility;
  dynamic ranges;
  String? updateDate;
  Page? page;
  List<Gallery>? gallery;
  bool? isLike;

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
    this.postsHashTags,
    this.pageId,
    this.referencePost,
    this.rootReferencePost,
    this.visibility,
    this.ranges,
    this.updateDate,
    this.page,
    this.gallery,
    this.isLike,
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
    commentCount = json["commentCount"];
    repostCount = json["repostCount"];
    shareCount = json["shareCount"];
    likeCount = json["likeCount"];
    viewCount = json["viewCount"];
    createdDate = json["createdDate"];
    startDateTime = json["startDateTime"];
    postsHashTags = json["postsHashTags"] == null ? null : List<String>.from(json["postsHashTags"]);
    pageId = json["pageId"];
    referencePost = json["referencePost"];
    rootReferencePost = json["rootReferencePost"];
    visibility = json["visibility"];
    ranges = json["ranges"];
    updateDate = json["updateDate"];
    page = json["page"] == null ? null : Page.fromJson(json["page"]);
    gallery = json["gallery"] == null ? null : (json["gallery"] as List).map((e) => Gallery.fromJson(e)).toList();
    isLike = json["isLike"];
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
    if (postsHashTags != null) data["postsHashTags"] = postsHashTags;
    data["pageId"] = pageId;
    data["referencePost"] = referencePost;
    data["rootReferencePost"] = rootReferencePost;
    data["visibility"] = visibility;
    data["ranges"] = ranges;
    data["updateDate"] = updateDate;
    if (page != null) data["page"] = page?.toJson();
    if (gallery != null) {
      data["gallery"] = gallery?.map((e) => e.toJson()).toList();
    }
    data["isLike"] = isLike;
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
  dynamic subTitle;
  dynamic backgroundStory;
  dynamic detail;
  String? ownerUser;
  String? imageUrl;
  String? coverUrl;
  double? coverPosition;
  dynamic color;
  String? category;
  bool? isOfficial;
  bool? banned;
  String? createdDate;
  String? updateDate;
  String? address;
  String? facebookUrl;
  dynamic instagramUrl;
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

class Owner {
  String? id;
  String? name;
  String? imageUrl;
  bool? isOfficial;
  String? uniqueId;
  String? type;

  Owner({
    this.id,
    this.name,
    this.imageUrl,
    this.isOfficial,
    this.uniqueId,
    this.type,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    isOfficial = json["isOfficial"];
    uniqueId = json["uniqueId"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["imageURL"] = imageUrl;
    data["isOfficial"] = isOfficial;
    data["uniqueId"] = uniqueId;
    data["type"] = type;
    return data;
  }
}

class EmergencyPin {
  String? title;
  String? subtitle;
  String? description;
  List<Contents1>? contents;
  String? iconUrl;
  String? dateTime;
  bool? isList;
  bool? isHighlight;

  EmergencyPin({this.title, this.subtitle, this.description, this.contents, this.iconUrl, this.dateTime, this.isList, this.isHighlight});

  EmergencyPin.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    subtitle = json["subtitle"];
    description = json["description"];
    contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents1.fromJson(e)).toList();
    iconUrl = json["iconUrl"];
    dateTime = json["dateTime"];
    isList = json["isList"];
    isHighlight = json["isHighlight"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["subtitle"] = subtitle;
    data["description"] = description;
    if (contents != null) {
      data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    data["iconUrl"] = iconUrl;
    data["dateTime"] = dateTime;
    data["isList"] = isList;
    data["isHighlight"] = isHighlight;
    return data;
  }
}

class Contents1 {
  String? title;
  String? description;
  String? dateTime;
  int? postCount;
  int? commentCount;
  int? likeCount;
  int? shareCount;
  int? viewCount;
  int? repostCount;
  String? coverPageUrl;
  String? coverPageSignUrl;
  Data2? data;

  Contents1({
    this.title,
    this.description,
    this.dateTime,
    this.postCount,
    this.commentCount,
    this.likeCount,
    this.shareCount,
    this.viewCount,
    this.repostCount,
    this.coverPageUrl,
    this.coverPageSignUrl,
    this.data,
  });

  Contents1.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    dateTime = json["dateTime"];
    postCount = json["postCount"];
    commentCount = json["commentCount"];
    likeCount = json["likeCount"];
    shareCount = json["shareCount"];
    viewCount = json["viewCount"];
    repostCount = json["repostCount"];
    coverPageUrl = json["coverPageUrl"];
    coverPageSignUrl = json["coverPageSignUrl"];
    data = json["data"] == null ? null : Data2.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["dateTime"] = dateTime;
    data["postCount"] = postCount;
    data["commentCount"] = commentCount;
    data["likeCount"] = likeCount;
    data["shareCount"] = shareCount;
    data["viewCount"] = viewCount;
    data["repostCount"] = repostCount;
    data["coverPageUrl"] = coverPageUrl;
    data["coverPageSignUrl"] = coverPageSignUrl;
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data2 {
  String? emergencyEventId;

  Data2({this.emergencyEventId});

  Data2.fromJson(Map<String, dynamic> json) {
    emergencyEventId = json["emergencyEventId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["emergencyEventId"] = emergencyEventId;
    return data;
  }
}

class EmergencyEvents {
  String? title;
  String? subtitle;
  String? description;
  String? type;
  List<Contents>? contents;
  String? iconUrl;
  int? contentCount;
  String? dateTime;
  bool? isList;
  bool? isHighlight;
  List<MajorTrendHashTags>? majorTrendHashTags;

  EmergencyEvents({
    this.title,
    this.subtitle,
    this.description,
    this.type,
    this.contents,
    this.iconUrl,
    this.contentCount,
    this.dateTime,
    this.isList,
    this.isHighlight,
    this.majorTrendHashTags,
  });

  EmergencyEvents.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    subtitle = json["subtitle"];
    description = json["description"];
    type = json["type"];
    contents = json["contents"] == null ? null : (json["contents"] as List).map((e) => Contents.fromJson(e)).toList();
    iconUrl = json["iconUrl"];
    contentCount = json["contentCount"];
    dateTime = json["dateTime"];
    isList = json["isList"];
    isHighlight = json["isHighlight"];
    majorTrendHashTags = json["majorTrendHashTags"] == null ? null : (json["majorTrendHashTags"] as List).map((e) => MajorTrendHashTags.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["subtitle"] = subtitle;
    data["description"] = description;
    data["type"] = type;
    if (contents != null) {
      data["contents"] = contents?.map((e) => e.toJson()).toList();
    }
    data["iconUrl"] = iconUrl;
    data["contentCount"] = contentCount;
    data["dateTime"] = dateTime;
    data["isList"] = isList;
    data["isHighlight"] = isHighlight;
    return data;
  }
}

class MajorTrendHashTags {
  String? id;
  String? name;

  MajorTrendHashTags({this.id, this.name});

  MajorTrendHashTags.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"] == null ? null : '#${json["name"]}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    return data;
  }
}

class Contents {
  String? title;
  String? description;
  String? dateTime;
  int? postCount;
  int? commentCount;
  int? likeCount;
  int? shareCount;
  int? viewCount;
  int? repostCount;
  String? coverPageUrl;
  String? coverPageSignUrl;
  Data1? data;
  Owner? owner;
  Post? post;

  Contents({
    this.title,
    this.description,
    this.dateTime,
    this.postCount,
    this.commentCount,
    this.likeCount,
    this.shareCount,
    this.viewCount,
    this.repostCount,
    this.coverPageUrl,
    this.coverPageSignUrl,
    this.data,
    this.owner,
    this.post,
  });

  Contents.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    dateTime = json["dateTime"];
    postCount = json["postCount"];
    commentCount = json["commentCount"];
    likeCount = json["likeCount"];
    shareCount = json["shareCount"];
    viewCount = json["viewCount"];
    repostCount = json["repostCount"];
    coverPageUrl = json["coverPageUrl"];
    coverPageSignUrl = json["coverPageSignUrl"];
    data = json["data"] == null ? null : Data1.fromJson(json["data"]);
    owner = json["owner"] == null ? null : Owner.fromJson(json["owner"]);
    post = json["post"] == null ? null : Post.fromJson(json["post"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["dateTime"] = dateTime;
    data["postCount"] = postCount;
    data["commentCount"] = commentCount;
    data["likeCount"] = likeCount;
    data["shareCount"] = shareCount;
    data["viewCount"] = viewCount;
    data["repostCount"] = repostCount;
    data["coverPageUrl"] = coverPageUrl;
    data["coverPageSignUrl"] = coverPageSignUrl;
    if (this.data != null) data["data"] = this.data?.toJson();
    if (owner != null) data["owner"] = owner?.toJson();
    if (this.post != null) data["post"] = this.post?.toJson();
    return data;
  }
}

class Data1 {
  String? emergencyEventId;

  Data1({this.emergencyEventId});

  Data1.fromJson(Map<String, dynamic> json) {
    emergencyEventId = json["emergencyEventId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["emergencyEventId"] = emergencyEventId;
    return data;
  }
}
