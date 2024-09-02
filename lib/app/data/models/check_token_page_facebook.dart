class CheckTokenPageFacebook {
  int? status;
  String? message;
  List<Data>? data;

  CheckTokenPageFacebook({this.status, this.message, this.data});

  CheckTokenPageFacebook.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  void clear() {
    status = null;
    message = null;
    data = null;
  }
}

class Data {
  String? pageId;
  String? facebookPageId;
  String? facebookPageName;
  bool? facebookTokenExpired;

  Data({
    this.pageId,
    this.facebookPageId,
    this.facebookPageName,
    this.facebookTokenExpired,
  });

  Data.fromJson(Map<String, dynamic> json) {
    pageId = json["pageId"];
    facebookPageId = json["facebookPageId"];
    facebookPageName = json["facebookPageName"];
    facebookTokenExpired = json["facebookTokenExpired"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pageId"] = pageId;
    _data["facebookPageId"] = facebookPageId;
    _data["facebookPageName"] = facebookPageName;
    _data["facebookTokenExpired"] = facebookTokenExpired;
    return _data;
  }
}
