import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../component/divider_component.dart';
import '../../../component/list_tile_component.dart';
import '../../../component/loading.dart';
import '../../../component/my_dialog.dart';
import '../../../controllers/setting_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/enum.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: Image.asset(
          // TODO: Change to your logo
          // Assets.images.group10673PNG,
          Assets.assetsIconPpleTransparentO,
          // width: 150,
          // height: 150,
          width: 56,
          height: 56,
          fit: BoxFit.contain,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DividerComponent(),
            ListTileComponent(
              title: 'นโยบายความเป็นส่วนตัว',
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 18,
                color: Colors.grey,
              ),
              onTap: () {
                Get.toNamed(
                  AppRoutes.PRIVACY_POLICY,
                  arguments: {'HIDE_BUTTON': true},
                );
              },
            ),
            const DividerComponent(),
            const SizedBox(height: 24),
            ListTileComponent(
              title: 'ลบบัญชี',
              type: ListTileType.delete,
              trailing: null,
              onTap: () async {
                await Get.defaultDialog(
                  title: 'ลบบัญชี',
                  titleStyle: TextStyle(
                    fontSize: 24,
                    fontFamily: Assets.assetsFontsAnakotmaiLight,
                    color: Colors.red,
                  ),
                  content: Text(
                    'ยืนยันที่จะลบบัญชีผู้ใช้นี้ หรือไม่?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Assets.assetsFontsAnakotmaiLight,
                    ),
                  ),
                  textCancel: 'ปิด',
                  textConfirm: 'ยืนยัน',
                  cancelTextColor: Colors.black,
                  confirmTextColor: Colors.red,
                  onConfirm: () async {
                    Get.back(); // close dialog

                    Loading.show();
                    await controller.fetchDeleteAccountUser().then((value) async {
                      Loading.dismiss();

                      if (value) {
                        await MyDialog.defaultDialog(
                          title: 'ลบบัญชี',
                          content: 'ระบบจะทำการลบบัญชีผู้ใช้นี้ภายใน 1 ชั่วโมง',
                        );

                        await GetStorage().erase();

                        Get.offAllNamed(AppRoutes.SPLASH);
                      } else {
                        MyDialog.defaultDialog(
                          title: 'เกิดข้อผิดพลาด',
                          content: 'ขออภัย เกิดข้อผิดพลาดในการเชื่อมต่อระบบ',
                        );
                      }
                    });
                  },
                  buttonColor: Colors.white,
                );
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
