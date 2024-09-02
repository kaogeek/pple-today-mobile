// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../component/my_dialog.dart';
import '../../../../controllers/mfp_vote_edit_view_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/enum.dart';
import '../../../utils/log.dart';

class EditVoteItme extends GetWidget<MfpVoteEditViewController> {
  EditVoteItme({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.editVoteItemModel.value.voteItem ?? []).isEmpty
        ? const SizedBox()
        : Column(
            children: [
              ...List.generate(
                controller.editVoteItemModel.value.voteItem!.length,
                (index) {
                  var _voteItem = controller.editVoteItemModel.value.voteItem![index];
                  int _random = Random().nextInt(8) + 1;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 16),
                            title: Text(
                              'คำถามที่ ${index + 1}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              ),
                            ),
                            trailing: PopupMenuButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  child: Text('แก้ไข'),
                                  value: 'edit',
                                ),
                                const PopupMenuItem(
                                  child: Text('ลบ'),
                                  value: 'delete',
                                ),
                              ],
                              onSelected: (String? value) async {
                                Log.print('value: $value');

                                switch (value) {
                                  case 'edit':
                                    dynamic result = await Get.toNamed(
                                      AppRoutes.MFP_VOTE_EDIT_ITEM,
                                      arguments: {
                                        'INDEX': index,
                                        'DATA': controller.editVoteItemModel.value,
                                      },
                                    );

                                    if (result == null) return;

                                    controller.editVoteItemModel(result);
                                    controller.editVoteItemModel.refresh();
                                    break;

                                  case 'delete':
                                    await MyDialog.defaultDialog(
                                      title: 'คุณต้องการลบคำถามนี้?',
                                      content: 'ข้อมูลที่คุณกรอกจะหายไป',
                                      textConfirm: 'ตกลง',
                                      textCancel: 'ยกเลิก',
                                      onConfirm: () {
                                        if (Get.isDialogOpen ?? false) Get.back();
                                        controller.editVoteItemModel.update((val) {
                                          if (val!.voteItem![index].id != null) {
                                            val.delete!.add(val.voteItem![index].id!);
                                          }
                                          val.voteItem!.removeAt(index);
                                        });
                                      },
                                    );
                                    break;

                                  default:
                                    break;
                                }
                              },
                            ),
                          ),
                          ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              child: (_voteItem.assetId ?? '').isEmpty
                                  ? Image.asset(
                                      'assets/images/vote_0$_random.jpg',
                                      width: Get.width,
                                      height: 240,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      ConvertImageComponent.getImages(imageURL: _voteItem.coverPageURL ?? ''),
                                      width: Get.width,
                                      height: 240,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/vote_0$_random.jpg',
                                          width: Get.width,
                                          height: 240,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              (_voteItem.title ?? '').trim(),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              ),
                            ),
                          ),
                          ...List.generate(
                            controller.editVoteItemModel.value.voteItem![index].voteChoice!.length,
                            (indexChoice) {
                              var _voteChoice = controller.editVoteItemModel.value.voteItem![index].voteChoice![indexChoice];
                              bool singleChoice = controller.editVoteItemModel.value.voteItem![index].type == VoteChoiceType.single;

                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: singleChoice
                                    ? Theme(
                                        data: ThemeData(
                                          checkboxTheme: const CheckboxThemeData(shape: CircleBorder()),
                                        ),
                                        child: CheckboxListTile(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                          controlAffinity: ListTileControlAffinity.trailing,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: Colors.black, width: 0.5),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          dense: true,
                                          selected: false,
                                          title: Text(
                                            (_voteChoice.title ?? '').trim(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                            ),
                                          ),
                                          value: false,
                                          onChanged: null,
                                        ),
                                      )
                                    : ListTile(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.black, width: 0.5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        title: Text(
                                          (_voteChoice.title ?? '').trim(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ));
  }
}
