import '../../component/convert_image_component.dart';

class HistorySearchModel {
  int? status;
  String? message;
  List<Data>? data;

  HistorySearchModel({this.status, this.message, this.data});

  HistorySearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (this.data != null) {
      data["data"] = this.data?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? value;
  String? label;
  String? imageUrl;
  String? uniqueId;
  String? type;
  String? createdDate;

  Data({
    this.value,
    this.label,
    this.imageUrl,
    this.uniqueId,
    this.type,
    this.createdDate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    value = json["value"];
    label = json["label"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    uniqueId = json["uniqueId"];
    type = json["type"];
    createdDate = json["createdDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["value"] = value;
    data["label"] = label;
    data["imageURL"] = imageUrl;
    data["uniqueId"] = uniqueId;
    data["type"] = type;
    data["createdDate"] = createdDate;
    return data;
  }
}
