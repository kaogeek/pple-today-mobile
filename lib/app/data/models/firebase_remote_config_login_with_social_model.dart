import 'package:get/get.dart';

class FirebaseRemoteConfigLoginWithSocialModel {
  bool? mfp;
  bool? facebook;
  bool? google;
  bool? twitter;
  bool? apple;

  FirebaseRemoteConfigLoginWithSocialModel({
    this.mfp,
    this.facebook,
    this.google,
    this.twitter,
    this.apple,
  });

  FirebaseRemoteConfigLoginWithSocialModel.fromJson(Map<String, dynamic> json) {
    facebook = GetPlatform.isAndroid ? json["android"]["mfp"] ?? false : json["iOS"]["mfp"] ?? false;
    facebook = GetPlatform.isAndroid ? json["android"]["facebook"] ?? false : json["iOS"]["facebook"] ?? false;
    google = GetPlatform.isAndroid ? json["android"]["google"] ?? false : json["iOS"]["google"] ?? false;
    twitter = GetPlatform.isAndroid ? json["android"]["twitter"] ?? false : json["iOS"]["twitter"] ?? false;
    apple = GetPlatform.isAndroid ? false : json["iOS"]["apple"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["mfp"] = mfp;
    _data["facebook"] = facebook;
    _data["google"] = google;
    _data["twitter"] = twitter;
    _data["apple"] = apple;
    return _data;
  }

  void clear() {
    mfp = false;
    facebook = false;
    google = false;
    twitter = false;
    apple = false;
  }
}
