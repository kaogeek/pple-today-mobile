import 'package:get_storage/get_storage.dart';

import '../ui/utils/storage_keys.dart';
import 'mfp_dialog.dart';

class CheckMemberShip {
  bool get(String typePost) {
    if (typePost == 'MEMBERSHIP' || typePost == 'MEMBER') {
      bool authMemberShip = GetStorage().read(StorageKeys.authMemberShip) ?? false;
      bool memberShip = GetStorage().read(StorageKeys.memberShip) ?? false;

      if (authMemberShip && !memberShip) {
        Mfp.memberExpieadDialog();
        return false;
      }

      if (!memberShip) {
        Mfp.memberEngagementDialog();
        return false;
      }
    }

    return true;
  }
}
