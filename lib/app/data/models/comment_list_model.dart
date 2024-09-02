import '../../component/convert_image_component.dart';

class CommentListModel {
  int? status;
  String? message;
  List<Data>? data;

  CommentListModel({this.status, this.message, this.data});

  CommentListModel.fromJson(Map<String, dynamic> json) {
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
  String? comment;
  String? mediaUrl;
  String? post;
  User? user;
  int? likeCount;
  String? commentAsPage;
  DateTime? createdDate;
  String? id;
  bool? isLike;
  bool? likeAsPage;
  bool? readMore;

  Data(
      {this.comment,
      this.mediaUrl,
      this.post,
      this.user,
      this.likeCount,
      this.commentAsPage,
      this.createdDate,
      this.id,
      this.isLike,
      this.likeAsPage,
      this.readMore});

  Data.fromJson(Map<String, dynamic> json) {
    comment = json["comment"] ?? '';
    mediaUrl = json["mediaURL"];
    post = json["post"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    likeCount = json["likeCount"] ?? 0;
    commentAsPage = json["commentAsPage"];
    createdDate = DateTime.parse(json["createdDate"]);
    id = json["id"];
    isLike = json["isLike"] ?? false;
    likeAsPage = json["likeAsPage"];
    readMore = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["comment"] = comment;
    data["mediaURL"] = mediaUrl;
    data["post"] = post;
    if (user != null) data["user"] = user?.toJson();
    data["likeCount"] = likeCount;
    data["commentAsPage"] = commentAsPage;
    data["createdDate"] = createdDate;
    data["id"] = id;
    data["isLike"] = isLike;
    data["likeAsPage"] = likeAsPage;
    return data;
  }
}

class User {
  String? imageUrl;
  String? displayName;
  String? id;

  User({
    this.imageUrl,
    this.displayName,
    this.id,
  });

  User.fromJson(Map<String, dynamic> json) {
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
    displayName = json["displayName"] ?? '';
    id = json["id"] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["imageURL"] = imageUrl;
    data["displayName"] = displayName;
    data["id"] = id;
    return data;
  }
}
