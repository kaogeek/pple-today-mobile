// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/doing_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/environment.dart';

class DoingMonthAgo extends StatelessWidget {
  const DoingMonthAgo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoingController>(
      init: DoingController(),
      initState: (_) {},
      builder: (controller) {
        return (controller.doingModel.data ?? []).isEmpty
            ? SizedBox()
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'สิ่งที่กำลังทำใน 1 เดือนที่ผ่านมา',
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: controller.doingModel.data!.map((e) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.WEBVIEW_EMERGENCY,
                                arguments: {
                                  'URL': '${Environment.domainName}/objective/${e.id}',
                                  'TITLE': e.title,
                                  'ICON_IMAGE': e.iconUrl,
                                },
                              );
                            },
                            child: Container(
                              width: Get.width / 2.2,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[50],
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
                                  CircleAvatar(
                                    radius: 55,
                                    backgroundImage: NetworkImage(e.iconUrl!),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      '#${e.hashTag}',
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[200],
                    height: 10,
                    thickness: 9,
                  ),
                ],
              );
      },
    );
  }
}
