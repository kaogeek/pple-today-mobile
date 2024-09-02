// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../component/my_dialog.dart';
import '../../../../controllers/mfp_vote_create_view_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/log.dart';

class CreateVoteItme extends GetWidget<MfpVoteCreateViewController> {
  CreateVoteItme({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.createItemModel.value.voteItem ?? []).isEmpty
        ? const SizedBox()
        : Column(
            children: [
              ...List.generate(
                controller.createItemModel.value.voteItem!.length,
                (index) {
                  var _voteItem = controller.createItemModel.value.voteItem![index];
                  int _random = Random().nextInt(8) + 1;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Card(
                      elevation: 1,
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
                                      AppRoutes.MFP_VOTE_CREATE_ITEM,
                                      arguments: {
                                        'INDEX': index,
                                        'DATA': controller.createItemModel.value,
                                        'IS_EDIT': true,
                                      },
                                    );

                                    if (result == null) return;

                                    controller.createItemModel.value = result;
                                    controller.createItemModel.refresh();

                                    // Get.back(result: {
                                    //   'INDEX_QUESTION': index,
                                    //   'DATA': controller.createItemModel.value,
                                    // });
                                    break;

                                  case 'delete':

                                    /// Show dialog to confirm delete
                                    await MyDialog.defaultDialog(
                                      title: 'คุณต้องการลบคำถามนี้?',
                                      content: 'ข้อมูลที่คุณกรอกจะหายไป',
                                      textConfirm: 'ตกลง',
                                      textCancel: 'ยกเลิก',
                                      onConfirm: () {
                                        if (Get.isDialogOpen ?? false) Get.back();
                                        controller.createItemModel.update((val) {
                                          val!.voteItem!.removeAt(index);
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
                              child: (_voteItem.assetIdItem ?? '').isEmpty
                                  ? Image.asset(
                                      'assets/images/vote_0$_random.jpg',
                                      width: Get.width,
                                      height: 240,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      ConvertImageComponent.getImages(imageURL: _voteItem.coverPageUrlItem ?? ''),
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
                                    )
                              /* Container(
                                    width: Get.width,
                                    height: 240,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          ConvertImageComponent.getImages(imageURL: _voteItem.coverPageUrlItem ?? ''),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ), */
                              ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _voteItem.controller!.text.trim(),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              ),
                            ),
                          ),
                          ...List.generate(
                            controller.createItemModel.value.voteItem![index].voteChoice!.length,
                            (indexChoice) {
                              var _voteChoice = controller.createItemModel.value.voteItem![index].voteChoice![indexChoice];
                              bool singleChoice = controller.createItemModel.value.voteItem![index].typeChoice == 'single';

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
