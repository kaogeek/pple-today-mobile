import '../../component/convert_image_component.dart';

class ReadNotificationModel {
  int? status;
  String? message;
  Data? data;

  ReadNotificationModel({this.status, this.message, this.data});

  ReadNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
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
}

class Data {
  Sender? sender;
  Notification? notification;

  Data({this.sender, this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    sender = json["sender"] == null ? null : Sender.fromJson(json["sender"]);
    notification = json["notification"] == null ? null : Notification.fromJson(json["notification"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (sender != null) {
      _data["sender"] = sender?.toJson();
    }
    if (notification != null) {
      _data["notification"] = notification?.toJson();
    }
    return _data;
  }
}

class Notification {
  dynamic createdBy;
  String? createdDate;
  dynamic createdTime;
  dynamic createdByUsername;
  dynamic updateDate;
  dynamic updateByUsername;
  String? id;
  String? title;
  String? fromUser;
  String? toUser;
  bool? isRead;
  String? toUserType;
  String? fromUserType;
  String? link;
  dynamic type;
  bool? deleted;
  String? data;

  Notification(
      {this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.id,
      this.title,
      this.fromUser,
      this.toUser,
      this.isRead,
      this.toUserType,
      this.fromUserType,
      this.link,
      this.type,
      this.deleted,
      this.data});

  Notification.fromJson(Map<String, dynamic> json) {
    createdBy = json["createdBy"];
    createdDate = json["createdDate"];
    createdTime = json["createdTime"];
    createdByUsername = json["createdByUsername"];
    updateDate = json["updateDate"];
    updateByUsername = json["updateByUsername"];
    id = json["id"];
    title = json["title"];
    fromUser = json["fromUser"];
    toUser = json["toUser"];
    isRead = json["isRead"];
    toUserType = json["toUserType"];
    fromUserType = json["fromUserType"];
    link = json["link"];
    type = json["type"];
    deleted = json["deleted"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["id"] = id;
    _data["title"] = title;
    _data["fromUser"] = fromUser;
    _data["toUser"] = toUser;
    _data["isRead"] = isRead;
    _data["toUserType"] = toUserType;
    _data["fromUserType"] = fromUserType;
    _data["link"] = link;
    _data["type"] = type;
    _data["deleted"] = deleted;
    _data["data"] = data;
    return _data;
  }
}

class Sender {
  String? id;
  String? displayName;
  String? uniqueId;
  String? type;
  String? imageUrl;

  Sender({
    this.id,
    this.displayName,
    this.uniqueId,
    this.type,
    this.imageUrl,
  });

  Sender.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    displayName = json["displayName"];
    uniqueId = json["uniqueId"];
    type = json["type"];
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["coverSignURL"] ?? '').toString().startsWith('http')
            ? json["coverSignURL"]
            : (json["imageURL"] ?? '').toString().isNotEmpty
                ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
                : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["displayName"] = displayName;
    _data["uniqueId"] = uniqueId;
    _data["type"] = type;
    _data["imageURL"] = imageUrl;
    return _data;
  }
}
