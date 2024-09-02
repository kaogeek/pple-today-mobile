// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/sync_page_social_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class SyncPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SyncPageAppBar({Key? key}) : super(key: key);

  // SyncPageSocialController controller = Get.put(SyncPageSocialController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SyncPageSocialController>(
      init: SyncPageSocialController(),
      initState: (_) {},
      builder: (controller) {
        return AppBar(
          centerTitle: false,
          leading: !controller.backButton
              ? null
              : IconButton(
                  splashRadius: 1,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kPrimaryColor,
                  ),
                  onPressed: () => Get.back(),
                ),
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
          actions: !controller.skipButton
              ? null
              : [
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.SPLASH);
                    },
                    child: const Text(
                      'ข้าม',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
