class FileTempModel {
  int? status;
  String? message;
  Data? data;

  FileTempModel({this.status, this.message, this.data});

  FileTempModel.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
  String? createdTime;
  String? id;
  String? s3FilePath;
  String? userId;
  String? fileName;
  int? scope;
  String? mimeType;
  int? size;
  String? expirationDate;
  String? data;

  Data(
      {this.createdDate,
      this.createdTime,
      this.id,
      this.s3FilePath,
      this.userId,
      this.fileName,
      this.scope,
      this.mimeType,
      this.size,
      this.expirationDate,
      this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["s3FilePath"] is String) {
      s3FilePath = json["s3FilePath"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["fileName"] is String) {
      fileName = json["fileName"];
    }
    if (json["scope"] is int) {
      scope = json["scope"];
    }
    if (json["mimeType"] is String) {
      mimeType = json["mimeType"];
    }
    if (json["size"] is int) {
      size = json["size"];
    }
    if (json["expirationDate"] is String) {
      expirationDate = json["expirationDate"];
    }
    if (json["data"] is String) {
      data = json["data"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["id"] = id;
    _data["s3FilePath"] = s3FilePath;
    _data["userId"] = userId;
    _data["fileName"] = fileName;
    _data["scope"] = scope;
    _data["mimeType"] = mimeType;
    _data["size"] = size;
    _data["expirationDate"] = expirationDate;
    _data["data"] = data;
    return _data;
  }
}
