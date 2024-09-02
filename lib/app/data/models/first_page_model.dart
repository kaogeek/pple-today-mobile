class FirstPageModel {
  int? status;
  String? message;
  Data? data;

  FirstPageModel({this.status, this.message, this.data});

  FirstPageModel.fromJson(Map<String, dynamic> json) {
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
  Today? today;
  List<TodayPastDays>? todayPast7Days;
  List<TodayPastDays>? todayPast30Days;
  List<PopularNews>? popularNews;

  Data({this.today, this.todayPast7Days, this.todayPast30Days, this.popularNews});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["today"] is Map) {
      today = json["today"] == null ? null : Today.fromJson(json["today"]);
    }
    if (json["todayPast7days"] is List) {
      todayPast7Days = json["todayPast7days"] == null ? null : (json["todayPast7days"] as List).map((e) => TodayPastDays.fromJson(e)).toList();
    }
    if (json["todayPast30days"] is List) {
      todayPast30Days = json["todayPast30days"] == null ? null : (json["todayPast30days"] as List).map((e) => TodayPastDays.fromJson(e)).toList();
    }
    if (json["popularNews"] is List) {
      popularNews = json["popularNews"] == null ? null : (json["popularNews"] as List).map((e) => PopularNews.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (today != null) {
      _data["today"] = today?.toJson();
    }
    if (todayPast7Days != null) {
      _data["todayPast7days"] = todayPast7Days?.map((e) => e.toJson()).toList();
    }
    if (todayPast30Days != null) {
      _data["todayPast30days"] = todayPast30Days?.map((e) => e.toJson()).toList();
    }
    if (popularNews != null) {
      _data["popularNews"] = popularNews?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class PopularNews {
  String? title;
  String? image;
  String? timeStamp;
  String? date;

  PopularNews({this.title, this.image, this.timeStamp, this.date});

  PopularNews.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["image"] = image;
    _data["timeStamp"] = timeStamp;
    _data["date"] = date;
    return _data;
  }
}

class TodayPastDays {
  String? title;
  String? image;
  String? timeStamp;
  String? date;

  TodayPastDays({this.title, this.image, this.timeStamp, this.date});

  TodayPastDays.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["image"] = image;
    _data["timeStamp"] = timeStamp;
    _data["date"] = date;
    return _data;
  }
}

class Today {
  String? title;
  String? image;
  String? timeStamp;
  String? date;

  Today({this.title, this.image, this.timeStamp, this.date});

  Today.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["image"] = image;
    _data["timeStamp"] = timeStamp;
    _data["date"] = date;
    return _data;
  }
}
