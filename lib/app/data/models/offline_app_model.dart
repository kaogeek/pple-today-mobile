class OfflineAppModel {
  bool? isOffineApp;
  Mata? mata;

  OfflineAppModel({this.isOffineApp, this.mata});

  OfflineAppModel.fromJson(Map<String, dynamic> json) {
    isOffineApp = json["isOffineApp"] ?? false;
    mata = json["mata"] == null ? null : Mata.fromJson(json["mata"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["isOffineApp"] = isOffineApp;
    if (mata != null) {
      _data["mata"] = mata?.toJson();
    }
    return _data;
  }
}

class Mata {
  String? title;
  String? message;
  String? button;

  Mata({this.title, this.message, this.button});

  Mata.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    message = json["message"];
    button = json["button"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["message"] = message;
    _data["button"] = button;
    return _data;
  }
}
