import '../../component/convert_image_component.dart';

class VoteMyCreateModel {
  int? status;
  String? message;
  Data? data;
  int? count;

  VoteMyCreateModel({this.status, this.message, this.data, this.count});

  VoteMyCreateModel.fromJson(Map<String, dynamic> json) {
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
  List<MyVote>? myVote;
  List<MyVoterSupport>? myVoterSupport;
  List<MyVoted>? myVoted;
  List<MySupported>? mySupported;

  Data({this.myVote, this.myVoterSupport, this.myVoted, this.mySupported});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["myVote"] is List) {
      myVote = json["myVote"] == null ? null : (json["myVote"] as List).map((e) => MyVote.fromJson(e)).toList();
    }
    if (json["myVoterSupport"] is List) {
      myVoterSupport = json["myVoterSupport"] == null ? null : (json["myVoterSupport"] as List).map((e) => MyVoterSupport.fromJson(e)).toList();
    }
    if (json["myVoted"] is List) {
      myVoted = json["myVoted"] == null ? null : (json["myVoted"] as List).map((e) => MyVoted.fromJson(e)).toList();
    }
    if (json["mySupported"] is List) {
      mySupported = json["mySupported"] == null ? null : (json["mySupported"] as List).map((e) => MySupported.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (myVote != null) {
      _data["myVote"] = myVote?.map((e) => e.toJson()).toList();
    }
    if (myVoterSupport != null) {
      _data["myVoterSupport"] = myVoterSupport?.map((e) => e.toJson()).toList();
    }
    if (myVoted != null) {
      _data["myVoted"] = myVoted?.map((e) => e.toJson()).toList();
    }
    // if (mySupported != null) {
    //   _data["mySupported"] = mySupported?.map((e) => e.toJson()).toList();
    // }
    return _data;
  }
}

class MySupported {
  String? id;
  String? createdDate;
  String? title;
  dynamic detail;
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
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  User? user;
  Page? page;
  VotingEvent? votingEvent;
  bool? userSupport;

  MySupported(
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
      this.user,
      this.page,
      this.votingEvent,
      this.userSupport});

  MySupported.fromJson(Map<String, dynamic> json) {
    if (json["votingEvent"]["_id"] is String) {
      id = json["votingEvent"]["_id"];
    }
    if (json["votingEvent"]["createdDate"] is String) {
      createdDate = json["votingEvent"]["createdDate"];
    }
    if (json["votingEvent"]["title"] is String) {
      title = json["votingEvent"]["title"];
    }
    detail = json["votingEvent"]["detail"];
    if (json["votingEvent"]["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["votingEvent"]["coverPageURL"]);
    }
    if (json["votingEvent"]["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["votingEvent"]["s3CoverPageURL"];
    }
    if (json["votingEvent"]["userId"] is String) {
      userId = json["votingEvent"]["userId"];
    }
    if (json["votingEvent"]["approved"] is bool) {
      approved = json["votingEvent"]["approved"];
    }
    if (json["votingEvent"]["closed"] is bool) {
      closed = json["votingEvent"]["closed"];
    }
    if (json["votingEvent"]["minSupport"] is int) {
      minSupport = json["votingEvent"]["minSupport"];
    }
    if (json["votingEvent"]["countSupport"] is int) {
      countSupport = json["votingEvent"]["countSupport"];
    }
    if (json["votingEvent"]["voteDaysRange"] is int) {
      voteDaysRange = json["votingEvent"]["voteDaysRange"];
    }
    if (json["votingEvent"]["startVoteDatetime"] is String) {
      startVoteDatetime = json["votingEvent"]["startVoteDatetime"];
    }
    if (json["votingEvent"]["endVoteDatetime"] is String) {
      endVoteDatetime = json["votingEvent"]["endVoteDatetime"];
    }
    if (json["votingEvent"]["supportDaysRange"] is int) {
      supportDaysRange = json["votingEvent"]["supportDaysRange"];
    }
    if (json["votingEvent"]["startSupportDatetime"] is String) {
      startSupportDatetime = json["votingEvent"]["startSupportDatetime"];
    }
    if (json["votingEvent"]["endSupportDatetime"] is String) {
      endSupportDatetime = json["votingEvent"]["endSupportDatetime"];
    }
    closeDate = json["votingEvent"]["closeDate"];
    if (json["votingEvent"]["status"] is String) {
      status = json["votingEvent"]["status"];
    }
    if (json["votingEvent"]["type"] is String) {
      type = json["votingEvent"]["type"];
    }
    if (json["votingEvent"]["hashTag"] is String) {
      hashTag = json["votingEvent"]["hashTag"];
    }
    if (json["votingEvent"]["pin"] is bool) {
      pin = json["votingEvent"]["pin"];
    }
    if (json["votingEvent"]["showVoterName"] is bool) {
      showVoterName = json["votingEvent"]["showVoterName"];
    }
    if (json["votingEvent"]["showVoteResult"] is bool) {
      showVoteResult = json["votingEvent"]["showVoteResult"];
    }
    service = json["votingEvent"]["service"];
    if (json["votingEvent"]["user"] is Map) {
      user = json["votingEvent"]["user"] == null ? null : User.fromJson(json["votingEvent"]["user"]);
    }
    if (json["votingEvent"]["page"] is Map) {
      page = json["votingEvent"]["page"] == null ? null : Page.fromJson(json["votingEvent"]["page"]);
    }
    if (json["votingEvent"] is Map) {
      votingEvent = json["votingEvent"] == null ? null : VotingEvent.fromJson(json["votingEvent"]);
    }
    if (json["votingEvent"]["userSupport"] is bool) {
      userSupport = json["votingEvent"]["userSupport"];
    }
  }
  /* String? id;
  dynamic createdBy;
  String? createdDate;
  String? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? userId;
  String? votingId;
  User? user;
  Page? page;
  VotingEvent? votingEvent;

  MySupported(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.userId,
      this.votingId,
      this.user,
      this.page,
      this.votingEvent});

  MySupported.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
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
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["votingId"] is String) {
      votingId = json["votingId"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
    }
    if (json["votingEvent"] is Map) {
      votingEvent = json["votingEvent"] == null ? null : VotingEvent.fromJson(json["votingEvent"]);
    }
  } */

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["votingEvent"]["_id"] = id;
    _data["votingEvent"]["createdDate"] = createdDate;
    _data["votingEvent"]["title"] = title;
    _data["votingEvent"]["detail"] = detail;
    _data["votingEvent"]["coverPageURL"] = voteImage;
    _data["votingEvent"]["s3CoverPageURL"] = s3CoverPageUrl;
    _data["votingEvent"]["userId"] = userId;
    _data["votingEvent"]["approved"] = approved;
    _data["votingEvent"]["closed"] = closed;
    _data["votingEvent"]["minSupport"] = minSupport;
    _data["votingEvent"]["countSupport"] = countSupport;
    _data["votingEvent"]["startVoteDatetime"] = startVoteDatetime;
    _data["votingEvent"]["endVoteDatetime"] = endVoteDatetime;
    _data["votingEvent"]["supportDaysRange"] = supportDaysRange;
    _data["votingEvent"]["closeDate"] = closeDate;
    _data["votingEvent"]["status"] = status;
    _data["votingEvent"]["type"] = type;
    _data["votingEvent"]["hashTag"] = hashTag;
    _data["votingEvent"]["pin"] = pin;
    _data["votingEvent"]["showVoterName"] = showVoterName;
    _data["votingEvent"]["showVoteResult"] = showVoteResult;
    _data["votingEvent"]["service"] = service;
    if (user != null) {
      _data["votingEvent"]["user"] = user?.toJson();
    }
    if (page != null) {
      _data["votingEvent"]["page"] = page?.toJson();
    }
    if (votingEvent != null) {
      _data["votingEvent"] = votingEvent?.toJson();
    }
    return _data;
  }

  /*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["userId"] = userId;
    _data["votingId"] = votingId;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    if (votingEvent != null) {
      _data["votingEvent"] = votingEvent?.toJson();
    }
    return _data;
  } */
}

class MyVoted {
  String? id;
  String? createdDate;
  String? title;
  dynamic detail;
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
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  User? user;
  Page? page;
  VotingEvent? votingEvent;
  bool? userSupport;

  MyVoted(
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
      this.user,
      this.page,
      this.votingEvent,
      this.userSupport});

  MyVoted.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["votingEvent"]["createdDate"] is String) {
      createdDate = json["votingEvent"]["createdDate"];
    }
    if (json["votingEvent"]["title"] is String) {
      title = json["votingEvent"]["title"];
    }
    detail = json["votingEvent"]["detail"];
    if (json["votingEvent"]["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["votingEvent"]["coverPageURL"]);
    }
    if (json["votingEvent"]["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["votingEvent"]["s3CoverPageURL"];
    }
    if (json["votingEvent"]["userId"] is String) {
      userId = json["votingEvent"]["userId"];
    }
    if (json["votingEvent"]["approved"] is bool) {
      approved = json["votingEvent"]["approved"];
    }
    if (json["votingEvent"]["closed"] is bool) {
      closed = json["votingEvent"]["closed"];
    }
    if (json["votingEvent"]["minSupport"] is int) {
      minSupport = json["votingEvent"]["minSupport"];
    }
    if (json["votingEvent"]["countSupport"] is int) {
      countSupport = json["votingEvent"]["countSupport"];
    }
    if (json["votingEvent"]["voteDaysRange"] is int) {
      voteDaysRange = json["votingEvent"]["voteDaysRange"];
    }
    if (json["votingEvent"]["startVoteDatetime"] is String) {
      startVoteDatetime = json["votingEvent"]["startVoteDatetime"];
    }
    if (json["votingEvent"]["endVoteDatetime"] is String) {
      endVoteDatetime = json["votingEvent"]["endVoteDatetime"];
    }
    if (json["votingEvent"]["supportDaysRange"] is int) {
      supportDaysRange = json["votingEvent"]["supportDaysRange"];
    }
    if (json["votingEvent"]["startSupportDatetime"] is String) {
      startSupportDatetime = json["votingEvent"]["startSupportDatetime"];
    }
    if (json["votingEvent"]["endSupportDatetime"] is String) {
      endSupportDatetime = json["votingEvent"]["endSupportDatetime"];
    }
    closeDate = json["votingEvent"]["closeDate"];
    if (json["votingEvent"]["status"] is String) {
      status = json["votingEvent"]["status"];
    }
    if (json["votingEvent"]["type"] is String) {
      type = json["votingEvent"]["type"];
    }
    if (json["votingEvent"]["hashTag"] is String) {
      hashTag = json["votingEvent"]["hashTag"];
    }
    if (json["votingEvent"]["pin"] is bool) {
      pin = json["votingEvent"]["pin"];
    }
    if (json["votingEvent"]["showVoterName"] is bool) {
      showVoterName = json["votingEvent"]["showVoterName"];
    }
    if (json["votingEvent"]["showVoteResult"] is bool) {
      showVoteResult = json["votingEvent"]["showVoteResult"];
    }
    service = json["votingEvent"]["service"];
    if (json["votingEvent"]["user"] is Map) {
      user = json["votingEvent"]["user"] == null ? null : User.fromJson(json["votingEvent"]["user"]);
    }
    if (json["votingEvent"]["page"] is Map) {
      page = json["votingEvent"]["page"] == null ? null : Page.fromJson(json["votingEvent"]["page"]);
    }
    if (json["votingEvent"] is Map) {
      votingEvent = json["votingEvent"] == null ? null : VotingEvent.fromJson(json["votingEvent"]);
    }
    if (json["votingEvent"]["userSupport"] is bool) {
      userSupport = json["votingEvent"]["userSupport"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    if (votingEvent != null) {
      _data["votingEvent"] = votingEvent?.toJson();
    }
    return _data;
  }
}

class VotingEvent {
  String? id;
  String? createdDate;
  String? title;
  dynamic detail;
  String? voteImage;
  String? imageUrl;
  String? s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  String? startVoteDatetime;
  String? endVoteDatetime;
  int? supportDaysRange;
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  User? user;
  Page? page;

  VotingEvent(
      {this.id,
      this.createdDate,
      this.title,
      this.detail,
      this.voteImage,
      this.imageUrl,
      this.s3CoverPageUrl,
      this.userId,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.startVoteDatetime,
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
      this.user,
      this.page});

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
    detail = json["detail"];
    if (json["coverPageURL"] is String) {
      voteImage = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["coverPageURL"] is String) {
      imageUrl = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
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
    if (json["endVoteDatetime"] is String) {
      endVoteDatetime = json["endVoteDatetime"];
    }
    if (json["supportDaysRange"] is int) {
      supportDaysRange = json["supportDaysRange"];
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
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["page"] is Map) {
      page = json["page"] == null ? null : Page.fromJson(json["page"]);
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
    if (page != null) {
      _data["page"] = page?.toJson();
    }
    return _data;
  }
}

class MyVoterSupport {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? voteImage;
  dynamic s3CoverPageUrl;
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
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  User? user;
  Page? page;
  bool? userSupport;

  MyVoterSupport(
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
      this.user,
      this.page,
      this.userSupport});

  MyVoterSupport.fromJson(Map<String, dynamic> json) {
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
      user = json["user"] == null ? null : User.fromJson(json["user"]);
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

class MyVote {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? voteImage;
  dynamic s3CoverPageUrl;
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
  dynamic closeDate;
  String? status;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  dynamic service;
  User? user;
  Page? page;
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
      this.user,
      this.page,
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
      user = json["user"] == null ? null : User.fromJson(json["user"]);
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

class Page {
  String? id;
  String? name;
  String? pageUsername;
  String? imageUrl;
  bool? isOfficial;
  bool? banned;

  Page({this.id, this.name, this.pageUsername, this.imageUrl, this.isOfficial, this.banned});

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
    isOfficial = json["isOfficial"] ?? false;
    banned = json["banned"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["pageUsername"] = pageUsername;
    _data["imageURL"] = imageUrl;
    _data["isOfficial"] = isOfficial;
    _data["banned"] = banned;
    return _data;
  }
}

class User {
  String? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? imageUrl;

  User({this.id, this.email, this.name, this.firstName, this.lastName, this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["username"] = name;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["imageURL"] = imageUrl;
    return _data;
  }
}
