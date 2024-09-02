import '../../component/convert_image_component.dart';

class ObjectiveDoingModel {
  int? status;
  String? message;
  List<Data>? data;

  ObjectiveDoingModel({this.status, this.message, this.data});

  ObjectiveDoingModel.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
  String? id;
  String? pageId;
  String? title;
  String? iconUrl;
  String? hashTag;
  String? s3IconUrl;
  String? iconSignUrl;

  Data(
      {this.createdDate,
      this.id,
      this.pageId,
      this.title,
      this.iconUrl,
      this.hashTag,
      this.s3IconUrl,
      this.iconSignUrl});

  Data.fromJson(Map<String, dynamic> json) {
    createdDate = json["createdDate"];
    id = json["id"] ?? json["_id"];
    pageId = json["pageId"];
    title = json["title"];
    iconUrl = (json["iconSignURL"] ?? '').toString().startsWith('http')
        ? json["iconSignURL"]
        : (json["iconURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["iconURL"])
            : '';
    hashTag = json["hashTag"];
    s3IconUrl = json["s3IconURL"];
    iconSignUrl = json["iconSignURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createdDate"] = createdDate;
    data["id"] = id;
    data["pageId"] = pageId;
    data["title"] = title;
    data["iconURL"] = iconUrl;
    data["hashTag"] = hashTag;
    data["s3IconURL"] = s3IconUrl;
    data["iconSignURL"] = iconSignUrl;
    return data;
  }
}
