// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/mfp_vote_edit_view_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/log.dart';

class EditTopic extends GetWidget<MfpVoteEditViewController> {
  EditTopic({super.key});

  int random = Random().nextInt(8) + 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 16),
                  trailing: PopupMenuButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text('แก้ไข'),
                        value: 'edit',
                      ),
                    ],
                    onSelected: (String? value) async {
                      Log.print('value: $value');

                      switch (value) {
                        case 'edit':
                          dynamic result = await Get.toNamed(
                            AppRoutes.MFP_VOTE_EDIT,
                            arguments: {'DATA': controller.editVoteItemModel.value},
                          );

                          if (result == null) return;

                          controller.editVoteItemModel(result);
                          controller.editVoteItemModel.refresh();

                          /* Get.back(
                              result: {'DATA': controller.editVoteItemModel.value},`
                              ); */
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
                    child: (controller.editVoteItemModel.value.coverPageUrl ?? '').isEmpty
                        ? Image.asset(
                            'assets/images/vote_0$random.jpg',
                            width: Get.width,
                            height: 360,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            ConvertImageComponent.getImages(imageURL: controller.editVoteItemModel.value.coverPageUrl!),
                            width: Get.width,
                            height: 360,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/vote_0$random.jpg',
                                width: Get.width,
                                height: 360,
                                fit: BoxFit.cover,
                              );
                            },
                          )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    (controller.editVoteItemModel.value.title ?? '').trim(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    (controller.editVoteItemModel.value.detail ?? '').trim(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
