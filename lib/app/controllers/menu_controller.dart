import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../data/models/verify_menu_item_model.dart';
import '../ui/utils/assets.dart';
import '../ui/utils/storage_keys.dart';

class MenuController extends GetxController {
  GetStorage box = GetStorage();

  String appVersion = '';
  String appBuild = '';

  final _verifyMenu = VerifyMenuItemModel().obs;
  VerifyMenuItemModel get verifyMenu => _verifyMenu.value;
  set verifyMenu(VerifyMenuItemModel value) => _verifyMenu.value = value;

  dynamic menuItem = [
    {
      "id": "personnel",
      "title": "บุคลากร",
      "imagePath": Assets.assetsImagesGroup12031,
      "url": "https://www.peoplespartythailand.org/person/parliament/",
    },
    {
      "id": "about",
      "title": "เกี่ยวกับพรรค",
      "imagePath": Assets.assetsIconPpleIconTransparentO,
      "url": "https://www.peoplespartythailand.org/about/",
    },
    {
      "id": "contact",
      "title": "ช่องทางการติดต่อ",
      "imagePath": Assets.assetsImagesGroup11962,
    },
    {
      "id": "vote",
      "title": "ประชาชน Vote",
      "imagePath": Assets.assetsImagesVoteLogo,
    },
    {
      "id": "point",
      "title": "ประชาชน Point",
      "imagePath": Assets.assetsImagesPoint,
    },
  ];

  @override
  void onInit() {
    checkMenuItems();
    getPageageInfo();
    super.onInit();
  }

  void checkMenuItems() {
    final readStorage = GetStorage().read(StorageKeys.menuItems) ?? '';

    if (readStorage.isEmpty) {
      verifyMenu = VerifyMenuItemModel(
        personnel: true,
        about: true,
        contact: true,
        vote: true,
        point: true,
      );
      return;
    }

    final verify = jsonDecode(readStorage);

    verifyMenu = VerifyMenuItemModel.fromJson(verify);
    return;
  }

  Future<void> getPageageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appVersion = packageInfo.version;
    appBuild = packageInfo.buildNumber;
    update();

    return;
  }
}
