import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/loading.dart';
import '../../../component/my_dialog.dart';
import '../../../controllers/mfp_vote_create_thx_controller.dart';
import '../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../routes/app_routes.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';

class MfpVoteCreateThxPage extends GetView<MfpVoteCreateThxController> {
  const MfpVoteCreateThxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'สร้างโหวต',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'สร้างคำขอบคุณ',
              style: TextStyle(
                fontSize: 12,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.thxController,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'ขอขอบคุณสำหรับเวลาและการโหวตของท่าน',
                    hintStyle: TextStyle(fontSize: 14.0),
                    contentPadding: EdgeInsets.all(8.0),
                    border: InputBorder.none,
                    // suffixIcon: suffixIcon,
                  ),
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 32, 0, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      backgroundColor: kPrimaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        side: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                    child: Text(
                      'สร้างโหวต',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      ),
                    ),
                    onPressed: () async {
                      controller.createItemModel.update((val) {
                        val!.service = controller.thxController.text.trim().isNotEmpty ? controller.thxController.text.trim() : 'ขอขอบคุณสำหรับเวลาและการโหวตของท่าน';
                      });

                      Loading.show();
                      await controller.fetchCreateVote().then((value) async {
                        if (value) {
                          MfpVoteDashboardController mfpVoteDashboardController = Get.put(MfpVoteDashboardController());
                          await mfpVoteDashboardController.fetchGetVotemyCreate();
                          await mfpVoteDashboardController.fetchGetVoteSupport();

                          Loading.dismiss();
                          await MyDialog.defaultDialog(
                            barrierDismissible: false,
                            title: 'สำเร็จ',
                            content: 'สร้างโหวตสำเร็จ',
                            onConfirm: () {
                              if (Get.isDialogOpen ?? false) Get.back();
                              if (Get.currentRoute == AppRoutes.MFP_VOTE_CREATE_THX) Get.back();
                              if (Get.currentRoute == AppRoutes.MFP_VOTE_CREATE_VIEW) Get.back();

                              /// loop back /mfp-vote-create-item
                              for (var i = 0; i < controller.createItemModel.value.voteItem!.length; i++) {
                                if (Get.currentRoute == AppRoutes.MFP_VOTE_CREATE_ITEM) Get.back();
                              }

                              if (Get.currentRoute == AppRoutes.MFP_VOTE_CREATE) Get.back();
                            },
                          );
                        } else {
                          Loading.dismiss();
                          await MyDialog.defaultDialog(
                            title: 'เกิดข้อผิดพลาด',
                            content: 'ไม่สามารถสร้างโหวตได้',
                          );
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
