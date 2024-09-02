import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_create_view_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class CreateNextButton extends GetWidget<MfpVoteCreateViewController> {
  const CreateNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  backgroundColor: kPrimaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                child: Text(
                  'ถัดไป',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                ),
                onPressed: (controller.createItemModel.value.voteItem ?? []).isEmpty
                    ? () {
                        Get.snackbar(
                          'เกิดข้อผิดพลาด',
                          'กรุณาสร้างคำถาม',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    : () async {
                        Get.toNamed(AppRoutes.MFP_VOTE_CREATE_THX, arguments: {
                          'DATA': controller.createItemModel.value,
                        });
                      },
              )),
        ),
      ),
    );
  }
}
