// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../utils/colors.dart';
import 'card_item.dart';

class ViewVoteAll extends GetWidget<MfpVoteDashboardController> {
  ViewVoteAll({Key? key}) : super(key: key);

  @override
  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => (controller.mainContentsVoteModel.value.status ?? 0) == 0 && controller.mainContentsVoteModel.value.data == null
          ? SizedBox(
              width: Get.width,
              height: Get.height - 200,
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            )
          : (controller.mainContentsVoteModel.value.data!.pin ?? []).isEmpty &&
                  (controller.mainContentsVoteModel.value.data!.closeDate ?? []).isEmpty &&
                  (controller.mainContentsVoteModel.value.data!.hashTagVote ?? []).isEmpty &&
                  (controller.mainContentsVoteModel.value.data!.closetSupport ?? []).isEmpty
              ? SizedBox(
                  width: Get.width,
                  height: Get.height - 200,
                  child: const Center(
                    child: Text(
                      'ไม่พบผลโหวตทั้งหมด',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    CardItem(
                      topic: 'ปักหมุด',
                      tabName: 'ทั้งหมด',
                      data: controller.mainContentsVoteModel.value.data?.pin ?? [],
                    ),
                    CardItem(
                      topic: 'ใกล้ปิดโหวต',
                      tabName: 'ทั้งหมด',
                      data: controller.mainContentsVoteModel.value.data?.closeDate ?? [],
                    ),
                    CardItem(
                      topic: 'ใกล้ปิดล่ารายชื่อ',
                      tabName: 'ทั้งหมด',
                      data: controller.mainContentsVoteModel.value.data?.closetSupport ?? [],
                    ),
                    ...List.generate(controller.mainContentsVoteModel.value.data!.hashTagVote!.length, (index) {
                      var hashTagVote = controller.mainContentsVoteModel.value.data!.hashTagVote![index];

                      return CardItem(
                        topic: hashTagVote.id ?? '',
                        tabName: 'ทั้งหมด',
                        data: hashTagVote.votingEvent,
                      );
                      /*  return ListTileItem(
                        topic: hashTagVote.id ?? '',
                        tabName: 'ทั้งหมด',
                        data: hashTagVote.votingEvent,
                      ); */
                    }).toList(),
                  ],
                )),
    );
  }
}
