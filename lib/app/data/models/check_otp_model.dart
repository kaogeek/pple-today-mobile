class CheckOtpModel {
  int? status;
  String? message;
  String? data;
  String? authUser;

  CheckOtpModel({
    this.status,
    this.message,
    this.data,
    this.authUser,
  });

  CheckOtpModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? 3;
    message = json["message"];
    data = json["data"];
    authUser = json["authUser"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    _data["data"] = data;
    _data["authUser"] = authUser;
    return _data;
  }

  void clear() {
    status = 3;
    message = '';
    data = '';
    authUser = '';
  }
}
