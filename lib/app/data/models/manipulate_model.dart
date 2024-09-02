class ManipulateModel {
  int? status;
  String? message;
  List<Data>? data;

  ManipulateModel({this.status, this.message, this.data});

  ManipulateModel.fromJson(Map<String, dynamic> json) {
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

  void clear() {
    status = 4;
    message = '';
    data = [];
  }
}

class Data {
  String? id;
  String? type;
  String? detail;

  Data({this.id, this.type, this.detail});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["type"] = type;
    _data["detail"] = detail;
    return _data;
  }
}
