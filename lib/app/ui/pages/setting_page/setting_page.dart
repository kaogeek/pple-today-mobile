import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/divider_component.dart';
import '../../../component/list_tile_component.dart';
import '../../../controllers/setting_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

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
          ],
        ),
      ),
    );
  }
}
