// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/my_dialog.dart';
import '../../../../controllers/mfp_vote_edit_controller.dart';
import '../../../../data/models/file_temp_model.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/log.dart';

class EditViewButton extends GetWidget<MfpVoteEditController> {
  const EditViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 8),
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
              'เสร็จสิ้น',
              style: TextStyle(
                color: Colors.white,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            onPressed: _onPerView,
          ),
        ),
      ),
    );
  }

  Future<void> _onPerView() async {
    if (controller.titleController.value.text.trim().isEmpty) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาตั้งชื่อการโหวต',
      );
      return;
    }

    if (controller.descriptionController.value.text.trim().isEmpty) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาเพิ่มคำอธิบาย',
      );
      return;
    }

    if (controller.openVoteController.text.trim().isEmpty) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณากำหนดจำนวนวันในการโหวต',
      );
      return;
    }

    controller.editVoteItemModel.update((val) {
      val!.title = controller.titleController.value.text;
      val.detail = controller.descriptionController.value.text;
      val.voteDaysRange = int.parse(controller.openVoteController.text);
      val.hashTag = controller.hashTagController.text.trim();
      val.type = controller.type.value;
      val.showVoteName = controller.showVoteName.value;
      val.showVoteResult = controller.showVoteResult.value;
    });

    FileTempModel model = await controller.createFileTemp(controller.editVoteItemModel.value.file?.path ?? '');
    if (model.data != null) {
      controller.editVoteItemModel.update((val) {
        val!.assetId = model.data!.id;
        val.coverPageUrl = '/file/${model.data!.id!}';
        val.s3CoverPageUrl = model.data!.s3FilePath;
      });
    }

    Get.back(
      result: controller.editVoteItemModel.value,
    );
    return;
  }
}
