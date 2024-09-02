import 'dart:io';

import 'package:flutter/material.dart';

class CreateItemModel {
  String? title;
  String? detail;
  String? assetId;
  String? coverPageUrl;
  String? s3CoverPageUrl;
  bool? approved;
  bool? closed;
  int? minSupport;
  int? countSupport;
  String? startVoteDatetime;
  String? endVoteDatetime;
  int? voteDaysRange;
  String? status;
  dynamic createAsPage;
  String? type;
  String? hashTag;
  bool? pin;
  bool? showVoterName;
  bool? showVoteResult;
  String? service;
  List<VoteItem>? voteItem;

  CreateItemModel(
      {this.title,
      this.detail,
      this.assetId,
      this.coverPageUrl,
      this.s3CoverPageUrl,
      this.approved,
      this.closed,
      this.minSupport,
      this.countSupport,
      this.startVoteDatetime,
      this.endVoteDatetime,
      this.voteDaysRange,
      this.status,
      this.createAsPage,
      this.type,
      this.hashTag,
      this.pin,
      this.showVoterName,
      this.showVoteResult,
      this.service,
      this.voteItem});

  CreateItemModel.fromJson(Map<String, dynamic> json) {
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
      coverPageUrl = json["coverPageURL"];
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
    if (json["approved"] is bool) {
      approved = json["approved"];
    }
    if (json["closed"] is bool) {
      closed = json["closed"];
    }
    if (json["minSupport"] is int) {
      minSupport = json["minSupport"];
    }
    if (json["countSupport"] is int) {
      countSupport = json["countSupport"];
    }
    if (json["startVoteDatetime"] is String) {
      startVoteDatetime = json["startVoteDatetime"];
    }
    if (json["endVoteDatetime"] is String) {
      endVoteDatetime = json["endVoteDatetime"];
    }
    if (json["voteDaysRange"] is int) {
      voteDaysRange = json["voteDaysRange"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    createAsPage = json["createAsPage"];
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["hashTag"] is String) {
      hashTag = json["hashTag"];
    }
    if (json["pin"] is bool) {
      pin = json["pin"];
    }
    if (json["showVoterName"] is bool) {
      showVoterName = json["showVoterName"];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["detail"] = detail;
    _data["assetId"] = assetId;
    _data["coverPageURL"] = coverPageUrl;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    _data["approved"] = approved;
    _data["closed"] = closed;
    _data["minSupport"] = minSupport;
    _data["countSupport"] = countSupport;
    // _data["startVoteDatetime"] = startVoteDatetime;
    // _data["endVoteDatetime"] = endVoteDatetime;
    _data["voteDaysRange"] = voteDaysRange;
    _data["status"] = status;
    _data["createAsPage"] = createAsPage;
    _data["type"] = type;
    _data["hashTag"] = hashTag;
    _data["pin"] = pin;
    _data["showVoterName"] = showVoterName;
    _data["showVoteResult"] = showVoteResult;
    _data["service"] = service;
    if (voteItem != null) {
      _data["voteItem"] = voteItem?.map((e) => e.toJson()).toList();
    } else {
      _data["voteItem"] = [];
    }
    return _data;
  }
}

class VoteItem {
  TextEditingController? controller;
  FocusNode? focusNode;
  int? ordering;
  String? titleItem;
  String? typeChoice;
  File? file;
  String? assetIdItem;
  String? coverPageUrlItem;
  String? s3CoverPageUrlItem;
  List<VoteChoice>? voteChoice;

  VoteItem(
      {this.controller,
      this.focusNode,
      this.ordering,
      this.titleItem,
      this.typeChoice,
      this.file,
      this.assetIdItem,
      this.coverPageUrlItem,
      this.s3CoverPageUrlItem,
      this.voteChoice});

  VoteItem.fromJson(Map<String, dynamic> json) {
    if (json["ordering"] is int) {
      ordering = json["ordering"];
    }
    if (json["titleItem"] is String) {
      titleItem = json["titleItem"];
    }
    if (json["typeChoice"] is String) {
      typeChoice = json["typeChoice"];
    }
    if (json["assetIdItem"] is String) {
      assetIdItem = json["assetIdItem"];
    }
    if (json["coverPageURLItem"] is String) {
      coverPageUrlItem = json["coverPageURLItem"];
    }
    if (json["s3CoverPageURLItem"] is String) {
      s3CoverPageUrlItem = json["s3CoverPageURLItem"];
    }
    if (json["voteChoice"] is List) {
      voteChoice = json["voteChoice"] == null ? null : (json["voteChoice"] as List).map((e) => VoteChoice.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ordering"] = ordering;
    _data["titleItem"] = (controller?.text ?? '').trim();
    _data["typeChoice"] = typeChoice;
    _data["assetIdItem"] = assetIdItem;
    _data["coverPageURLItem"] = coverPageUrlItem;
    _data["s3CoverPageURLItem"] = s3CoverPageUrlItem;
    if (voteChoice != null) {
      _data["voteChoice"] = voteChoice?.map((e) => e.toJson()).toList();
    } else {
      _data["voteChoice"] = [];
    }
    return _data;
  }
}

class VoteChoice {
  late TextEditingController controller;
  FocusNode? focusNode;
  String? title;
  String? assetId;
  String? coverPageUrl;
  String? s3CoverPageUrl;

  VoteChoice({TextEditingController? controller, this.focusNode, this.title, this.assetId, this.coverPageUrl, this.s3CoverPageUrl}) {
    this.controller = controller ?? TextEditingController(text: '');
  }

  VoteChoice.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["assetId"] is String) {
      assetId = json["assetId"];
    }
    if (json["coverPageURL"] is String) {
      coverPageUrl = json["coverPageURL"];
    }
    if (json["s3CoverPageURL"] is String) {
      s3CoverPageUrl = json["s3CoverPageURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = controller.text.trim();
    _data["assetId"] = assetId;
    _data["coverPageURL"] = coverPageUrl;
    _data["s3CoverPageURL"] = s3CoverPageUrl;
    return _data;
  }
}
