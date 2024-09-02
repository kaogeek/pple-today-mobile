import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../../../../component/elevated_button_component.dart';
import '../../../../component/loading.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/sync_page_social_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

class SyncPageBody extends GetWidget<SyncPageSocialController> {
  const SyncPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Text(
                'คุณต้องการสร้างเพจหรือไม่?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Builder(builder: (context) {
                return ElevatedButtonComponent(
                  primary: const Color(0xFF1877F2),
                  icon: Image.asset(
                    Assets.assetsImagesFacebook,
                    width: 56,
                    height: 56,
                    fit: BoxFit.fitHeight,
                  ),
                  labelText: 'Facebook',
                  onPressed: () async {
                    Loading.show();

                    final _value = await controller.loginFacebook();

                    if (_value == LoginStatus.success) {
                      if ((controller.pageListFBModel.data ?? []).isEmpty) {
                        Loading.dismiss();
                        SnackBarComponent.show(
                          title: 'คุณไม่มีเพจที่ Facebook',
                          type: SnackBarType.warning,
                        );
                        return;
                      }

                      Loading.dismiss();

                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                const Text(
                                  'กรุณาเลือกเพจที่ต้องการเชื่อมต่อ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Column(
                                    children: controller.pageListFBModel.data!.map((e) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(e.imageUrl!),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        title: Text(
                                          e.name!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () async {
                                          Loading.show();

                                          final value = await controller.fetchSyncPageFB(
                                            facebookPageId: e.id!,
                                            facebookPageName: e.name!,
                                            pageAccessToken: e.accessToken!,
                                            facebookCategory: e.category!,
                                          );

                                          if (value.status == 0) {
                                            Loading.dismiss();

                                            SnackBarComponent.show(
                                              title: value.message!,
                                              type: SnackBarType.error,
                                            );
                                            return;
                                          }

                                          Loading.dismiss();

                                          Get.back(); // Close BottomSheet
                                          Get.offAllNamed(AppRoutes.SPLASH);
                                          return;
                                        },
                                      ),
                                      const Divider(thickness: 1),
                                    ],
                                  );
                                }).toList()),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      Loading.dismiss();
                      return;
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
