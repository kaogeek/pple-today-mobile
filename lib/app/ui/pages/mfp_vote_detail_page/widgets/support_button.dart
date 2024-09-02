import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/mfp_dialog.dart';
import '../../../../controllers/mfp_vote_detail_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class SupportButton extends GetWidget<MfpVoteDetailController> {
  SupportButton({Key? key}) : super(key: key);

  final GetStorage _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 0),
            SizedBox(
              height: context.isPhone ? 48 : 56,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.mySupport.value ? Colors.white : kPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          side: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                      child: Text(
                        controller.mySupport.value ? 'ยกเลิกสนับสนุน' : 'สนับสนุน',
                        style: TextStyle(
                          color: controller.mySupport.value ? kPrimaryColor : Colors.white,
                          fontSize: context.isPhone ? 14 : 18,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      ),
                      onPressed: () async {
                        if ((_storage.read(StorageKeys.token) ?? '').isEmpty) {
                          Get.toNamed(AppRoutes.LOGIN_REGISTER);
                          return;
                        }

                        if (_storage.read(StorageKeys.whiteList) ?? false) {
                          controller.mySupport.value ? await controller.fetchUnSupportVote() : await controller.fetchSupportVote();
                          return;
                        }

                        if (controller.memberType && !(_storage.read(StorageKeys.memberShip) ?? false)) {
                          await Mfp.memberEngagementDialog();
                          return;
                        }

                        controller.mySupport.value ? await controller.fetchUnSupportVote() : await controller.fetchSupportVote();
                        return;
                      },
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Obx(() => Text(
                    (controller.voteChoiceModel.value.data?.showVoterName ?? false) ? 'โหวตนี้มีการแสดงชื่อผู้โหวต' : 'โหวตนี้ไม่แสดงชื่อผู้โหวต',
                    style: TextStyle(
                      fontSize: context.isPhone ? 12 : 16,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
