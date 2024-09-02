import '../../component/convert_image_component.dart';

class VotePostModel {
  int? status;
  String? message;
  List<Data>? data;
  int? count;

  VotePostModel({this.status, this.message, this.data, this.count});

  VotePostModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
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
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["count"] = count;
    return _data;
  }
}

class Data {
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
  dynamic endVoteDatetime;
  String? approvedDatetime;
  String? startSupportDatetime;
  String? endSupportDatetime;
  String? closeDatetime;
  String? status;
  String? hashTag;
  String? type;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  String? service;
  List<Voted>? voted;
  User1? user;
  bool? userSupport;
  Page? page;

  Data(
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
      this.approvedDatetime,
      this.startSupportDatetime,
      this.endSupportDatetime,
      this.closeDatetime,
      this.status,
      this.hashTag,
      this.type,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.voted,
      this.user,
      this.userSupport,
      this.page});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
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
    endVoteDatetime = json["endVoteDatetime"];
    if (json["approvedDatetime"] is String) {
      approvedDatetime = json["approvedDatetime"];
    }
    if (json["startSupportDatetime"] is String) {
      startSupportDatetime = json["startSupportDatetime"];
    }
    if (json["endSupportDatetime"] is String) {
      endSupportDatetime = json["endSupportDatetime"];
    }
    if (json["closeDate"] is String) {
      closeDatetime = json["closeDate"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
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
    if (json["voted"] is List) {
      voted = json["voted"] == null ? null : (json["voted"] as List).map((e) => Voted.fromJson(e)).toList();
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    userSupport = json["userSupport"] ?? false;
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
    _data["approvedDate"] = approvedDatetime;
    _data["startSupportDatetime"] = startSupportDatetime;
    _data["endSupportDatetime"] = endSupportDatetime;
    _data["closeDate"] = closeDatetime;
    _data["status"] = status;
    _data["type"] = type;
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    if (voted != null) {
      _data["voted"] = voted?.map((e) => e.toJson()).toList();
    }
    _data["userSupport"] = userSupport;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
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

class User1 {
  String? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? imageUrl;

  User1({this.id, this.email, this.name, this.firstName, this.lastName, this.imageUrl});

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

class UserSupport {
  String? id;
  String? createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  // dynamic id;
  String? userId;
  String? votingId;

  UserSupport({this.id, this.createdBy, this.createdDate, this.createdTime, this.createdByUsername, this.updateDate, this.updateByUsername, this.userId, this.votingId});

  UserSupport.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdBy"] is String) {
      id = json["createdBy"];
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
    // id = json["id"];
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["votingId"] is String) {
      votingId = json["votingId"];
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
    // _data["id"] = id;
    _data["userId"] = userId;
    _data["votingId"] = votingId;
    return _data;
  }
}

class Voted {
  String? id;
  dynamic createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  // dynamic id;
  String? votingId;
  String? userId;
  String? answer;
  String? voteItemId;
  String? voteChoiceId;
  User? user;

  Voted(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      // this.id,
      this.votingId,
      this.userId,
      this.answer,
      this.voteItemId,
      this.voteChoiceId,
      this.user});

  Voted.fromJson(Map<String, dynamic> json) {
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
    if (json["createdByUsername"] is String) {
      createdByUsername = json["createdByUsername"];
    }
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    // id = json["id"];
    if (json["votingId"] is String) {
      votingId = json["votingId"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["answer"] is String) {
      answer = json["answer"];
    }
    if (json["voteItemId"] is String) {
      voteItemId = json["voteItemId"];
    }
    if (json["voteChoiceId"] is String) {
      voteChoiceId = json["voteChoiceId"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
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
    // _data["id"] = id;
    _data["votingId"] = votingId;
    _data["userId"] = userId;
    _data["answer"] = answer;
    _data["voteItemId"] = voteItemId;
    _data["voteChoiceId"] = voteChoiceId;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    return _data;
  }
}

class User {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? imageUrl;

  User({this.id, this.username, this.firstName, this.lastName, this.imageUrl});

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
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["imageURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
            : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["username"] = username;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["imageURL"] = imageUrl;
    return _data;
  }
}
