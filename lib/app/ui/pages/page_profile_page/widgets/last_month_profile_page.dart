// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/page_profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/environment.dart';

class LastMonthProfilePage extends StatelessWidget {
  LastMonthProfilePage({Key? key}) : super(key: key);

  PageProfileController controller = Get.put(PageProfileController());

  final ScrollController _scrollHolController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<PageProfileController>(
        init: PageProfileController(),
        initState: (_) {},
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (controller.pageModel.data?.pageObjectives ?? []).isEmpty
                  ? const SizedBox()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          color: primaryGrey,
                          height: 20,
                          thickness: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            'สิ่งที่กำลังทำใน 1 เดือนที่ผ่านมา',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 175, //Get.height / 4,
                          child: ListView.builder(
                            controller: _scrollHolController,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            itemCount: controller.pageModel.data!.pageObjectives!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final pageObj = controller.pageModel.data!.pageObjectives![index];

                              return GestureDetector(
                                onTap: () => _onTapProfile(index),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: Get.width / 2,
                                  height: Get.height / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
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
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 11),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(pageObj.iconUrl!),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 5,
                                        ),
                                        child: Text(
                                          pageObj.title ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // SizedBox(height: 16),
                        // Divider(
                        //   color: Colors.grey.shade200,
                        //   height: 0,
                        //   thickness: 8,
                        // ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }

  void _onTapProfile(int index) {
    try {
      final pageObj = controller.pageModel.data!.pageObjectives![index];

      Get.toNamed(
        AppRoutes.WEBVIEW_EMERGENCY,
        arguments: {
          'URL': '${Environment.domainName}/objective/${pageObj.id}',
          'TITLE': pageObj.title,
          'ICON_IMAGE': pageObj.iconUrl!,
        },
      );
    } catch (e) {
      printError(info: e.toString());
      return;
    }
  }
}
