// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/dashboard_controller.dart';
import '../../../../controllers/today_controller.dart';
import '../../../utils/colors.dart';
import 'today_post_list.dart';
import 'today_recommended_user.dart';

class TodayTimeLine extends StatelessWidget {
  TodayTimeLine({Key? key}) : super(key: key);

  DashboardController dashController = Get.find();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodayController>(
      init: TodayController(),
      initState: (_) {},
      builder: (controller) {
        if (controller.isLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          );
        } else if ((controller.postStoryModel.data ?? []).isEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'ไม่มีโพสต์',
                      style: TextStyle(
                        fontSize: 18,
                        color: textDark,
                      ),
                    ),
                  ),
                ),
                TodayRecommendedUser(recommend: controller.recommendUserModel),
              ],
            ),
          );
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.postStoryModel.data!.length,
            itemBuilder: (BuildContext context, int index) {
              int length = controller.postStoryModel.data!.length;

              return Column(
                children: [
                  /// แสดง TodayPostList
                  TodayPostList(
                    index,
                    // key: _itemKey,
                  ),

                  /// ถ้าโพสต์น้อยกว่า 10 โพสต์ แสดง TodayRecommendedUser ที่ index สุดท้าย
                  // (length < 10) && ((index + 1) == length)
                  //     ? TodayRecommendedUser(recommend: controller.recommendUserModel) :kjds;aj

                  /// แสดง TodayRecommendedUser ทุกๆ 10 โพสต์
                  controller.isRefresh
                      ? const SizedBox()
                      : ((index + 1) % 10 == 0)
                          ? TodayRecommendedUser(recommend: controller.recommendUserModel)
                          : const SizedBox(),

                  /// แสดงข้อความ "ไม่มีโพสต์" ที่ index สุดท้าย
                  ((index + 1) == length) && controller.isNotPostStory
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              'ไม่มีโพสต์',
                              style: TextStyle(
                                fontSize: 18,
                                color: textDark,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          );
        }
      },
    );
  }
}
