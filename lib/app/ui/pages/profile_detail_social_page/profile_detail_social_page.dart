import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_detail_social_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/enum.dart';
import 'widgets/profile_body_mfp.dart';

class ProfileDetailSocialPage extends GetView<ProfileDetailSocialController> {
  const ProfileDetailSocialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        elevation: .3,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          () {
            switch (controller.modeType) {
              case ModeType.mfp:
                return 'People\'s Party';

              case ModeType.facebook:
                return 'Facebook';

              case ModeType.google:
                return 'Google';

              default:
                return 'Profile';
            }
          }(),
          style: Get.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: () {
          switch (controller.modeType) {
            case ModeType.mfp:
              return ProfileMFP();

            // case ModeType.facebook:
            //   return 'Facebook';

            // case ModeType.google:
            //   return 'Google';

            default:
              return const Placeholder();
          }
        }(),
      ),
    );
  }
}
