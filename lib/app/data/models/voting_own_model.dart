class VotingOwnModel {
  int? status;
  String? message;
  List<Data>? data;

  VotingOwnModel({this.status, this.message, this.data});

  VotingOwnModel.fromJson(Map<String, dynamic> json) {
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
  dynamic createdBy;
  String? createdDate;
  String? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? id;
  String? votingId;
  String? userId;
  dynamic pageId;
  String? answer;
  String? voteItemId;
  String? voteChoiceId;

  Data(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.id,
      this.votingId,
      this.userId,
      this.pageId,
      this.answer,
      this.voteItemId,
      this.voteChoiceId});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json["votingId"] is String) {
      votingId = json["votingId"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    pageId = json["pageId"];
    if (json["answer"] is String) {
      answer = json["answer"];
    }
    if (json["voteItemId"] is String) {
      voteItemId = json["voteItemId"];
    }
    if (json["voteChoiceId"] is String) {
      voteChoiceId = json["voteChoiceId"];
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
    _data["votingId"] = votingId;
    _data["userId"] = userId;
    _data["pageId"] = pageId;
    _data["answer"] = answer;
    _data["voteItemId"] = voteItemId;
    _data["voteChoiceId"] = voteChoiceId;
    return _data;
  }
}
