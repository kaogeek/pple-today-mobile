class SendOtpModel {
  int? status;
  String? message;
  int? data;

  SendOtpModel({this.status, this.message, this.data});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? 3;
    message = json["message"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    _data["data"] = data;
    return _data;
  }

  void clear() {
    status = 3;
    message = '';
    data = 0;
  }
}
