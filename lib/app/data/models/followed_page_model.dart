class FollowedModel {
  int? status;
  String? message;
  Data? data;

  FollowedModel({this.status, this.message, this.data});

  FollowedModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }

  void clear() {
    status = 0;
    message = '';
    data = null;
  }
}

class Data {
  String? id;
  String? userId;
  String? subjectId;
  String? subjectType;
  bool? isFollow;
  int? followers;

  Data({this.id, this.userId, this.subjectId, this.subjectType, this.isFollow, this.followers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    subjectId = json["subjectId"];
    subjectType = json["subjectType"];
    isFollow = json["isFollow"];
    followers = json["followers"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["userId"] = userId;
    data["subjectId"] = subjectId;
    data["subjectType"] = subjectType;
    data["isFollow"] = isFollow;
    data["followers"] = followers;
    return data;
  }
}
