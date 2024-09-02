import '../../component/convert_image_component.dart';

class VoteDetailModel {
  int? status;
  String? message;
  Data? data;

  VoteDetailModel({this.status, this.message, this.data});

  VoteDetailModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? id;
  String? createdDate;
  String? title;
  String? detail;
  String? coverPageUrl;
  String? s3CoverPageUrl;
  String? userId;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  int? voteDaysRange;
  String? startVoteDatetime;
  String? endVoteDatetime;
  String? supportDaysRange;
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
  Page? page;
  User1? user;
  bool? userSupport;

  Data(
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
      this.page,
      this.user,
      this.userSupport});

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
      coverPageUrl = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
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
    if (json["supportDaysRange"] is String) {
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
    _data["coverPageURL"] = coverPageUrl;
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
