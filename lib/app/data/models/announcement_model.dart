class AnnouncementModel {
  int? status;
  String? message;
  Data? data;

  AnnouncementModel({this.status, this.message, this.data});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
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

  void clear() {
    status = null;
    message = null;
    data = Data(
      link: '',
      name: '',
      value: '',
      type: '',
      offOn: false,
    );
  }
}

class Data {
  String? name;
  String? value;
  String? link;
  String? type;
  bool? offOn;

  Data({this.name, this.value, this.link, this.type, this.offOn});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String && json["name"] == "kaokaiToday.link.announcement.enable") {
      name = json["name"];

      if (json["value"] is String) {
        offOn = (json["value"] ?? "false") == "true";
      }
    }

    if (json["name"] is String && json["name"] == "kaokaiToday.announcement") {
      name = json["name"];

      if (json["value"] is String) {
        value = json["value"];
      }
    }

    if (json["name"] is String && json["name"] == "kaokaiToday.link.announcement") {
      name = json["name"];

      if (json["value"] is String) {
        link = json["value"];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["value"] = value;
    _data["type"] = type;
    return _data;
  }
}
