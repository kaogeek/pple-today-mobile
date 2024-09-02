class LoginFacebookModel {
  String? email;
  String? id;
  Picture? picture;
  String? name;

  LoginFacebookModel({this.email, this.id, this.picture, this.name});

  LoginFacebookModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    id = json["id"];
    picture = json["picture"] == null ? null : Picture.fromJson(json["picture"]);
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["id"] = id;
    if (picture != null) {
      data["picture"] = picture?.toJson();
    }
    data["name"] = name;
    return data;
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  bool? isSilhouette;
  int? height;
  String? url;
  int? width;

  Data({this.isSilhouette, this.height, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    isSilhouette = json["is_silhouette"];
    height = json["height"];
    url = json["url"];
    width = json["width"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["is_silhouette"] = isSilhouette;
    data["height"] = height;
    data["url"] = url;
    data["width"] = width;
    return data;
  }
}
