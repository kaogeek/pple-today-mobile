// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../controllers/page_profile_controller.dart';
import '../../../../controllers/today_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class FollowPageProfilePage extends StatelessWidget {
  FollowPageProfilePage({Key? key}) : super(key: key);

  PageProfileController controller = Get.put(PageProfileController());

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<PageProfileController>(
        init: PageProfileController(),
        initState: (_) {},
        builder: (_) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 16),
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                (controller.pageModel.data?.websiteUrl ?? '').isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          String url = (controller.pageModel.data?.websiteUrl ?? '').startsWith('http')
                              ? controller.pageModel.data!.websiteUrl!
                              : 'https://${controller.pageModel.data?.websiteUrl}';

                          String urlQueryParam = url.contains('?')
                              ? url.contains('mfpapp=true')
                                  ? url
                                  : '$url&mfpapp=true'
                              : '$url?mfpapp=true';

                          debugPrint('URLQUERYPARAM: $urlQueryParam');

                          Get.toNamed(
                            AppRoutes.WEBVIEW,
                            arguments: {
                              'URL': urlQueryParam,
                              'TITLE': controller.pageModel.data?.name ?? '',
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.language,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Text(
                                    'ไปที่เว็บไซต์',
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                const Spacer(),
                const Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                const SizedBox(width: 3),
                Text(
                  '${controller.pageModel.data?.followers ?? 0} คน',
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _onTapFollow,
                  child: Container(
                    width: Get.width / 4.1,
                    height: 40,
                    child: Center(
                      child: Text(
                        (controller.pageModel.data?.isFollow ?? false) ? 'กำลังติดตาม' : 'ติดตาม',
                        style: TextStyle(
                          color: (controller.pageModel.data?.isFollow ?? false) ? Colors.white : kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: (controller.pageModel.data?.isFollow ?? false) ? kPrimaryColor : Colors.white,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _onTapFollow() async {
    String token = GetStorage().read(StorageKeys.token) ?? '';

    if (token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    Get.find<TodayController>().fetchFollowed(
      pageId: controller.pageId,
      type: 'PAGE',
    );

    controller.pageModel.data?.isFollow = !(controller.pageModel.data?.isFollow ?? false);
    controller.pageModel.data?.followers = controller.pageModel.data?.isFollow ?? false
        ? (controller.pageModel.data?.followers ?? 0) + 1
        : (controller.pageModel.data?.followers ?? 0) > 0
            ? (controller.pageModel.data?.followers ?? 0) - 1
            : 0;
    controller.update();

    return;
  }
}
