// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../controllers/dashboard_controller.dart';
import '../../../../controllers/profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class DashboardAppBar extends StatelessWidget {
  DashboardAppBar({Key? key}) : super(key: key);

  final _token = GetStorage().read(StorageKeys.token) ?? '';

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      floating: true,
      title: Image.asset(
        // TODO: Change to your logo
        Assets.assetsIconPpleTransparentO,
        width: 56,
        height: 56,
        fit: BoxFit.contain,
      ),
      actions: [
        Semantics(
          label: 'Search',
          customSemanticsActions: <CustomSemanticsAction, VoidCallback>{
            const CustomSemanticsAction(label: 'search'): () {
              Get.toNamed(AppRoutes.SEARCH);
            },
          },
          onTap: () => Get.toNamed(AppRoutes.SEARCH),
          excludeSemantics: true,
          child: IconButton(
            iconSize: 27,
            splashRadius: 1,
            icon: const Icon(
              Icons.search,
              color: primaryBlue,
            ),
            onPressed: () => Get.toNamed(AppRoutes.SEARCH),
          ),
        ),
        GetBuilder<DashboardController>(
          init: DashboardController(),
          initState: (_) {},
          builder: (controller) {
            return Stack(
              alignment: AlignmentDirectional.center,
              children: [
                IconButton(
                  iconSize: 27,
                  splashRadius: 1,
                  icon: const Icon(
                    MdiIcons.bellOutline,
                    color: primaryBlue,
                  ),
                  onPressed: () {
                    if (_token.isNotEmpty)
                      Get.toNamed(AppRoutes.NOTIFICATION_CARD)?.then((_) {
                        controller.countNoti = 0;
                        controller.update();
                      });
                    else
                      Get.toNamed(AppRoutes.LOGIN_REGISTER);
                  },
                ),
                if (controller.countNoti != 0)
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(top: 4),
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffc32c37),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        controller.countNoti >= 10 ? '9+' : controller.countNoti.toString(),
                        style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        GetBuilder<ProfileController>(
          init: ProfileController(),
          initState: (_) {},
          builder: (_) {
            return IconButton(
              iconSize: 27,
              splashRadius: 1,
              icon: _token.isEmpty
                  ? const Icon(
                      CupertinoIcons.person_crop_circle,
                      color: primaryBlue,
                    )
                  : ClipOval(
                      child: Image.network(
                        _.profileModel.data?.imageUrl ?? '',
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                        loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                            ? child
                            : const Icon(
                                CupertinoIcons.person_crop_circle,
                                color: primaryBlue,
                              ),
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          CupertinoIcons.person_crop_circle,
                          color: primaryBlue,
                        ),
                      ),
                    ),
              onPressed: () {
                if (_token.isEmpty)
                  Get.toNamed(AppRoutes.LOGIN_REGISTER);
                else
                  Get.toNamed(AppRoutes.PROFILE);
              },
            );
          },
        )
      ],
    );
  }
}
