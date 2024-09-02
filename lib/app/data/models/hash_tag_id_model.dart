class HashTagIdModel {
  int? status;
  String? message;
  List<Data>? data;

  HashTagIdModel({this.status, this.message, this.data});

  HashTagIdModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  dynamic createdBy;
  String? createdDate;
  String? createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? title;
  String? detail;
  String? coverPageUrl;
  String? hashTag;
  bool? isClose;
  bool? isPin;
  String? s3CoverPageUrl;
  int? ordering;
  dynamic startDateTime;
  dynamic endDateTime;

  Data(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.title,
      this.detail,
      this.coverPageUrl,
      this.hashTag,
      this.isClose,
      this.isPin,
      this.s3CoverPageUrl,
      this.ordering,
      this.startDateTime,
      this.endDateTime});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["coverPageURL"] is String) {
      coverPageUrl = json["coverPageURL"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    if (json["isClose"] is bool) {
      isClose = json["isClose"];
    }
    if (json["isPin"] is bool) {
      isPin = json["isPin"];
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
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["coverPageURL"] = coverPageUrl;
    _data["hashTag"] = hashTag;
    _data["isClose"] = isClose;
    _data["isPin"] = isPin;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["ordering"] = ordering;
    _data["startDateTime"] = startDateTime;
    _data["endDateTime"] = endDateTime;
    return _data;
  }
}
