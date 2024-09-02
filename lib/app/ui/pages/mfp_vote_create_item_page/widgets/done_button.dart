// ignore_for_file: invalid_use_of_protected_member, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/my_dialog.dart';
import '../../../../controllers/mfp_vote_create_item_controller.dart';
import '../../../../data/models/file_temp_model.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class DoneButton extends GetWidget<MfpVoteCreateItemController> {
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
    // Log.print('indexQuestion: $indexQuestion');
    // Log.print('type: ${controller.createItemModel.value.voteItem![controller.index].typeChoice}');

    /// unfocus keyboard
    FocusScope.of(context).unfocus();

    if (controller.titleController.text.trim().isEmpty) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาตั้งคำถาม',
        onConfirm: () {
          Get.back();
          controller.titleFocusNode.requestFocus();
        },
      );
      return;
    } else {
      controller.createItemModel.update((val) {
        val!.voteItem![controller.index].titleItem = controller.createItemModel.value.voteItem![controller.index].controller!.text.trim();
      });
    }

    if ((controller.createItemModel.value.voteItem![controller.index].typeChoice != 'text') &&
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

    /*   if ((controller.createItemModel.value.voteItem![controller.index].typeChoice != 'text') &&
        controller.createItemModel.value.voteItem![controller.index].voteChoice!.where((element) => element.controller.text.trim().isNotEmpty).toList().length < 2) {
      MyDialog.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: 'กรุณาตั้งคำตอบ 2 ข้อขึ้นไป',
        onConfirm: () {
          Get.back();
          final int _index = controller.createItemModel.value.voteItem![controller.index].voteChoice!.indexWhere((element) => element.controller.text.trim().isEmpty);
          controller.createItemModel.value.voteItem![controller.index].voteChoice![_index].focusNode!.requestFocus();
        },
      );
      return;
    } */

    if (controller.createItemModel.value.voteItem![controller.index].typeChoice != 'text') {
      controller.voteChoiceModel.removeWhere((element) => element.controller.text.trim().isEmpty || (element.title ?? '').trim().isEmpty);
      /* controller.createItemModel.update((val) {
        val!.voteItem![controller.index].voteChoice!.removeWhere((element) => element.controller.text.trim().isEmpty || (element.title ?? '').trim().isEmpty);
        val.voteItem![controller.index].voteChoice!.forEach((element) {
          element.title = element.controller.text.trim();
        });
      }); */
    }

    FileTempModel model = await controller.createFileTemp(controller.coverPhoto.value.path);
    if (model.data != null) {
      controller.createItemModel.update((val) {
        val!.voteItem![controller.index].file = controller.coverPhoto.value;
        val.voteItem![controller.index].assetIdItem = model.data!.id;
        val.voteItem![controller.index].coverPageUrlItem = '/file/${model.data!.id!}';
        val.voteItem![controller.index].s3CoverPageUrlItem = model.data!.s3FilePath;
      });
    }

    controller.createItemModel.update((val) {
      val!.voteItem![controller.index].controller = controller.titleController;
      val.voteItem![controller.index].titleItem = controller.titleController.text.trim();
      val.voteItem![controller.index].voteChoice = controller.voteChoiceModel.value;
    });

    Get.back(result: controller.createItemModel.value);
    return;
  }
}
