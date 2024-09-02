import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../ui/utils/environment.dart';
import '../../ui/utils/storage_keys.dart';

class BaseService extends GetConnect {
  GetStorage box = GetStorage();

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Environment.apiURL;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Content-Type'] = 'application/json';

      /// Add the token to the request headers
      if (box.read(StorageKeys.token) != null) {
        request.headers['Authorization'] = 'Bearer ${box.read(StorageKeys.token)}';
      }
      //   else {
      //     request.headers['Authorization '] = 'Bearer ';
      //   }

      /// Add the user id to the request headers
      if (box.read(StorageKeys.uid) != null) {
        request.headers['userid'] = box.read(StorageKeys.uid);
      }
      //   else {
      //     request.headers['userid'] = '';
      //   }

      /// Add the mode to the request headers
      if (box.read(StorageKeys.mode) != null) {
        request.headers['mode'] = box.read(StorageKeys.mode);
      }
      //   else {
      //     request.headers['mode'] = '';
      //   }

      return request;
    });
    super.onInit();
  }
}
