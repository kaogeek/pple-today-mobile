import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/my_dialog.dart';
import '../../../../controllers/mfp_vote_create_controller.dart';
import '../../../../data/models/create_item_model.dart';
import '../../../../data/models/file_temp_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class PerViewButton extends GetWidget<MfpVoteCreateController> {
  const PerViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              backgroundColor: kPrimaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                side: BorderSide(color: kPrimaryColor),
              ),
            ),
            child: Text(
              'ถัดไป',
              style: TextStyle(
                // fontSize: 18,
                color: Colors.white,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            onPressed: () async => await onPreview(context),
          ),
        ),
      ),
    );
  }

  Future<void> onPreview(BuildContext context) async {
    /// unfocus keyboard
    FocusScope.of(context).unfocus();

    if (controller.titleController.value.text.trim().isEmpty) {
      await MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาตั้งชื่อการโหวต',
      );
      controller.titleFocusNode.requestFocus();
      return;
    }

    if (controller.descriptionController.value.text.trim().isEmpty) {
      await MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาเพิ่มคำอธิบาย',
      );
      controller.descriptionFocusNode.requestFocus();
      return;
    }

    /*  if (controller.startDate.value == null || controller.endDate.value == null) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณากำหนดวันเริ่มโหวตและวันปิดโหวต',
      );
      return;
    } */

    FileTempModel model = await controller.createFileTemp();

    CreateItemModel data = CreateItemModel(
      title: controller.titleController.text.trim(),
      detail: controller.descriptionController.text.trim(),
      assetId: model.data?.id,
      coverPageUrl: model.data?.id == null ? null : '/file/${model.data!.id!}',
      s3CoverPageUrl: model.data == null ? null : model.data!.s3FilePath,
      approved: false,
      closed: false,
      minSupport: 500,
      countSupport: 0,
      // startVoteDatetime: controller.startDate.value!.toIso8601String(),
      // endVoteDatetime: controller.endDate.value!.toIso8601String(),
      voteDaysRange: int.parse(controller.openVoteController.value.text.trim()),
      status: 'support',
      createAsPage: controller.indexPage.value == 0 ? null : controller.userAccessPageModel.value.data![controller.indexPage.value].page!.id,
      type: controller.type.value,
      hashTag: controller.hashTagController.text.trim(),
      pin: false,
      showVoterName: controller.showVoteName.value,
      showVoteResult: controller.showVoteResult.value,
      voteItem: controller.createItemModel.value.voteItem ?? [],
    );

    dynamic result = await Get.toNamed(
      AppRoutes.MFP_VOTE_CREATE_VIEW,
      arguments: {'DATA': data},
    );

    controller.createItemModel.value = result['DATA'] as CreateItemModel;
    controller.createItemModel.refresh();
    // int resultIndex = result['INDEX_QUESTION'] as int;
    return;
  }
}
