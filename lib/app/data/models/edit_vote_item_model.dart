import 'dart:io';

import 'package:flutter/material.dart';

import '../../component/convert_image_component.dart';
import '../../ui/utils/enum.dart';

class EditVoteItemModel {
  String? id;
  String? title;
  String? detail;
  String? assetId;
  String? coverPageUrl;
  String? s3CoverPageUrl;
  File? file;
  int? voteDaysRange;
  String? type;
  String? hashTag;
  bool? showVoteName;
  bool? showVoteResult;
  String? service;
  List<VoteItem>? voteItem;
  User1? user;
  Page1? page;
  List<String>? delete;
  List<String>? deleteChoices;
  List<String>? oldPictures;

  EditVoteItemModel({
    this.id,
    this.title,
    this.detail,
    this.assetId,
    this.coverPageUrl,
    this.s3CoverPageUrl,
    this.file,
    this.voteDaysRange,
    this.type,
    this.hashTag,
    this.showVoteName,
    this.showVoteResult,
    this.service,
    this.voteItem,
    this.user,
    this.page,
    this.delete,
    this.deleteChoices,
    this.oldPictures,
  });

  EditVoteItemModel.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["assetId"] is String) {
      assetId = json["assetId"];
    }
    if (json["coverPageURL"] is String) {
      coverPageUrl = json["coverPageURL"] == "null" ? null : json["coverPageURL"];
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["voteDaysRange"] is int) {
      voteDaysRange = json["voteDaysRange"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    if (json["showVoterName"] is bool) {
      showVoteName = json["showVoterName"];
    }
    if (json["showVoteResult"] is bool) {
      showVoteResult = json["showVoteResult"];
    }
    if (json["service"] is String) {
      service = json["service"];
    }
    if (json["voteItem"] is List) {
      voteItem = json["voteItem"] == null ? null : (json["voteItem"] as List).map((e) => VoteItem.fromJson(e)).toList();
    }
    delete = [];
    deleteChoices = [];
    oldPictures = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["detail"] = detail;
    _data["assetId"] = assetId;
    _data["coverPageURL"] = coverPageUrl;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["voteDaysRange"] = voteDaysRange;
    _data["type"] = 'member';
    // _data["type"] = type;
    _data["hashTag"] = hashTag;
    _data["showVoterName"] = showVoteName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    if (voteItem != null) {
      _data["voteItem"] = voteItem?.map((e) => e.toJson()).toList();
    } else {
      _data["voteItem"] = [];
    }
    _data["delete"] = delete ?? [];
    _data["deleteChoices"] = deleteChoices ?? [];
    _data["oldPictures"] = [];
    return _data;
  }
}

class VoteItem {
  TextEditingController? controller;
  FocusNode? focusNode;
  String? id;
  String? createdDate;
  String? createdTime;
  String? votingId;
  String? assetId;
  int? ordering;
  String? typeChoice;
  VoteChoiceType? type;
  String? title;
  File? file;
  String? coverPageURL;
  String? s3CoverPageUrl;
  String? checkType;
  int? votedCount;
  List<VoteChoice>? voteChoice;

  VoteItem(
      {this.controller,
      this.focusNode,
      this.id,
      this.createdDate,
      this.createdTime,
      this.votingId,
      this.assetId,
      this.ordering,
      this.typeChoice,
      this.type,
      this.title,
      this.file,
      this.coverPageURL,
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
      coverPageURL = json["coverPageURL"];
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
    voteChoice = json["voteChoice"] == null ? [] : (json["voteChoice"] as List).map((e) => VoteChoice.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (id != null) {
      _data["_id"] = id;
    }
    if (createdDate != null) {
      _data["createdDate"] = createdDate;
    }
    if (createdTime != null) {
      _data["createdTime"] = createdTime;
    }
    if (votingId != null) {
      _data["votingId"] = votingId;
    }
    _data["ordering"] = ordering;
    _data["typeChoice"] = type == VoteChoiceType.multi
        ? 'multi'
        : type == VoteChoiceType.single
            ? 'single'
            : 'text';
    _data["type"] = type == VoteChoiceType.multi
        ? 'multi'
        : type == VoteChoiceType.single
            ? 'single'
            : 'text';
    _data["title"] = controller == null ? title : controller!.text.trim();
    _data["assetId"] = assetId;
    _data["coverPageURL"] = coverPageURL;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    if (checkType != null) {
      _data["checkType"] = checkType;
    }
    if (votedCount != null) {
      _data["votedCount"] = votedCount;
    }
    if (voteChoice != null) {
      _data["voteChoice"] = voteChoice?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class VoteChoice {
  TextEditingController? controller;
  FocusNode? focusNode;
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
      {this.controller,
      this.focusNode,
      this.id,
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
      image = json["coverPageURL"];
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
    if (id != null) {
      _data["_id"] = id;
    }
    if (createdBy != null) {
      _data["createdBy"] = createdBy;
    }
    if (createdDate != null) {
      _data["createdDate"] = createdDate;
    }
    if (createdTime != null) {
      _data["createdTime"] = createdTime;
    }
    if (createdByUsername != null) {
      _data["createdByUsername"] = createdByUsername;
    }
    if (updateDate != null) {
      _data["updateDate"] = updateDate;
    }
    if (updateByUsername != null) {
      _data["updateByUsername"] = updateByUsername;
    }
    if (voteItemId != null) {
      _data["voteItemId"] = voteItemId;
    }
    _data["coverPageURL"] = image;
    _data["s3coverPageURL"] = s3CoverPageUrl;
    _data["title"] = controller == null ? title : controller!.text.trim();
    _data["assetId"] = assetId;
    if (votedCount != null) {
      _data["votedCount"] = votedCount;
    }
    // _data["isSelect"] = isSelect;
    return _data;
  }
}

class User1 {
  String? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? imageUrl;

  User1({this.id, this.email, this.name, this.firstName, this.lastName, this.imageUrl});

  User1.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["username"] is String) {
      email = json["username"];
    }
    if (json["firstName"] is String) {
      name = json["firstName"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["imageURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
            : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["username"] = name;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["imageURL"] = imageUrl;
    return _data;
  }
}

class Page1 {
  String? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? pageUsername;
  String? imageUrl;
  // String? s3ImageURL;
  bool? isOfficial;
  bool? banned;

  Page1({
    this.id,
    this.email,
    this.name,
    this.firstName,
    this.lastName,
    this.pageUsername,
    this.imageUrl,
    // this.s3ImageURL,
    this.isOfficial,
    this.banned,
  });

  Page1.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["username"] is String) {
      email = json["username"];
    }
    if (json["firstName"] is String) {
      name = json["firstName"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    if (json["pageUsername"] is String) {
      pageUsername = json["pageUsername"];
    }
    imageUrl = (json["signURL"] ?? '').toString().startsWith('http')
        ? json["signURL"]
        : (json["imageURL"] ?? '').toString().isNotEmpty
            ? ConvertImageComponent.getImages(imageURL: json["imageURL"])
            : '';
    // if (json["s3ImageURL"] is String) {
    //   s3ImageURL = json["s3ImageURL"];
    // }
    if (json["isOfficial"] is bool) {
      isOfficial = json["isOfficial"];
    }
    if (json["banned"] is bool) {
      banned = json["banned"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["username"] = name;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["pageUsername"] = pageUsername;
    _data["imageURL"] = imageUrl;
    // _data["s3ImageURL"] = s3ImageURL;
    _data["isOfficial"] = isOfficial;
    _data["banned"] = banned;
    return _data;
  }
}
