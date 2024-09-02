import '../../component/convert_image_component.dart';
import '../../ui/utils/enum.dart';

class VoteChoiceModel {
  int? status;
  String? message;
  Data? data;

  VoteChoiceModel({this.status, this.message, this.data});

  VoteChoiceModel.fromJson(Map<String, dynamic> json) {
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
}

class Data {
  List<VoteItem>? voteItem;
  List<Voted1>? voted;
  int? voteCount;
  bool? showVoterName;
  bool? showVoteResult;

  Data({this.voteItem, this.voted, this.voteCount, this.showVoterName, this.showVoteResult});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["voteItem"] is List) {
      voteItem = json["voteItem"] == null ? null : (json["voteItem"] as List).map((e) => VoteItem.fromJson(e)).toList();
    }
    if (json["voted"] is List) {
      voted = json["voted"] == null ? null : (json["voted"] as List).map((e) => Voted1.fromJson(e)).toList();
    }
    if (json["voteCount"] is int) {
      voteCount = json["voteCount"];
    }
    showVoterName = json["showVoterName"] ?? false;
    showVoteResult = json["showVoteResult"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (voteItem != null) {
      _data["voteItem"] = voteItem?.map((e) => e.toJson()).toList();
    }
    if (voted != null) {
      _data["voted"] = voted?.map((e) => e.toJson()).toList();
    }
    _data["voteCount"] = voteCount ?? 0;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    return _data;
  }
}

class Voted1 {
  String? id;
  User? user;
  int? votedCount;

  Voted1({this.id, this.user});

  Voted1.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    votedCount = json["votedCount"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["votedCount"] = votedCount;
    return _data;
  }
}

class User {
  String? id;
  String? displayName;
  String? uniqueId;
  String? imageUrl;
  String? s3ImageUrl;

  User({this.id, this.displayName, this.uniqueId, this.imageUrl, this.s3ImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["displayName"] is String) {
      displayName = json["displayName"];
    }
    if (json["uniqueId"] is String) {
      uniqueId = json["uniqueId"];
    }
    if (json["imageURL"] is String) {
      imageUrl = ConvertImageComponent.getImages(imageURL: (json["imageURL"] as String));
    }
    if (json["s3ImageURL"] is String) {
      s3ImageUrl = json["s3ImageURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["displayName"] = displayName;
    _data["uniqueId"] = uniqueId;
    _data["imageURL"] = imageUrl;
    _data["s3ImageURL"] = s3ImageUrl;
    return _data;
  }
}

class Voted {
  int? votedCount;

  Voted({this.votedCount});

  Voted.fromJson(Map<String, dynamic> json) {
    if (json["votedCount"] is int) {
      votedCount = json["votedCount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["votedCount"] = votedCount;
    return _data;
  }
}

class VoteItem {
  String? id;
  String? createdDate;
  String? createdTime;
  String? votingId;
  String? assetId;
  int? ordering;
  VoteChoiceType? type;
  String? title;
  String? image;
  String? s3CoverPageUrl;
  String? checkType;
  int? votedCount;
  List<VoteChoice>? voteChoice;

  VoteItem(
      {this.id,
      this.createdDate,
      this.createdTime,
      this.votingId,
      this.assetId,
      this.ordering,
      this.type,
      this.title,
      this.image,
      this.s3CoverPageUrl,
      this.checkType,
      this.votedCount,
      this.voteChoice});

  VoteItem.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["votingId"] is String) {
      votingId = json["votingId"];
    }
    if (json["assetId"] is String) {
      assetId = json["assetId"];
    }
    if (json["ordering"] is int) {
      ordering = json["ordering"];
    }
    if (json["type"] is String) {
      type = json["type"] == 'multi'
          ? VoteChoiceType.multi
          : json["type"] == 'single'
              ? VoteChoiceType.single
              : VoteChoiceType.text;
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["coverPageURL"] is String) {
      image = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["checkType"] is String) {
      checkType = json["checkType"];
    }
    if (json["voted"] is List) {
      votedCount = (json["voted"] as List).isEmpty ? 0 : (json["voted"] as List).first["votedCount"] ?? 0;
    }
    // if (json["voted"] is List) {
    //   votedCount = json["voted"] == null ? null : (json["voted"] as List).map((e) => Voted1.fromJson(e)).toList().first.votedCount;
    // }
    voteChoice = json["voteChoice"] == null ? [] : (json["voteChoice"] as List).map((e) => VoteChoice.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["votingId"] = votingId;
    _data["assetId"] = assetId;
    _data["ordering"] = ordering;
    _data["type"] = type;
    _data["title"] = title;
    _data["coverPageURL"] = image;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["checkType"] = checkType;
    _data["votedCount"] = votedCount;
    if (voteChoice != null) {
      _data["voteChoice"] = voteChoice?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class VoteChoice {
  String? id;
  String? createdBy;
  String? createdDate;
  String? createdTime;
  String? createdByUsername;
  String? updateDate;
  String? updateByUsername;
  String? voteItemId;
  String? image;
  String? s3CoverPageUrl;
  String? title;
  String? assetId;
  int? votedCount;
  bool? isSelect;

  VoteChoice(
      {this.id,
      this.createdBy,
      this.createdDate,
      this.createdTime,
      this.createdByUsername,
      this.updateDate,
      this.updateByUsername,
      this.voteItemId,
      this.image,
      this.s3CoverPageUrl,
      this.title,
      this.assetId,
      this.votedCount,
      this.isSelect});

  VoteChoice.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["createdTime"] is String) {
      createdTime = json["createdTime"];
    }
    if (json["createdByUsername"] is String) {
      createdByUsername = json["createdByUsername"];
    }
    if (json["updateDate"] is String) {
      updateDate = json["updateDate"];
    }
    if (json["updateByUsername"] is String) {
      updateByUsername = json["updateByUsername"];
    }
    if (json["voteItemId"] is String) {
      voteItemId = json["voteItemId"];
    }
    if (json["coverPageURL"] is String) {
      image = ConvertImageComponent.getImages(imageURL: json["coverPageURL"]);
    }
    if (json["s3coverPageURL"] is String) {
      s3CoverPageUrl = json["s3coverPageURL"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["assetId"] is String) {
      assetId = json["assetId"];
    }
    if (json["voted"] is List) {
      votedCount = (json["voted"] as List).isEmpty ? 0 : (json["voted"] as List).first["votedCount"] ?? 0;
    }
    isSelect = json["isSelect"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["createdBy"] = createdBy;
    _data["createdDate"] = createdDate;
    _data["createdTime"] = createdTime;
    _data["createdByUsername"] = createdByUsername;
    _data["updateDate"] = updateDate;
    _data["updateByUsername"] = updateByUsername;
    _data["voteItemId"] = voteItemId;
    _data["coverPageURL"] = image;
    _data["s3coverPageURL"] = s3CoverPageUrl;
    _data["title"] = title;
    _data["assetId"] = assetId;
    _data["votedCount"] = votedCount;
    _data["isSelect"] = isSelect;
    return _data;
  }
}
