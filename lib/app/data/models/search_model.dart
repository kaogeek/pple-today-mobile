class SearchModel {
  int? status;
  String? message;
  Data? data;

  SearchModel({this.status, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data {
  List<Result>? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    result = json["result"] == null
        ? null
        : (json["result"] as List).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data["result"] = result?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? historyId;
  String? id;
  String? label;
  String? type;
  int? count;

  Result({this.historyId, this.id, this.label, this.type, this.count});

  Result.fromJson(Map<String, dynamic> json) {
    historyId = json["historyId"];
    id = json["value"];
    label = json["label"];
    type = json["type"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["historyId"] = historyId;
    data["value"] = id;
    data["label"] = label;
    data["type"] = type;
    data["count"] = count;
    return data;
  }
}
