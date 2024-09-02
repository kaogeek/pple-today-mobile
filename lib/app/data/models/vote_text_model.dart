import '../../component/convert_image_component.dart';

class VoteTextModel {
  int? status;
  String? message;
  List<Data>? data;

  VoteTextModel({this.status, this.message, this.data});

  VoteTextModel.fromJson(Map<String, dynamic> json) {
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
}

class Data {
  String? id;
  String? createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  String? votingId;
  String? userId;
  String? pageId;
  String? answer;
  String? voteItemId;
  String? voteChoiceId;
  User? user;

  Data(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.votingId,
      this.userId,
      this.pageId,
      this.answer,
      this.voteItemId,
      this.voteChoiceId,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
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
    if (json["votingId"] is String) {
      votingId = json["votingId"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["pageId"] is String) {
      pageId = json["pageId"];
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
    _data["votingId"] = votingId;
    _data["userId"] = userId;
    _data["pageId"] = pageId;
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
  String? firstName;
  String? lastName;
  String? displayName;
  String? uniqueId;
  String? imageUrl;
  String? s3ImageUrl;

  User({this.id, this.firstName, this.lastName, this.displayName, this.uniqueId, this.imageUrl, this.s3ImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    if (json["displayName"] is String) {
      displayName = json["displayName"];
    }
    if (json["uniqueId"] is String) {
      uniqueId = json["uniqueId"];
    }
    if (json["imageURL"] is String) {
      imageUrl = json["imageURL"].isEmpty
          ? 'https://stbbankstown.syd.catholic.edu.au/wp-content/uploads/sites/130/2019/05/Person-icon.jpg'
          : ConvertImageComponent.getImages(imageURL: (json["imageURL"] as String));
    }
    if (json["s3ImageURL"] is String) {
      s3ImageUrl = json["s3ImageURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["displayName"] = displayName;
    _data["uniqueId"] = uniqueId;
    _data["imageURL"] = imageUrl;
    _data["s3ImageURL"] = s3ImageUrl;
    return _data;
  }
}
