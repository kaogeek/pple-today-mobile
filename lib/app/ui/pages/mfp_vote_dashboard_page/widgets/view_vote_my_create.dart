// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../utils/colors.dart';
import 'card_item.dart';

class ViewVoteMyCreate extends GetWidget<MfpVoteDashboardController> {
  ViewVoteMyCreate({Key? key}) : super(key: key);

  @override
  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => (controller.voteMyCreateModel.value.status ?? 0) == 0 && controller.voteMyCreateModel.value.data == null
          ? SizedBox(
              width: Get.width,
              height: Get.height - 200,
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            )
          : (controller.voteMyCreateModel.value.data?.myVote ?? []).isEmpty &&
                  (controller.voteMyCreateModel.value.data?.myVoterSupport ?? []).isEmpty &&
                  (controller.voteMyCreateModel.value.data?.myVoted ?? []).isEmpty &&
                  (controller.voteMyCreateModel.value.data?.mySupported ?? []).isEmpty
              ? SizedBox(
                  width: Get.width,
                  height: Get.height - 200,
                  child: const Center(
                    child: Text(
                      'ไม่พบผลโหวตที่ฉันมีส่วนร่วม',
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
                      topic: 'โหวตที่ฉันสร้าง',
                      tabName: 'ที่ฉันมีส่วนร่วม',
                      data: controller.voteMyCreateModel.value.data?.myVote ?? [],
                    ),
                    CardItem(
                      topic: 'โหวตที่ฉันสร้าง\tและเปิดล่ารายชื่ออยู่',
                      tabName: 'ที่ฉันมีส่วนร่วม',
                      data: controller.voteMyCreateModel.value.data?.myVoterSupport ?? [],
                    ),
                    CardItem(
                      topic: 'ที่ฉันเคยโหวต',
                      tabName: 'ที่ฉันมีส่วนร่วม',
                      data: controller.voteMyCreateModel.value.data?.myVoted ?? [],
                    ),
                    CardItem(
                      topic: 'ที่ฉันลงชื่อให้การสนับสนุน',
                      tabName: 'ที่ฉันมีส่วนร่วม',
                      data: controller.voteMyCreateModel.value.data?.mySupported ?? [],
                    ),
                  ],
                )),
    );
  }
}
