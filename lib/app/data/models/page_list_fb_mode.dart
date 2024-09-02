class PageListFacebookModel {
  List<Data>? data;
  Paging? paging;

  PageListFacebookModel({this.data, this.paging});

  PageListFacebookModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    paging = json["paging"] == null ? null : Paging.fromJson(json["paging"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    if (paging != null) {
      _data["paging"] = paging?.toJson();
    }
    return _data;
  }
}

class Paging {
  Cursors? cursors;

  Paging({this.cursors});

  Paging.fromJson(Map<String, dynamic> json) {
    cursors = json["cursors"] == null ? null : Cursors.fromJson(json["cursors"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (cursors != null) {
      _data["cursors"] = cursors?.toJson();
    }
    return _data;
  }
}

class Cursors {
  String? before;
  String? after;

  Cursors({this.before, this.after});

  Cursors.fromJson(Map<String, dynamic> json) {
    before = json["before"];
    after = json["after"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["before"] = before;
    _data["after"] = after;
    return _data;
  }
}

class Data {
  String? accessToken;
  String? category;
  List<CategoryList>? categoryList;
  String? name;
  String? id;
  List<String>? tasks;
  String? imageUrl;

  Data({this.accessToken, this.category, this.categoryList, this.name, this.id, this.tasks, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json["access_token"];
    category = json["category"];
    categoryList = json["category_list"] == null ? null : (json["category_list"] as List).map((e) => CategoryList.fromJson(e)).toList();
    name = json["name"];
    id = json["id"];
    tasks = json["tasks"] == null ? null : List<String>.from(json["tasks"]);
    imageUrl = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["access_token"] = accessToken;
    _data["category"] = category;
    if (categoryList != null) {
      _data["category_list"] = categoryList?.map((e) => e.toJson()).toList();
    }
    _data["name"] = name;
    _data["id"] = id;
    if (tasks != null) {
      _data["tasks"] = tasks;
    }
    return _data;
  }
}

class CategoryList {
  String? id;
  String? name;

  CategoryList({this.id, this.name});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}
