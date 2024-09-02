
class Base64Model {
  Asset? asset;

  Base64Model({this.asset});

  Base64Model.fromJson(Map<String, dynamic> json) {
    if(json["asset"] is Map) {
      asset = json["asset"] == null ? null : Asset.fromJson(json["asset"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(asset != null) {
      _data["asset"] = asset?.toJson();
    }
    return _data;
  }
}

class Asset {
  int? size;
  String? fileName;
  String? mimeType;
  String? data;

  Asset({this.size, this.fileName, this.mimeType, this.data});

  Asset.fromJson(Map<String, dynamic> json) {
    if(json["size"] is int) {
      size = json["size"];
    }
    if(json["fileName"] is String) {
      fileName = json["fileName"];
    }
    if(json["mimeType"] is String) {
      mimeType = json["mimeType"];
    }
    if(json["data"] is String) {
      data = json["data"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["size"] = size;
    _data["fileName"] = fileName;
    _data["mimeType"] = mimeType;
    _data["data"] = data;
    return _data;
  }
}