class ForgotPassModel {
  int? status;
  String? message;
  String? data;

  ForgotPassModel({this.status, this.message, this.data});

  ForgotPassModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? 0;
    message = json["message"] == 'Invalid Username'
        ? 'ไม่พบอีเมลนี้ในระบบ'
        : json["message"] == 'Your Activation Code has been sent to your email inbox.'
            ? 'ระบบได้ส่งรหัส OTP ไปยังอีเมลของท่านแล้ว กรุณาตรวจสอบอีเมลของท่าน'
            : json["message"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    data["data"] = this.data;
    return data;
  }

  void clear() {
    status = 0;
    message = '';
    data = '';
  }
}
