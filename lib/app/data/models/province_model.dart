class ProvinceModel {
  List<DataProvince>? data;

  ProvinceModel({this.data});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => DataProvince.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  void clear() {
    data = [];
  }
}

class DataProvince {
  int? id;
  String? nameTh;
  String? nameEn;
  int? geographyId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  DataProvince({this.id, this.nameTh, this.nameEn, this.geographyId, this.createdAt, this.updatedAt, this.deletedAt});

  DataProvince.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name_th"] is String) {
      nameTh = json["name_th"];
    }
    if (json["name_en"] is String) {
      nameEn = json["name_en"];
    }
    if (json["geography_id"] is int) {
      geographyId = json["geography_id"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name_th"] = nameTh;
    _data["name_en"] = nameEn;
    _data["geography_id"] = geographyId;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}
