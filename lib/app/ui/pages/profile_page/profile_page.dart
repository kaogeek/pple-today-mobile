// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/divider_component.dart';
import '../../../component/list_tile_component.dart';
import '../../../controllers/profile_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import 'widgets/email_profile_user.dart';
import 'widgets/logout_button.dart';
import 'widgets/my_page_profile_user.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      backgroundColor: dashBlue,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: dashBlue,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'เมนู',
          style: Get.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            // fontWeight: FontWeight.bold,
            fontSize: 28,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ProfileController>(
            init: ProfileController(),
            initState: (_) {},
            builder: (_) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    )
                  : Column(
                      children: [
                        EmailProfileUser(),
                        MyPageProfileUser(),
                        const SizedBox(height: 24),
                        ListTileComponent(
                          color: Colors.white,
                          title: 'การเชื่อมต่อ',
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 18,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            Get.toNamed(AppRoutes.CONNECT_SOCIAL_MEDIA);
                          },
                        ),
                        const DividerComponent(),
                        ListTileComponent(
                          color: Colors.white,
                          title: 'นโยบายความเป็นส่วนตัว',
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 18,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            Get.toNamed(AppRoutes.SETTING);
                          },
                        ),
                        // const DividerComponent(),
                        const SizedBox(height: 56),
                        LogoutButton(),
                        const SizedBox(height: 16),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
