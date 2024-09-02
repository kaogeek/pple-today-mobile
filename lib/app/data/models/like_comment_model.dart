class LikeCommentModel {
  int? status;
  String? message;

  LikeCommentModel({this.status, this.message});

  LikeCommentModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;

    return data;
  }

  void clean() {
    status = null;
    message = null;
  }
}
