import '../../ui/utils/enum.dart';

class UserDataSocialModel {
  String? name;
  String? uid;
  String? email;
  String? imageUrl;
  String? imagePath;
  String? idToken;
  String? authToken;
  String? secretToken;
  int? expires;
  int? creationTime;
  int? lastSignInTime;
  ModeType? mode;

  UserDataSocialModel(
      {this.name,
      this.uid,
      this.email,
      this.imageUrl,
      this.imagePath,
      this.idToken,
      this.authToken,
      this.secretToken,
      this.expires,
      this.creationTime,
      this.lastSignInTime,
      this.mode});

  void clear() {
    name = null;
    uid = null;
    email = null;
    imageUrl = null;
    imagePath = null;
    idToken = null;
    authToken = null;
    secretToken = null;
    expires = null;
    creationTime = null;
    lastSignInTime = null;
    mode = null;
  }
}
