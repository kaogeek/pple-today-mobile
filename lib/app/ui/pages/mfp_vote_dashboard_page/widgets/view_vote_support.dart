// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../utils/colors.dart';
import 'card_item.dart';

class ViewVoteSupport extends GetWidget<MfpVoteDashboardController> {
  ViewVoteSupport({Key? key}) : super(key: key);

  @override
  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => (controller.supportVoteModel.value.status ?? 0) == 0 && controller.supportVoteModel.value.data == null
          ? SizedBox(
              width: Get.width,
              height: Get.height - 200,
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            )
          : (controller.supportVoteModel.value.data ?? []).isEmpty
              ? SizedBox(
                  width: Get.width,
                  height: Get.height - 200,
                  child: const Center(
                    child: Text(
                      'ไม่พบผลโหวตล่ารายชื่อ',
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
                      topic: 'ล่ารายชื่อ',
                      tabName: 'ล่ารายชื่อ',
                      data: controller.supportVoteModel.value.data,
                    ),
                  ],
                )),
    );
  }
}
