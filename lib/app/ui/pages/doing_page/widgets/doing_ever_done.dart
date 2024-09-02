// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/doing_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/environment.dart';

class DoingEverDone extends StatelessWidget {
  const DoingEverDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoingController>(
        init: DoingController(),
        initState: (_) {},
        builder: (controller) {
          return (controller.objectiveDoingModel.data ?? []).isEmpty
              ? SizedBox()
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'สิ่งที่เคยทำมา',
                          style: TextStyle(
                            color: primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.objectiveDoingModel.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = controller.objectiveDoingModel.data![index];

                        return GestureDetector(
                          onTap: () {
                            if (data.id == null) {
                              SnackBarComponent.show(
                                title: 'ไม่พบข้อมูล',
                                type: SnackBarType.warning,
                              );
                              return;
                            }

                            Get.toNamed(
                              AppRoutes.WEBVIEW_EMERGENCY,
                              arguments: {
                                'URL': '${Environment.domainName}/objective/${data.id}',
                                'TITLE': data.title,
                                'ICON_IMAGE': data.iconUrl,
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 2,
                              top: 10,
                            ),
                            width: Get.width,
                            // height: Get.height / 100 * 12, // Get.height / 100 * 14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: .5,
                                  spreadRadius: .5,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: CircleAvatar(radius: 36, backgroundImage: NetworkImage(data.iconUrl!)),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '#${data.hashTag}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        data.title ?? '',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
        });
  }
}
