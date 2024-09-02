// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../utils/colors.dart';
import 'card_item.dart';

class ViewVoteOpen extends GetWidget<MfpVoteDashboardController> {
  ViewVoteOpen({Key? key}) : super(key: key);

  @override
  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => (controller.openVoteModel.value.status ?? 0) == 0 && controller.openVoteModel.value.data == null
          ? SizedBox(
              width: Get.width,
              height: Get.height - 200,
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            )
          : (controller.openVoteModel.value.data ?? []).isEmpty
              ? SizedBox(
                  width: Get.width,
                  height: Get.height - 200,
                  child: const Center(
                    child: Text(
                      'ไม่พบผลโหวตเปิดโหวต',
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
                      topic: 'โหวตที่เปิดอยู่',
                      tabName: 'เปิดโหวต',
                      data: controller.openVoteModel.value.data,
                    ),
                  ],
                )),
    );
  }
}
