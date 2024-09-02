import '../../component/convert_image_component.dart';

class VoteMainContentsModel {
  int? status;
  String? message;
  Data? data;
  int? count;

  VoteMainContentsModel({this.status, this.message, this.data, this.count});

  VoteMainContentsModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
    if (json["count"] is int) {
      count = json["count"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["count"] = count;
    return _data;
  }
}

class Data {
  List<Pin>? pin;
  List<MyVote>? myVote;
  List<Supporter>? supporter;
  List<CloseDate>? closeDate;
  List<HashTagVote>? hashTagVote;
  List<ClosetSupport>? closetSupport;
  List<String>? voteObjId;

  Data({this.pin, this.myVote, this.supporter, this.closeDate, this.hashTagVote, this.closetSupport, this.voteObjId});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["pin"] is List) {
      pin = json["pin"] == null ? null : (json["pin"] as List).map((e) => Pin.fromJson(e)).toList();
    }
    if (json["myVote"] is List) {
      myVote = json["myVote"] == null ? null : (json["myVote"] as List).map((e) => MyVote.fromJson(e)).toList();
    }
    if (json["supporter"] is List) {
      supporter = json["supporter"] == null ? null : (json["supporter"] as List).map((e) => Supporter.fromJson(e)).toList();
    }
    if (json["closeDate"] is List) {
      closeDate = json["closeDate"] == null ? null : (json["closeDate"] as List).map((e) => CloseDate.fromJson(e)).toList();
    }
    if (json["hashTagVote"] is List) {
      hashTagVote = json["hashTagVote"] == null ? null : (json["hashTagVote"] as List).map((e) => HashTagVote.fromJson(e)).toList();
    }
    if (json["closetSupport"] is List) {
      closetSupport = json["closetSupport"] == null ? null : (json["closetSupport"] as List).map((e) => ClosetSupport.fromJson(e)).toList();
    }
    if (json["voteObjId"] is List) {
      voteObjId = json["voteObjId"] == null ? null : (json["voteObjId"] as List).map((e) => e.toString()).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (pin != null) {
      _data["pin"] = pin?.map((e) => e.toJson()).toList();
    }
    if (myVote != null) {
      _data["myVote"] = myVote;
    }
    if (supporter != null) {
      _data["supporter"] = supporter?.map((e) => e.toJson()).toList();
    }
    if (closeDate != null) {
      _data["closeDate"] = closeDate?.map((e) => e.toJson()).toList();
    }
    if (hashTagVote != null) {
      _data["hashTagVote"] = hashTagVote?.map((e) => e.toJson()).toList();
    }
    if (closetSupport != null) {
      _data["closetSupport"] = closetSupport?.map((e) => e.toJson()).toList();
    }
    if (voteObjId != null) {
      _data["voteObjId"] = voteObjId;
    }
    return _data;
  }
}

class ClosetSupport {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? voteImage;
  String? s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  int? voteDaysRange;
  String? startVoteDatetime;
  String? endVoteDatetime;
  int? supportDaysRange;
  String? startSupportDatetime;
  String? endSupportDatetime;
  String? closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  String? service;
  bool? hide;
  Page? page;
  User1? user;
  bool? userSupport;
  bool? myVotes;

  ClosetSupport(
      {this.id,
      this.createdDate,
      this.title,
      this.detail,
      this.voteImage,
      this.s3CoverPageUrl,
      this.userId,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.voteDaysRange,
      this.startVoteDatetime,
      this.endVoteDatetime,
      this.supportDaysRange,
      this.startSupportDatetime,
      this.endSupportDatetime,
      this.closeDate,
      this.status,
      this.type,
      this.hashTag,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.hide,
      this.page,
      this.user,
      this.userSupport,
      this.myVotes});

  ClosetSupport.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["approved"] is bool) {
      approved = json["approved"];
    }
    if (json["closed"] is bool) {
      closed = json["closed"];
    }
    if (json["minSupport"] is int) {
      minSupport = json["minSupport"];
    }
    if (json["countSupport"] is int) {
      countSupport = json["countSupport"];
    }
    if (json["voteDaysRange"] is int) {
      voteDaysRange = json["voteDaysRange"];
    }
    if (json["startVoteDatetime"] is String) {
      startVoteDatetime = json["startVoteDatetime"];
    }
    if (json["endVoteDatetime"] is String) {
      endVoteDatetime = json["endVoteDatetime"];
    }
    if (json["supportDaysRange"] is int) {
      supportDaysRange = json["supportDaysRange"];
    }
    if (json["startSupportDatetime"] is String) {
      startSupportDatetime = json["startSupportDatetime"];
    }
    if (json["endSupportDatetime"] is String) {
      endSupportDatetime = json["endSupportDatetime"];
    }
    if (json["closeDate"] is String) {
      closeDate = json["closeDate"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    if (json["pin"] is bool) {
      pin = json["pin"];
    }
    if (json["showVoterName"] is bool) {
      showVoterName = json["showVoterName"];
    }
    if (json["showVoteResult"] is bool) {
      showVoteResult = json["showVoteResult"];
    }
    if (json["service"] is String) {
      service = json["service"];
    }
    if (json["hide"] is bool) {
      hide = json["hide"];
    }
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    if (json["userSupport"] is bool) {
      userSupport = json["userSupport"];
    }
    if (json["myVotes"] is bool) {
      myVotes = json["myVotes"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdDate"] = createdDate;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["coverPageURL"] = voteImage;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["userId"] = userId;
    _data["approved"] = approved;
    _data["closed"] = closed;
    _data["minSupport"] = minSupport;
    _data["countSupport"] = countSupport;
    _data["voteDaysRange"] = voteDaysRange;
    _data["startVoteDatetime"] = startVoteDatetime;
    _data["endVoteDatetime"] = endVoteDatetime;
    _data["supportDaysRange"] = supportDaysRange;
    _data["startSupportDatetime"] = startSupportDatetime;
    _data["endSupportDatetime"] = endSupportDatetime;
    _data["closeDate"] = closeDate;
    _data["status"] = status;
    _data["type"] = type;
    _data["hashTag"] = hashTag;
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    _data["hide"] = hide;
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["userSupport"] = userSupport;
    _data["myVotes"] = myVotes;
    return _data;
  }
}

class HashTagVote {
  String? id;
  int? count;
  List<VotingEvent>? votingEvent;

  HashTagVote({this.id, this.count, this.votingEvent});

  HashTagVote.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["votingEvent"] is List) {
      votingEvent = json["votingEvent"] == null ? null : (json["votingEvent"] as List).map((e) => VotingEvent.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["count"] = count;
    if (votingEvent != null) {
      _data["votingEvent"] = votingEvent?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class VotingEvent {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? voteImage;
  String? s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  int? voteDaysRange;
  String? endVoteDatetime;
  int? supportDaysRange;
  String? closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  String? startVoteDatetime;
  String? startSupportDatetime;
  String? endSupportDatetime;
  User1? user;
  Page? page;
  bool? userSupport;

  VotingEvent(
      {this.id,
      this.createdDate,
      this.title,
      this.detail,
      this.voteImage,
      this.s3CoverPageUrl,
      this.userId,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.voteDaysRange,
      this.endVoteDatetime,
      this.supportDaysRange,
      this.closeDate,
      this.status,
      this.type,
      this.hashTag,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.startVoteDatetime,
      this.startSupportDatetime,
      this.endSupportDatetime,
      this.user,
      this.page,
      this.userSupport});

  VotingEvent.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["approved"] is bool) {
      approved = json["approved"];
    }
    if (json["closed"] is bool) {
      closed = json["closed"];
    }
    if (json["minSupport"] is int) {
      minSupport = json["minSupport"];
    }
    if (json["countSupport"] is int) {
      countSupport = json["countSupport"];
    }
    if (json["voteDaysRange"] is int) {
      voteDaysRange = json["voteDaysRange"];
    }
    if (json["endVoteDatetime"] is String) {
      endVoteDatetime = json["endVoteDatetime"];
    }
    if (json["supportDaysRange"] is int) {
      supportDaysRange = json["supportDaysRange"];
    }
    if (json["closeDate"] is String) {
      closeDate = json["closeDate"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    type = json["type"] ?? '';
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    if (json["pin"] is bool) {
      pin = json["pin"];
    }
    if (json["showVoterName"] is bool) {
      showVoterName = json["showVoterName"];
    }
    if (json["showVoteResult"] is bool) {
      showVoteResult = json["showVoteResult"];
    }
    service = json["service"];
    if (json["startVoteDatetime"] is String) {
      startVoteDatetime = json["startVoteDatetime"];
    }
    if (json["startSupportDatetime"] is String) {
      startSupportDatetime = json["startSupportDatetime"];
    }
    if (json["endSupportDatetime"] is String) {
      endSupportDatetime = json["endSupportDatetime"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
    }
    if (json["userSupport"] is bool) {
      userSupport = json["userSupport"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdDate"] = createdDate;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["coverPageURL"] = voteImage;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["userId"] = userId;
    _data["approved"] = approved;
    _data["closed"] = closed;
    _data["minSupport"] = minSupport;
    _data["countSupport"] = countSupport;
    _data["endVoteDatetime"] = endVoteDatetime;
    _data["supportDaysRange"] = supportDaysRange;
    _data["closeDate"] = closeDate;
    _data["status"] = status;
    _data["type"] = type;
    _data["hashTag"] = hashTag;
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    _data["startVoteDatetime"] = startVoteDatetime;
    _data["startSupportDatetime"] = startSupportDatetime;
    _data["endSupportDatetime"] = endSupportDatetime;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    _data["userSupport"] = userSupport;
    return _data;
  }
}

class User1 {
  String? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? imageUrl;
  dynamic s3ImageUrl;

  User1({this.id, this.email, this.name, this.firstName, this.lastName, this.imageUrl, this.s3ImageUrl});

  User1.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["username"] is String) {
      email = json["username"];
    }
    if (json["firstName"] is String) {
      name = json["firstName"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["imageURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
            : '';
    s3ImageUrl = json["s3ImageURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["username"] = name;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["imageURL"] = imageUrl;
    _data["s3ImageURL"] = s3ImageUrl;
    return _data;
  }
}

class CloseDate {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? voteImage;
  String? s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  String? endVoteDatetime;
  int? supportDaysRange;
  String? startSupportDatetime;
  String? endSupportDatetime;
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  Page? page;
  User1? user;
  bool? userSupport;

  CloseDate(
      {this.id,
      this.createdDate,
      this.title,
      this.detail,
      this.voteImage,
      this.s3CoverPageUrl,
      this.userId,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.endVoteDatetime,
      this.supportDaysRange,
      this.startSupportDatetime,
      this.endSupportDatetime,
      this.closeDate,
      this.status,
      this.type,
      this.hashTag,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.page,
      this.user,
      this.userSupport});

  CloseDate.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["approved"] is bool) {
      approved = json["approved"];
    }
    if (json["closed"] is bool) {
      closed = json["closed"];
    }
    if (json["minSupport"] is int) {
      minSupport = json["minSupport"];
    }
    if (json["countSupport"] is int) {
      countSupport = json["countSupport"];
    }
    if (json["endVoteDatetime"] is String) {
      endVoteDatetime = json["endVoteDatetime"];
    }
    if (json["supportDaysRange"] is int) {
      supportDaysRange = json["supportDaysRange"];
    }
    if (json["startSupportDatetime"] is String) {
      startSupportDatetime = json["startSupportDatetime"];
    }
    if (json["endSupportDatetime"] is String) {
      endSupportDatetime = json["endSupportDatetime"];
    }
    closeDate = json["closeDate"];
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    // if (json["hashTag"] is Map) {
    //   hashTag = json["hashTag"] == null ? null : HashTag.fromJson(json["hashTag"]);
    // }
    if (json["pin"] is bool) {
      pin = json["pin"];
    }
    if (json["showVoterName"] is bool) {
      showVoterName = json["showVoterName"];
    }
    if (json["showVoteResult"] is bool) {
      showVoteResult = json["showVoteResult"];
    }
    service = json["service"];
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    if (json["userSupport"] is bool) {
      userSupport = json["userSupport"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdDate"] = createdDate;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["coverPageURL"] = voteImage;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["userId"] = userId;
    _data["approved"] = approved;
    _data["closed"] = closed;
    _data["minSupport"] = minSupport;
    _data["countSupport"] = countSupport;
    _data["endVoteDatetime"] = endVoteDatetime;
    _data["supportDaysRange"] = supportDaysRange;
    _data["startSupportDatetime"] = startSupportDatetime;
    _data["endSupportDatetime"] = endSupportDatetime;
    _data["closeDate"] = closeDate;
    _data["status"] = status;
    _data["type"] = type;
    _data["hashTag"] = hashTag;
    // if (hashTag != null) {
    //   _data["hashTag"] = hashTag?.toJson();
    // }
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["userSupport"] = userSupport;
    return _data;
  }
}

/* class Page1 {
  String? id;
  String? name;
  String? pageUsername;
  String? imageUrl;
  bool? isOfficial;
  bool? banned;
  dynamic s3ImageUrl;

  Page1({this.id, this.name, this.pageUsername, this.imageUrl, this.isOfficial, this.banned, this.s3ImageUrl});

  Page1.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["pageUsername"] is String) {
      pageUsername = json["pageUsername"];
    }
    if (json["imageURL"] is String) {
      imageUrl = json["imageURL"];
    }
    if (json["isOfficial"] is bool) {
      isOfficial = json["isOfficial"];
    }
    if (json["banned"] is bool) {
      banned = json["banned"];
    }
    s3ImageUrl = json["s3ImageURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["pageUsername"] = pageUsername;
    _data["imageURL"] = imageUrl;
    _data["isOfficial"] = isOfficial;
    _data["banned"] = banned;
    _data["s3ImageURL"] = s3ImageUrl;
    return _data;
  }
} */

/* class HashTag1 {
  dynamic createdBy;
  String? createdDate;
  String? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? id;
  String? name;
  String? iconUrl;
  int? count;
  String? lastActiveDate;
  dynamic pageId;
  dynamic objectiveId;
  dynamic type;
  bool? personal;

  HashTag1(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.id,
      this.name,
      this.iconUrl,
      this.count,
      this.lastActiveDate,
      this.pageId,
      this.objectiveId,
      this.type,
      this.personal});

  HashTag1.fromJson(Map<String, dynamic> json) {
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
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["iconURL"] is String) {
      iconUrl = json["iconURL"];
    }
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["lastActiveDate"] is String) {
      lastActiveDate = json["lastActiveDate"];
    }
    pageId = json["pageId"];
    objectiveId = json["objectiveId"];
    type = json["type"];
    if (json["personal"] is bool) {
      personal = json["personal"];
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
    _data["id"] = id;
    _data["name"] = name;
    _data["iconURL"] = iconUrl;
    _data["count"] = count;
    _data["lastActiveDate"] = lastActiveDate;
    _data["pageId"] = pageId;
    _data["objectiveId"] = objectiveId;
    _data["type"] = type;
    _data["personal"] = personal;
    return _data;
  }
} */

class Supporter {
  String? id;
  String? createdDate;
  String? title;
  dynamic detail;
  dynamic coverPageUrl;
  dynamic s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  String? startVoteDatetime;
  String? endVoteDatetime;
  int? supportDaysRange;
  String? startSupportDatetime;
  String? endSupportDatetime;
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  User1? user;
  bool? userSupport;

  Supporter(
      {this.id,
      this.createdDate,
      this.title,
      this.detail,
      this.coverPageUrl,
      this.s3CoverPageUrl,
      this.userId,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.startVoteDatetime,
      this.endVoteDatetime,
      this.supportDaysRange,
      this.startSupportDatetime,
      this.endSupportDatetime,
      this.closeDate,
      this.status,
      this.type,
      this.hashTag,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.user,
      this.userSupport});

  Supporter.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    detail = json["detail"];
    coverPageUrl = json["coverPageURL"];
    s3CoverPageUrl = json["s3CoverPageURL"];
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["approved"] is bool) {
      approved = json["approved"];
    }
    if (json["closed"] is bool) {
      closed = json["closed"];
    }
    if (json["minSupport"] is int) {
      minSupport = json["minSupport"];
    }
    if (json["countSupport"] is int) {
      countSupport = json["countSupport"];
    }
    if (json["startVoteDatetime"] is String) {
      startVoteDatetime = json["startVoteDatetime"];
    }
    if (json["endVoteDatetime"] is String) {
      endVoteDatetime = json["endVoteDatetime"];
    }
    if (json["supportDaysRange"] is int) {
      supportDaysRange = json["supportDaysRange"];
    }
    if (json["startSupportDatetime"] is String) {
      startSupportDatetime = json["startSupportDatetime"];
    }
    if (json["endSupportDatetime"] is String) {
      endSupportDatetime = json["endSupportDatetime"];
    }
    closeDate = json["closeDate"];
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    if (json["pin"] is bool) {
      pin = json["pin"];
    }
    if (json["showVoterName"] is bool) {
      showVoterName = json["showVoterName"];
    }
    if (json["showVoteResult"] is bool) {
      showVoteResult = json["showVoteResult"];
    }
    service = json["service"];
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    if (json["userSupport"] is bool) {
      userSupport = json["userSupport"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdDate"] = createdDate;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["coverPageURL"] = coverPageUrl;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["userId"] = userId;
    _data["approved"] = approved;
    _data["closed"] = closed;
    _data["minSupport"] = minSupport;
    _data["countSupport"] = countSupport;
    _data["startVoteDatetime"] = startVoteDatetime;
    _data["endVoteDatetime"] = endVoteDatetime;
    _data["supportDaysRange"] = supportDaysRange;
    _data["startSupportDatetime"] = startSupportDatetime;
    _data["endSupportDatetime"] = endSupportDatetime;
    _data["closeDate"] = closeDate;
    _data["status"] = status;
    _data["type"] = type;
    _data["hashTag"] = hashTag;
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["userSupport"] = userSupport;
    return _data;
  }
}

/* class User {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? imageUrl;
  String? s3ImageUrl;

  User({this.id, this.username, this.firstName, this.lastName, this.imageUrl, this.s3ImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["username"] is String) {
      username = json["username"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    if (json["imageURL"] is String) {
      imageUrl = json["imageURL"];
    }
    if (json["s3ImageURL"] is String) {
      s3ImageUrl = json["s3ImageURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["username"] = username;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["imageURL"] = imageUrl;
    _data["s3ImageURL"] = s3ImageUrl;
    return _data;
  }
} */

class Pin {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? voteImage;
  String? s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  String? endVoteDatetime;
  int? supportDaysRange;
  String? startSupportDatetime;
  String? endSupportDatetime;
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  Page? page;
  User1? user;
  bool? userSupport;

  Pin(
      {this.id,
      this.createdDate,
      this.title,
      this.detail,
      this.voteImage,
      this.s3CoverPageUrl,
      this.userId,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.endVoteDatetime,
      this.supportDaysRange,
      this.startSupportDatetime,
      this.endSupportDatetime,
      this.closeDate,
      this.status,
      this.type,
      this.hashTag,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.page,
      this.user,
      this.userSupport});

  Pin.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["approved"] is bool) {
      approved = json["approved"];
    }
    if (json["closed"] is bool) {
      closed = json["closed"];
    }
    if (json["minSupport"] is int) {
      minSupport = json["minSupport"];
    }
    if (json["countSupport"] is int) {
      countSupport = json["countSupport"];
    }
    if (json["endVoteDatetime"] is String) {
      endVoteDatetime = json["endVoteDatetime"];
    }
    if (json["supportDaysRange"] is int) {
      supportDaysRange = json["supportDaysRange"];
    }
    if (json["startSupportDatetime"] is String) {
      startSupportDatetime = json["startSupportDatetime"];
    }
    if (json["endSupportDatetime"] is String) {
      endSupportDatetime = json["endSupportDatetime"];
    }
    closeDate = json["closeDate"];
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    // if (json["hashTag"] is Map) {
    //   hashTag = json["hashTag"] == null ? null : HashTag.fromJson(json["hashTag"]);
    // }
    if (json["pin"] is bool) {
      pin = json["pin"];
    }
    if (json["showVoterName"] is bool) {
      showVoterName = json["showVoterName"];
    }
    if (json["showVoteResult"] is bool) {
      showVoteResult = json["showVoteResult"];
    }
    service = json["service"];
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    if (json["userSupport"] is bool) {
      userSupport = json["userSupport"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdDate"] = createdDate;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["coverPageURL"] = voteImage;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["userId"] = userId;
    _data["approved"] = approved;
    _data["closed"] = closed;
    _data["minSupport"] = minSupport;
    _data["countSupport"] = countSupport;
    _data["endVoteDatetime"] = endVoteDatetime;
    _data["supportDaysRange"] = supportDaysRange;
    _data["startSupportDatetime"] = startSupportDatetime;
    _data["endSupportDatetime"] = endSupportDatetime;
    _data["closeDate"] = closeDate;
    _data["status"] = status;
    _data["type"] = type;
    _data["hashTag"] = hashTag;
    // if (hashTag != null) {
    //   _data["hashTag"] = hashTag?.toJson();
    // }
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["userSupport"] = userSupport;
    return _data;
  }
}

class MyVote {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? voteImage;
  String? s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  String? startVoteDatetime;
  dynamic endVoteDatetime;
  int? supportDaysRange;
  String? startSupportDatetime;
  String? endSupportDatetime;
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  Page? page;
  User1? user;
  bool? userSupport;

  MyVote(
      {this.id,
      this.createdDate,
      this.title,
      this.detail,
      this.voteImage,
      this.s3CoverPageUrl,
      this.userId,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.startVoteDatetime,
      this.endVoteDatetime,
      this.supportDaysRange,
      this.startSupportDatetime,
      this.endSupportDatetime,
      this.closeDate,
      this.status,
      this.type,
      this.hashTag,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.page,
      this.user,
      this.userSupport});

  MyVote.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["approved"] is bool) {
      approved = json["approved"];
    }
    if (json["closed"] is bool) {
      closed = json["closed"];
    }
    if (json["minSupport"] is int) {
      minSupport = json["minSupport"];
    }
    if (json["countSupport"] is int) {
      countSupport = json["countSupport"];
    }
    if (json["startVoteDatetime"] is String) {
      startVoteDatetime = json["startVoteDatetime"];
    }
    endVoteDatetime = json["endVoteDatetime"];
    if (json["supportDaysRange"] is int) {
      supportDaysRange = json["supportDaysRange"];
    }
    if (json["startSupportDatetime"] is String) {
      startSupportDatetime = json["startSupportDatetime"];
    }
    if (json["endSupportDatetime"] is String) {
      endSupportDatetime = json["endSupportDatetime"];
    }
    closeDate = json["closeDate"];
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    // if (json["hashTag"] is Map) {
    //   hashTag = json["hashTag"] == null ? null : HashTag.fromJson(json["hashTag"]);
    // }
    if (json["pin"] is bool) {
      pin = json["pin"];
    }
    if (json["showVoterName"] is bool) {
      showVoterName = json["showVoterName"];
    }
    if (json["showVoteResult"] is bool) {
      showVoteResult = json["showVoteResult"];
    }
    service = json["service"];
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    if (json["userSupport"] is bool) {
      userSupport = json["userSupport"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdDate"] = createdDate;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["coverPageURL"] = voteImage;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["userId"] = userId;
    _data["approved"] = approved;
    _data["closed"] = closed;
    _data["minSupport"] = minSupport;
    _data["countSupport"] = countSupport;
    _data["startVoteDatetime"] = startVoteDatetime;
    _data["endVoteDatetime"] = endVoteDatetime;
    _data["supportDaysRange"] = supportDaysRange;
    _data["startVoteDatetime"] = startVoteDatetime;
    _data["startSupportDatetime"] = startSupportDatetime;
    _data["closeDate"] = closeDate;
    _data["status"] = status;
    _data["type"] = type;
    _data["hashTag"] = hashTag;
    // if (hashTag != null) {
    //   _data["hashTag"] = hashTag?.toJson();
    // }
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["userSupport"] = userSupport;
    return _data;
  }
}

class Page {
  String? id;
  String? name;
  String? pageUsername;
  String? imageUrl;
  bool? isOfficial;
  bool? banned;
  dynamic s3ImageUrl;

  Page({this.id, this.name, this.pageUsername, this.imageUrl, this.isOfficial, this.banned, this.s3ImageUrl});

  Page.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["pageUsername"] is String) {
      pageUsername = json["pageUsername"];
    }
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["imageURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
            : '';
    if (json["isOfficial"] is bool) {
      isOfficial = json["isOfficial"];
    }
    if (json["banned"] is bool) {
      banned = json["banned"];
    }
    s3ImageUrl = json["s3ImageURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["pageUsername"] = pageUsername;
    _data["imageURL"] = imageUrl;
    _data["isOfficial"] = isOfficial;
    _data["banned"] = banned;
    _data["s3ImageURL"] = s3ImageUrl;
    return _data;
  }
}

class HashTag {
  dynamic createdBy;
  String? createdDate;
  String? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? id;
  String? name;
  String? iconUrl;
  int? count;
  String? lastActiveDate;
  dynamic pageId;
  dynamic objectiveId;
  dynamic type;
  bool? personal;

  HashTag(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.id,
      this.name,
      this.iconUrl,
      this.count,
      this.lastActiveDate,
      this.pageId,
      this.objectiveId,
      this.type,
      this.personal});

  HashTag.fromJson(Map<String, dynamic> json) {
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
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["iconURL"] is String) {
      iconUrl = json["iconURL"];
    }
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["lastActiveDate"] is String) {
      lastActiveDate = json["lastActiveDate"];
    }
    pageId = json["pageId"];
    objectiveId = json["objectiveId"];
    type = json["type"];
    if (json["personal"] is bool) {
      personal = json["personal"];
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
    _data["id"] = id;
    _data["name"] = name;
    _data["iconURL"] = iconUrl;
    _data["count"] = count;
    _data["lastActiveDate"] = lastActiveDate;
    _data["pageId"] = pageId;
    _data["objectiveId"] = objectiveId;
    _data["type"] = type;
    _data["personal"] = personal;
    return _data;
  }
}
