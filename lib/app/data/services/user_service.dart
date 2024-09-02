import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';

import '../../ui/utils/enum.dart';
import '../../ui/utils/environment.dart';

class UserService extends GetConnect {
  Future<Response> guest({
    required String deviceName,
    required String tokenFCM,
    required String os,
  }) async {
    String url = "${Environment.apiURL}/api/guest/users";

    String body = jsonEncode({
      "deviceName": deviceName,
      "token": tokenFCM,
      "os": os,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getProvince() async {
    String url = "https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province.json";

    Response response = await get(url);

    return response;
  }

  Future<Response> registerWithEmail({
    required String displayName,
    required String uniqueId,
    required String firstName,
    required String lastName,
    required String email,
    required String pass,
    required String province,
    required String birthdate,
    required String mimeType,
    required String? fileName,
    required int? sizeImage,
    required String? base64,
  }) async {
    String url = "${Environment.apiURL}/api/register";

    String body = jsonEncode({
      "displayName": displayName,
      "uniqueId": uniqueId,
      "username": email,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": pass,
      "birthdate": birthdate,
      "province": province,
      "asset": {
        "mimeType": mimeType,
        "fileName": fileName,
        "size": sizeImage,
        "data": base64,
      },
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mode": "EMAIL",
      "mod_modMobile": "mobile",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> registerWithFacebook({
    required String displayName,
    required String uniqueId,
    required String firstName,
    required String lastName,
    required String email,
    required String pass,
    required String province,
    required String birthdate,
    required int? expiresFB,
    required String? tokenFB,
    required String? uid,
    required String mimeType,
    required String? base64,
  }) async {
    String url = "${Environment.apiURL}/api/register";

    String body = jsonEncode({
      "displayName": displayName,
      "uniqueId": uniqueId,
      "username": email,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": pass,
      "birthdate": birthdate,
      "fbAccessExpirationTime": expiresFB,
      "fbSignedRequest": email,
      "fbToken": tokenFB,
      "fbUserId": uid,
      "asset": {
        "mimeType": mimeType,
        "data": base64,
      },
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mode": "FACEBOOK",
      "mod_modMobile": "mobile",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> registerWithGoogle({
    required String displayName,
    required String uniqueId,
    required String firstName,
    required String lastName,
    required String email,
    required String birthdate,
    required String? token,
    required String? authToken,
    required String? uid,
    required String mimeType,
    required String? base64,
  }) async {
    String url = "${Environment.apiURL}/api/register";

    String body = jsonEncode({
      "username": email,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": "",
      "uniqueId": uniqueId,
      "birthdate": birthdate,
      "displayName": displayName,
      "googleUserId": uid,
      "idToken": token,
      "authToken": authToken,
      "asset": {
        "mimeType": mimeType,
        "data": base64,
      }
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mode": "GOOGLE",
      "mod_modMobile": "mobile",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> registerWithApple({
    required String displayName,
    required String uniqueId,
    required String firstName,
    required String lastName,
    required String email,
    required String birthdate,
    required String? token,
    required String? authToken,
    required String? emailHide,
    required String? uid,
    required String mimeType,
    required String? base64,
  }) async {
    String url = "${Environment.apiURL}/api/register";

    String body = jsonEncode({
      "username": email,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": "",
      "uniqueId": uniqueId,
      "birthdate": birthdate,
      "displayName": displayName,
      "userId": uid,
      "idToken": token,
      "authToken": authToken,
      "emailHide": emailHide,
      "asset": {
        "mimeType": mimeType,
        "data": base64,
      }
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mode": "GOOGLE",
      "mod_modMobile": "mobile",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> checkStatus({
    required String token,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/check_status";

    Map<String, dynamic> query = {
      "token": token,
    };

    Map<String, String> headers = {
      "mode": mode,
    };

    Response response = await get(
      url,
      query: query,
      headers: headers,
    );

    return response;
  }

  Future<Response> uniqueidCheck(String uniqueId) async {
    String url = "${Environment.apiURL}/api/user/uniqueid/check";

    String body = jsonEncode({
      "uniqueId": uniqueId,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> emailCheck(String email) async {
    String url = "${Environment.apiURL}/api/user/email/check";

    String body = json.encode({
      "email": email,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mode": "EMAIL",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> checkEmailUser({
    required ModeType mode,
    required String? email,
    required String? pass,
    required String? uid,
    required String? deviceName,
    required String? tokenFCM,
    required String? tokenFB,
    required String? tokenSecretTW,
    required String? idToken,
    required String? authToken,
  }) async {
    String url = "${Environment.apiURL}/api/check_email_user";

    String body;
    switch (mode) {
      case ModeType.facebook:
        body = jsonEncode({
          "email": email!.toLowerCase(),
          "token": tokenFB,
          "tokenFCM_FB": {
            "tokenFCM": tokenFCM,
            "deviceName": deviceName,
          },
        });
        break;

      case ModeType.google:
        body = jsonEncode({
          "idToken": idToken,
          "authToken": authToken,
          "tokenFCM_GG": {
            "tokenFCM": tokenFCM,
            "deviceName": deviceName,
          },
        });
        break;

      case ModeType.twitter:
        body = jsonEncode({
          "twitterOauthToken": authToken,
          "twitterOauthTokenSecret": tokenSecretTW,
          "twitterUserId": uid,
          "tokenFCM": tokenFCM,
          "email": email,
          "deviceName": deviceName,
        });
        break;

      case ModeType.apple:
        body = jsonEncode({
          "email": email,
          "apple": {
            "result": {
              "user": {
                "userId": uid,
                "idToken": idToken,
              }
            }
          },
        });
        break;

      default:
        body = jsonEncode({
          "email": email,
          "password": pass,
          "deviceName": deviceName,
          "tokenFCM": tokenFCM,
        });
        break;
    }

    String _mode = mode.toString().toUpperCase().split(".").last;

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mode": _mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> sendOtp({required String email}) async {
    String url = "${Environment.apiURL}/api/send_otp";

    String body = jsonEncode({
      "email": email,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> checkOTP({
    required String email,
    required int otp,
    required String? id,
    required String? tokenFCM,
    required String? tokenSecretTW,
    required String? idToken,
    required String? authToken,
    required String? devicename,
    required int? expires,
    required ModeType mode,
  }) async {
    String url = "${Environment.apiURL}/api/check_otp";

    String body;
    switch (mode) {
      case ModeType.facebook:
        body = jsonEncode({
          "email": email,
          "otp": otp,
          "facebook": {
            "fbid": id,
            "fbtoken": idToken,
            "fbexptime": expires,
            "fbsignedRequest": email,
          },
          "tokenFCM": tokenFCM,
        });
        break;

      case ModeType.google:
        body = jsonEncode({
          "email": email,
          "otp": otp,
          "idToken": idToken,
          "authToken": authToken,
          "tokenFCM_GG": {
            "tokenFCM": tokenFCM,
            "deviceName": devicename,
          },
        });
        break;

      case ModeType.twitter:
        body = jsonEncode({
          "twitterOauthToken": authToken,
          "twitterOauthTokenSecret": tokenSecretTW,
          "twitterUserId": id,
          "email": email,
          "otp": otp,
        });
        break;

      case ModeType.apple:
        body = jsonEncode({
          "apple": {
            "result": {
              "user": {
                "userId": id,
                "idToken": idToken,
              }
            }
          },
          "email": email,
          "otp": otp,
        });
        break;

      default:
        body = jsonEncode({
          "email": email,
          "otp": otp,
        });
        break;
    }

    String _mode = mode.toString().toUpperCase().split(".").last;

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mode": _mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> updataMemberShip({
    required String uid,
    required String token,
    required String mode,
    required bool membership,
  }) async {
    String url = "${Environment.apiURL}/api/profile/$uid";

    String body = jsonEncode({
      "membership": membership,
      "token": token,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "Authorization": "Bearer $token",
      "mode": mode,
      "userid": uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> bindingMember({
    required String tokenMFP,
    required String uid,
    required String token,
    required String mode,
  }) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenMFP);

    String url = "${Environment.apiURL}/api/profile/$uid/binding";

    String body = jsonEncode(decodedToken);

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "Authorization": "Bearer $token",
      "mode": mode,
      "userid": uid,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> loginWithEmail({
    required String? email,
    required String? pass,
    required String? deviceName,
    required String? tokenFCM,
  }) async {
    String url = "${Environment.apiURL}/api/login";

    String body = jsonEncode({
      "username": email,
      "password": pass,
      "deviceName": deviceName,
      "tokenFCM": tokenFCM,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mod_headers": "mobile",
      "mode": "EMAIL",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> loginWithFacebook({
    required String? tokenFB,
    required String? deviceName,
    required String? tokenFCM,
  }) async {
    String url = "${Environment.apiURL}/api/login";

    String body = jsonEncode({
      "token": tokenFB,
      "deviceName": deviceName,
      "tokenFCM": tokenFCM,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mod_headers": "mobile",
      "mode": "FACEBOOK",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> loginWithGoogle({
    required String? idToken,
    required String? authToken,
    required String? deviceName,
    required String? tokenFCM,
  }) async {
    String url = "${Environment.apiURL}/api/login";

    String body = jsonEncode({
      "idToken": idToken,
      "authToken": authToken,
      "deviceName": deviceName,
      "tokenFCM_GG": tokenFCM,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mod_headers": "mobile",
      "mode": "GOOGLE",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> loginWithApple({
    required String? uid,
    required String? email,
    required String? idToken,
    required String? authToken,
    required int? creationTime,
    required int? lastSignInTime,
    required String? deviceName,
    required String? tokenFCM,
  }) async {
    String url = "${Environment.apiURL}/api/login";

    String body = jsonEncode({
      "apple": {
        "result": {
          "user": {
            "userId": uid,
            "email": email,
            "idToken": idToken,
            "accessToken": authToken,
            "metadata": {
              "creationTime": creationTime,
              "lastSignInTime": lastSignInTime,
            }
          },
        }
      },
      "tokenFCM": tokenFCM,
      "deviceName": deviceName,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "mod_headers": "mobile",
      "mode": "APPLE",
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> editProfile({
    required String uid,
    required String token,
    required String mode,
    required String? displayName,
    required String? firstName,
    required String? lastName,
    required String? birthdate,
    required String? province,
    required int? gender,
  }) async {
    String url = "${Environment.apiURL}/api/profile/$uid";

    Map _body = {};

    if (displayName != null) {
      _body.addAll({"displayName": displayName});
    }
    if (firstName != null) {
      _body.addAll({"firstName": firstName});
    }
    if (lastName != null) {
      _body.addAll({"lastName": lastName});
    }
    if (birthdate != null) {
      _body.addAll({"birthdate": birthdate});
    }
    if (gender != null) {
      _body.addAll({"gender": gender});
    }
    if (province != null) {
      _body.addAll({"province": province});
    }

    String body = jsonEncode(_body);

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await put(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> editImageProfile({
    required String uid,
    required String token,
    required String mode,
    required String mimeType,
    required String fileName,
    required int size,
    required String base64,
  }) async {
    String url = "${Environment.apiURL}/api/profile/$uid/image";

    String body = jsonEncode({
      "asset": {
        "mimeType": mimeType,
        "fileName": fileName,
        "size": size,
        "data": base64,
      },
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> forgotPassSendOTP(String email) async {
    String url = "${Environment.apiURL}/api/forgot";

    String body = jsonEncode({
      "username": email,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> forgotPassChangePass({
    required String otp,
    required String email,
    required String pass,
  }) async {
    String url = "${Environment.apiURL}/api/change_password";

    String body = jsonEncode({
      "code": otp,
      "email": email,
      "password": pass,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getProfileUser(String uid) async {
    String url = "${Environment.apiURL}/api/profile/$uid";

    Response response = await get(url);

    return response;
  }

  Future<Response> getUserAccess({
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/user/access";

    Map<String, String> headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<Response> getUserAccessPage({
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/useraccess/page";

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await get(
      url,
      headers: headers,
    ).timeout(const Duration(minutes: 1));

    return response;
  }

  Future<Response> checkTokenFB({
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/page/check/fb_token";

    Map<String, String> headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await get(
      url,
      headers: headers,
    );

    return response;
  }

  Future<Response> refreshTokenPageFB({
    required List<String> facebookPageId,
    required List<String> facebookPageName,
    required List<String> facebookCategory,
    required List<String> pageAccessToken,
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/page/get/fb_token";

    Map<String, String> headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    List<Map<String, dynamic>> body = [];

    for (int i = 0; i < facebookPageId.length; i++) {
      body.add({
        "facebookPageId": facebookPageId[i],
        "facebookPageName": facebookPageName[i],
        "facebookCategory": facebookCategory[i],
        "pageAccessToken": pageAccessToken[i],
      });
    }

    Response response = await post(
      url,
      jsonEncode(body),
      headers: headers,
    );

    return response;
  }

  Future<Response> hidePost({
    required String uid,
    required String token,
    required String mode,
    required String postId,
  }) async {
    String url = "${Environment.apiURL}/api/user/report/hide";

    String body = jsonEncode({
      "postId": postId,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getManipulateUser() async {
    String url = "${Environment.apiURL}/api/user/report/manipulate";

    Response response = await get(url);

    return response;
  }

  Future<Response> getManipulatePost() async {
    String url = "${Environment.apiURL}/api/post/report/manipulate";

    Response response = await get(url);

    return response;
  }

  Future<Response> getManipulatePage() async {
    String url = "${Environment.apiURL}/api/page/report/manipulate";

    Response response = await get(url);

    return response;
  }

  Future<Response> reportPostPageUser({
    required String uid,
    required String token,
    required String mode,
    required String id,
    required String type,
    required String topic,
    required String message,
  }) async {
    String url = "${Environment.apiURL}/api/user/report";

    String body = jsonEncode({
      "typeId": id,
      "type": type,
      "topic": topic,
      "message": message,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> blockPageUser({
    required String id,
    required String type,
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/user/content/block";

    String body = jsonEncode({
      "subjectId": id,
      "subjectType": type,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getLogout({
    required String token,
    required String tokenFCM,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/user/logout";

    String body = jsonEncode({
      "tokenFCM": tokenFCM,
    });

    Map<String, String> headers = {
      "content-type": defaultContentType,
      "authorization": "Bearer $token",
      "mode": mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> deleteAccountUser({
    required String uid,
    required String token,
    required String mode,
  }) async {
    String url = "${Environment.apiURL}/api/user/delete";

    String body = jsonEncode({
      "banned": true,
    });

    Map<String, String> headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "mode": mode,
    };

    Response response = await post(
      url,
      body,
      headers: headers,
    );

    return response;
  }

  Future<Response> getPermissible({
    required String token,
    required String uid,
    required String mode,
  }) async {
    String url = '${Environment.apiURL}/api/voting/permissible';

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'mode': mode,
      'userid': uid,
    };

    Response response = await post(
      url,
      null,
      headers: headers,
    );

    return response;
  }

  Future<Response> md5HashKey({required String uid}) async {
    String url = "http://api.hashify.net/hash/md5/hex";

    Response response = await get(
      url,
      query: {'value': '$uid-acttoday'},
    );

    return response;
  }
}
