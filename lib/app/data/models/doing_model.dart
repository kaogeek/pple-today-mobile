import '../../component/convert_image_component.dart';

class DoingModel {
  int? status;
  String? message;
  List<Data>? data;

  DoingModel({this.status, this.message, this.data});

  DoingModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? createdDate;
  String? pageId;
  String? title;
  String? iconUrl;
  String? hashTag;

  Data({this.id, this.createdDate, this.pageId, this.title, this.iconUrl, this.hashTag});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdDate = json["createdDate"];
    pageId = json["pageId"];
    title = json["title"];
    iconUrl = (json["iconSignURL"] ?? '').toString().startsWith('http')
        ? json["iconSignURL"]
        : (json["iconURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["iconURL"])
            : '';
    hashTag = json["hashTag"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["createdDate"] = createdDate;
    data["pageId"] = pageId;
    data["title"] = title;
    data["iconURL"] = iconUrl;
    data["hashTag"] = hashTag;
    return data;
  }
}
