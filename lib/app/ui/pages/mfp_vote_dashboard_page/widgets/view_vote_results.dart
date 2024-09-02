// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../utils/colors.dart';
import 'vote_list_tile.dart';

class ViewVoteResults extends GetWidget<MfpVoteDashboardController> {
  ViewVoteResults({Key? key}) : super(key: key);

  @override
  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Obx(() {
        if ((controller.resultsVoteModel.value.status ?? 0) == 0 && controller.resultsVoteModel.value.data == null) {
          return SizedBox(
            width: Get.width,
            height: Get.height - 200,
            child: const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        }

        if ((controller.resultsVoteModel.value.data ?? []).isEmpty) {
          return SizedBox(
            width: Get.width,
            height: Get.height - 200,
            child: const Center(
              child: Text(
                'ไม่พบผลโหวตดูผลโหวต',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        return Column(
          children: [
            /// Old code
            // CardItem(
            //   topic: 'ผลโหวต',
            //   tabName: 'ดูผลโหวต',
            //   data: controller.resultsVoteModel.value.data,
            //   isResults: true,
            // ),

            // TODO: แสดงผลโหวต

            /// New code
            VoteListTile(
              topic: 'ผลโหวต',
              tabName: 'ดูผลโหวต',
              data: controller.resultsVoteModel.value.data,
              isResults: true,
            ),

            /// Load More
            Obx(() => SafeArea(
                  top: false,
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Center(
                      child: controller.isLoadMoreRunning.value
                          ? const CircularProgressIndicator(color: kPrimaryColor)
                          : controller.isFinalLoadMore.value
                              ? const Text('ไม่มีข้อมูลเพิ่มเติมแล้ว')
                              : const SizedBox(),
                    ),
                  ),
                )),
          ],
        );
      }),
    );
  }
}
