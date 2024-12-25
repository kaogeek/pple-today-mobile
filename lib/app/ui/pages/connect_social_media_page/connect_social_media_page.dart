import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/connect_social_media_controller.dart';
import '../../../controllers/main_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/enum.dart';
import '../../utils/storage_keys.dart';

class ConnectSocialMediaPage extends GetView<ConnectSocialMediaController> {
  ConnectSocialMediaPage({super.key});

  @override
  final controller = Get.put(ConnectSocialMediaController());
  final profileController = Get.put(ProfileController());
  final mainController = Get.put(MainController());

  // final List _socialList = [
  //   {
  //     'icon': Assets.images.ppleTransparentPNG,
  //     'mode': ModeType.mfp,
  //     'width': 56.0,
  //     'height': 56.0,
  //     'color': Colors.transparent,
  //     'title': 'People\'s Party',
  //     'subtitle': '',
  //   },
  //   {
  //     'icon': Assets.assetsImagesFacebook,
  //     'mode': ModeType.facebook,
  //     'width': 56.0,
  //     'height': 56.0,
  //     'color': facebookColor,
  //     'title': 'Facebook',
  //     'subtitle': '',
  //   },
  //   {
  //     'icon': Assets.assetsImagesGoogle,
  //     'mode': ModeType.google,
  //     'width': 56.0,
  //     'height': 32.0,
  //     'color': Colors.white,
  //     'title': 'Google',
  //     'subtitle': '',
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    final List socialList = [
      {
        'icon': Assets.assetsIconPpleIconTransparentO,
        'mode': ModeType.mfp,
        'width': 56.0,
        'height': 56.0,
        'color': Colors.transparent,
        'title': 'People\'s Party',
        'subtitle': '',
      },
      {
        'icon': Assets.assetsIconPpleIconTransparentO,
        'mode': ModeType.act,
        'width': 56.0,
        'height': 56.0,
        'color': Colors.transparent,
        'title': 'Act MFP',
        'subtitle': '',
      },
      if (mainController.loginWithSocialModel.facebook ?? false)
        {
          'icon': Assets.assetsImagesFacebook,
          'mode': ModeType.facebook,
          'width': 56.0,
          'height': 56.0,
          'color': facebookColor,
          'title': 'Facebook',
          'subtitle': '',
        },
      if (mainController.loginWithSocialModel.google ?? false)
        {
          'icon': Assets.assetsImagesGoogle,
          'mode': ModeType.google,
          'width': 56.0,
          'height': 32.0,
          'color': Colors.white,
          'title': 'Google',
          'subtitle': '',
        }
    ];

    return MainLayoutView(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        // elevation: 1,
        title: Text(
          'การเชื่อมต่อ',
          style: Get.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          initState: (_) {},
          builder: (_) {
            return Column(
              children: socialList
                  .asMap()
                  .map((i, e) {
                    final ModeType mode = e['mode'];
                    final Color color = e['color'];
                    final String icon = e['icon'];

                    final String title = e['title'];
                    final String subtitle = e['subtitle'];

                    final List<String> authUser = profileController.profileModel.data?.authUser ?? [];
                    debugPrint('_AUTHUSER: $authUser', wrapWidth: 1024);

                    return MapEntry(
                      i,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          onTap: () async {
                            switch (mode) {
                              case ModeType.mfp:
                                if (!authUser.contains('MFP')) {
                                  await controller.fetchBindingMFP();
                                } else {
                                  Get.toNamed(
                                    AppRoutes.PROFILE_DETAIL_SOCIAL,
                                    arguments: {'MODE_TYPE': mode},
                                  );
                                }
                                break;

                              case ModeType.act:
                                await controller.fetchBindingAct();
                                break;

                              case ModeType.facebook:
                                if (!authUser.contains('FACEBOOK')) {
                                  await controller.fetchLoginWithFacebook();
                                }
                                break;

                              case ModeType.google:
                                if ((!authUser.contains('GOOGLE'))) {
                                  await controller.fetchLoginWithGoogle();
                                }
                                break;

                              default:
                                break;
                            }
                          },
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Image.asset(
                              icon,
                              fit: BoxFit.contain,
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                () {
                                  switch (mode) {
                                    case ModeType.mfp:
                                      return GetStorage().read(StorageKeys.memberShip) ?? false ? 'เชื่อมต่อแล้ว' : '';

                                    case ModeType.act:
                                      return GetStorage().read(StorageKeys.uidAct) != null ? 'เชื่อมต่อแล้ว' : '';

                                    default:
                                      return authUser.contains(mode.toString().split('.').last.toUpperCase()) ? 'เชื่อมต่อแล้ว' : '';
                                  }
                                }(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  fontFamily: Assets.assetsFontsAnakotmaiLight,
                                ),
                              ),
                            ],
                          ),
                          subtitle: subtitle.trim().isEmpty
                              ? null
                              : Text(
                                  subtitle,
                                  style: const TextStyle(fontSize: 16),
                                ),
                          trailing: mode == ModeType.mfp
                              ? const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 16,
                                )
                              : authUser.contains(mode.toString().split('.').last.toUpperCase())
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                    )
                                  : const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                        ),
                      ),
                    );
                  })
                  .values
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
