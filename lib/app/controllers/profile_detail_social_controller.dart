import 'package:get/get.dart';

import '../ui/utils/enum.dart';

class ProfileDetailSocialController extends GetxController {
  ModeType modeType = Get.arguments['MODE_TYPE'] ?? ModeType.email;
}
