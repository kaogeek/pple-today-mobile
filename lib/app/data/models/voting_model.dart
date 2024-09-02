class VotingModel {
  List<VoteItem>? voteItem;

  VotingModel({this.voteItem});

  VotingModel.fromJson(Map<String, dynamic> json) {
    if (json["voteItem"] is List) {
      voteItem = json["voteItem"] == null ? null : (json["voteItem"] as List).map((e) => VoteItem.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (voteItem != null) {
      _data["voteItem"] = voteItem?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class VoteItem {
  String? voteItemId;
  String? answer;
  List<VoteChoices>? voteChoice;

  VoteItem({this.voteItemId, this.answer, this.voteChoice});

  VoteItem.fromJson(Map<String, dynamic> json) {
    if (json["voteItemId"] is String) {
      voteItemId = json["voteItemId"];
    }
    if (json["answer"] is String) {
      answer = json["answer"];
    }
    if (json["voteChoice"] is List) {
      voteChoice = json["voteChoice"] == null ? null : (json["voteChoice"] as List).map((e) => VoteChoices.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["voteItemId"] = voteItemId;
    if ((answer ?? '').isNotEmpty) {
      _data["answer"] = answer;
    }
    if (voteChoice != null) {
      _data["voteChoice"] = voteChoice?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class VoteChoices {
  String? answer;
  String? voteChoiceId;

  VoteChoices({this.answer, this.voteChoiceId});

  VoteChoices.fromJson(Map<String, dynamic> json) {
    if (json["answer"] is String) {
      answer = json["answer"];
    }
    if (json["voteChoiceId"] is String) {
      voteChoiceId = json["voteChoiceId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["answer"] = answer;
    _data["voteChoiceId"] = voteChoiceId;
    return _data;
  }
}
