// ignore_for_file: avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/my_dialog.dart';
import '../../../../controllers/mfp_vote_edit_item_controller.dart';
import '../../../../data/models/file_temp_model.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';
import '../../../utils/log.dart';

class DoneButton extends GetWidget<MfpVoteEditItemController> {
  const DoneButton({Key? key}) : super(key: key);

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
              'เสร็จ',
              style: TextStyle(
                // fontSize: 18,
                color: Colors.white,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            onPressed: () async => await onPreview(
              context,
              controller.index,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onPreview(BuildContext context, int indexQuestion) async {
    Log.print('indexQuestion: $indexQuestion');
    Log.print('type: ${controller.editItemModel.value.voteItem![controller.index].type!.name}');

    /// unfocus keyboard
    FocusScope.of(context).unfocus();

    if (controller.editItemModel.value.voteItem![controller.index].controller!.text.trim().isEmpty) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาตั้งคำถาม',
        onConfirm: () {
          Get.back();
          controller.editItemModel.value.voteItem![controller.index].focusNode!.requestFocus();
        },
      );
      return;
    } else {
      controller.editItemModel.update((val) {
        val!.voteItem![controller.index].title = controller.editItemModel.value.voteItem![controller.index].controller!.text.trim();
      });
    }

    if ((controller.editItemModel.value.voteItem![controller.index].type != VoteChoiceType.text) &&
        controller.voteChoiceModel.where((element) => (element.title ?? '').trim().isNotEmpty).toList().length < 2) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาตั้งคำตอบ 2 ข้อขึ้นไป',
        onConfirm: () {
          Get.back();
          final int _index = controller.voteChoiceModel.indexWhere((element) => (element.title ?? '').trim().isEmpty);
          controller.voteChoiceModel[_index].focusNode!.requestFocus();
        },
      );
      return;
    }

    /* if ((controller.editItemModel.value.voteItem![controller.index].type != VoteChoiceType.text) &&
        controller.editItemModel.value.voteItem![controller.index].voteChoice!.where((element) => element.controller!.text.trim().isNotEmpty).toList().length < 2) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาตั้งคำตอบ 2 ข้อขึ้นไป',
        onConfirm: () {
          Get.back();
          final int _index = controller.editItemModel.value.voteItem![controller.index].voteChoice!.indexWhere((element) => element.controller!.text.trim().isEmpty);
          controller.editItemModel.value.voteItem![controller.index].voteChoice![_index].focusNode!.requestFocus();
        },
      );
      return;
    } */

    controller.editItemModel.update((val) {
      val!.voteItem![controller.index].voteChoice = controller.voteChoiceModel.value;
      val.deleteChoices!.addAll(controller.deleteChoices.value);
    });

    if (controller.editItemModel.value.voteItem![controller.index].type != VoteChoiceType.text) {
      controller.editItemModel.update((val) {
        val!.voteItem![controller.index].voteChoice!.removeWhere((element) => element.controller!.text.trim().isEmpty);
        val.voteItem![controller.index].voteChoice!.forEach((element) {
          element.title = element.controller!.text.trim();
        });
      });
    }

    FileTempModel model = await controller.createFileTemp(controller.editItemModel.value.voteItem![controller.index].file?.path ?? '');
    if (model.data != null) {
      controller.editItemModel.update((val) {
        val!.voteItem![controller.index].assetId = model.data!.id;
        val.voteItem![controller.index].coverPageURL = '/file/${model.data!.id!}';
        val.voteItem![controller.index].s3CoverPageUrl = model.data!.s3FilePath;
      });
    }

    Get.back(result: controller.editItemModel.value);
    return;
  }
}
