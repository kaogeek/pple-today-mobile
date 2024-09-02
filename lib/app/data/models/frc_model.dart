import 'package:get/get.dart';

class CheckVersionUpdateModel {
  bool? disabled;
  String? version;
  String? url;
  Mata? mata;

  CheckVersionUpdateModel({this.disabled, this.version, this.url, this.mata});

  CheckVersionUpdateModel.fromJson(Map<String, dynamic> json) {
    disabled = GetPlatform.isAndroid ? json["android"]["disabled"] : json["ios"]["disabled"];
    version = GetPlatform.isAndroid ? json["android"]["version"] : json["ios"]["version"];
    url = GetPlatform.isAndroid ? json["android"]["url"] : json["ios"]["url"];
    mata = json["mata"] == null ? null : Mata.fromJson(json["mata"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["disabled"] = disabled;
    _data["version"] = version;
    _data["url"] = url;
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
    title = json["title"].isEmpty ? null : json["title"];
    message = json["message"].isEmpty ? null : json["message"];
    button = json["button"].isEmpty ? null : json["button"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["message"] = message;
    _data["button"] = button;
    return _data;
  }
}
