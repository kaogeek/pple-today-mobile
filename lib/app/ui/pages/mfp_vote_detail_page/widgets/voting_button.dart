import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/mfp_dialog.dart';
import '../../../../controllers/mfp_vote_detail_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class VotingButton extends GetWidget<MfpVoteDetailController> {
  VotingButton({Key? key}) : super(key: key);

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
                child: controller.close
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            // side: BorderSide(color: kPrimaryColor),
                          ),
                        ),
                        child: Text(
                          'ดูผลโหวต',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.MFP_VOTE_RESULTES,
                            arguments: {
                              'PAGE_ID': controller.pageId,
                              'PAGE_NAME': controller.pageName,
                              'PAGE_IMAGE': controller.pageImage,
                              'VOTE_ID': controller.voteId,
                              'VOTE_IMAGE': controller.voteImage,
                              'VOTE_TITLE': controller.voteTitle,
                              'VOTE_DETAIL': controller.voteDetail,
                              'VOTE_TIME_OUT': controller.voteTimeOut,
                              'MEMBER_TYPE': controller.memberType,
                              'NUMBER': controller.number,
                              'SHOW_VOTER_NAME': controller.voteChoiceModel.value.data?.showVoterName ?? false,
                            },
                          );
                          return;
                        })
                    : Obx(() => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              // side: BorderSide(color: kPrimaryColor),
                            ),
                          ),
                          child: Text(
                            controller.close
                                ? 'ดูผลโหวต'
                                : (controller.votingOwn.value.data ?? []).isNotEmpty
                                    ? 'ดูการโหวตของคุณ'
                                    : 'เริ่มกันเลย',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.isPhone ? 16 : 20,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                            ),
                          ),
                          onPressed: () async {
                            if (controller.close) {
                              Get.toNamed(
                                AppRoutes.MFP_VOTE_RESULTES,
                                arguments: {
                                  'PAGE_ID': controller.pageId,
                                  'PAGE_NAME': controller.pageName,
                                  'PAGE_IMAGE': controller.pageImage,
                                  'VOTE_ID': controller.voteId,
                                  'VOTE_IMAGE': controller.voteImage,
                                  'VOTE_TITLE': controller.voteTitle,
                                  'VOTE_DETAIL': controller.voteDetail,
                                  'VOTE_TIME_OUT': controller.voteTimeOut,
                                  'MEMBER_TYPE': controller.memberType,
                                  'NUMBER': controller.number,
                                  'SHOW_VOTER_NAME': controller.voteChoiceModel.value.data?.showVoterName ?? false,
                                },
                              );
                              return;
                            }

                            if ((_storage.read(StorageKeys.token) ?? '').isEmpty) {
                              Get.toNamed(AppRoutes.LOGIN_REGISTER);
                              return;
                            }

                            if ((controller.votingOwn.value.data ?? []).isNotEmpty) {
                              Get.toNamed(
                                AppRoutes.MFP_VOTING_MY_POINT,
                                arguments: {
                                  'VOTE_ID': controller.voteId,
                                },
                              );
                              return;
                            }

                            if (_storage.read(StorageKeys.whiteList) ?? false) {
                              Get.toNamed(
                                AppRoutes.MFP_VOTE,
                                arguments: {
                                  'VOTE_ID': controller.voteId,
                                  'DATA': controller.voteChoiceModel.value.data!.voteItem,
                                  'SERVICE': controller.service,
                                },
                              );
                              return;
                            }

                            if (controller.memberType && !(_storage.read(StorageKeys.memberShip) ?? false)) {
                              await Mfp.memberEngagementDialog();
                              return;
                            }

                            Get.toNamed(
                              AppRoutes.MFP_VOTE,
                              arguments: {
                                'VOTE_ID': controller.voteId,
                                'DATA': controller.voteChoiceModel.value.data!.voteItem,
                                'SERVICE': controller.service,
                              },
                            );
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
