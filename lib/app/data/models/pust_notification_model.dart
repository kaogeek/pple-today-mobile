class PustNotificationModel {
  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;

  PustNotificationModel({this.title, this.body, this.dataTitle, this.dataBody});

  PustNotificationModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    body = json["body"];
    dataTitle = json["dataTitle"];
    dataBody = json["dataBody"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["body"] = body;
    _data["dataTitle"] = dataTitle;
    _data["dataBody"] = dataBody;
    return _data;
  }
}
