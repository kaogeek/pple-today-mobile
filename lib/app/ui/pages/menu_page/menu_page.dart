// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../component/my_dialog.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../controllers/menu_controller.dart' as menu;
import '../../../routes/app_routes.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/storage_keys.dart';
import '../dashboard_page/widgets/dashboard_app_bar.dart';

class MenuPage extends GetView<menu.MenuController> {
  MenuPage({Key? key}) : super(key: key);

  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    /// New code
    return Scaffold(
      body: CustomScrollView(
        controller: dashboardController.scrollController4,
        shrinkWrap: true,
        slivers: [
          DashboardAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ข้อมูลเกี่ยวกับพรรค',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GetBuilder<menu.MenuController>(
                    init: menu.MenuController(),
                    initState: (_) {},
                    builder: (_) {
                      return controller.menuItem.isEmpty
                          ? const SizedBox()
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 130,
                              ),
                              padding: EdgeInsets.zero,
                              itemCount: controller.menuItem.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = controller.menuItem[index];
                                var verify = controller.verifyMenu.toJson()['${item['id']}'];

                                if (!verify) {
                                  return const SizedBox();
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: GestureDetector(
                                    onTap: () {
                                      _onTap(
                                        id: item['id'] as String,
                                        url: item['url'] as String?,
                                      );
                                    },
                                    child: Container(
                                      width: Get.width / 2.3,
                                      height: 128,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(1),
                                            blurRadius: .5,
                                            spreadRadius: .5,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            item['imagePath'].toString(),
                                            width: 65,
                                            height: 55,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(
                                              item['title'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: primaryBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: GetBuilder<menu.MenuController>(
                      init: menu.MenuController(),
                      initState: (_) {},
                      builder: (_) {
                        return Text(
                          'v.${controller.appVersion}' + (kDebugMode ? '\t(+${controller.appBuild})' : ''),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    /// Old code
    /* return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ข้อมูลเกี่ยวกับพรรค',
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder<menu.MenuController>(
            init: menu.MenuController(),
            initState: (_) {},
            builder: (_) {
              return controller.gridItem.isEmpty
                  ? const SizedBox()
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 130,
                      ),
                      padding: EdgeInsets.zero,
                      itemCount: controller.gridItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = controller.gridItem[index];
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              _onTap(
                                id: item['id'] as int,
                                url: item['url'] as String?,
                              );
                            },
                            child: Container(
                              width: Get.width / 2.3,
                              height: 128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    blurRadius: .5,
                                    spreadRadius: .5,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    item['imagePath'].toString(),
                                    width: 65,
                                    height: 55,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      item['title'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: primaryBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: GetBuilder<menu.MenuController>(
              init: menu.MenuController(),
              initState: (_) {},
              builder: (_) {
                return Text(
                  'v.${controller.appVersion}' + (kDebugMode ? '\t(+${controller.appBuild})' : ''),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ); */
  }

  Future<void> _onTap({required String id, required String? url}) async {
    switch (id) {
      case "contact":
        MyDialog.twoTone(
          title: 'สำนักงานใหญ่\nเลขที่ 167 อาคารอนาคตใหม่ ชั้น 6\nรามคำแหง 42 แขวงหัวหมาก เขตบางกะปิ\nกรุงเทพมหานคร 10240\n',
          subTitle:
              'ติดต่อเรา\n☎️ 02-821-5874 (จันทร์-ศุกร์ 10:00-18:00 น.)\n📧 office@peoplespartythailand.org\nPeoplesPartyThailand\n@PPLEThailand\nพรรคประชาชน - People\'s Party',
        );
        break;

      case "vote":
        await GetStorage().remove(StorageKeys.voteObjId);
        Get.toNamed(
          AppRoutes.MFP_VOTE_DASHBOARD,
          arguments: {'VOTE_ID': ''},
        );
        break;

      case "point":
        Get.toNamed(AppRoutes.POINT_MAIN);
        break;

      default:
        if (url != null) {
          Get.toNamed(
            AppRoutes.WEBVIEW,
            arguments: {
              'URL': url,
              //   'TITLE': controller.menuItem[id]['title'],
              'TITLE': controller.menuItem.firstWhere((element) => element['id'] == id)['title'],
            },
          );
        }
        break;
    }

    return;
  }
}
