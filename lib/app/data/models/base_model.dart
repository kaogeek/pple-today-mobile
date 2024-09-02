class BaseModel {
  int? status;
  String? message;
  String? data;

  BaseModel({this.status, this.message, this.data});

  BaseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is String) {
      data = json["data"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    _data["data"] = data;
    return _data;
  }
}
