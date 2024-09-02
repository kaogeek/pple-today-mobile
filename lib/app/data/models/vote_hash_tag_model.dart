class VoteHashTagModel {
  int? status;
  String? message;
  List<String>? data;

  VoteHashTagModel({this.status, this.message, this.data});

  VoteHashTagModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null ? null : List<String>.from(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data;
    }
    return _data;
  }
}
