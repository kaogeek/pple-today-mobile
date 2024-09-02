import 'dart:io';

import 'package:another_dashed_container/another_dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../component/convert_image_component.dart';
import '../../../../controllers/mfp_vote_edit_item_controller.dart';
import '../../../utils/log.dart';

class UploadCoverImage extends GetWidget<MfpVoteEditItemController> {
  const UploadCoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Log.print('path: ${controller.editItemModel.value.voteItem?[controller.index].file?.path}');
    Log.print('coverPageURL: ${controller.editItemModel.value.voteItem?[controller.index].coverPageURL}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () async {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: 50,
          );

          if (image == null) return;

          controller.editItemModel.update((val) {
            val!.voteItem![controller.index].file = File(image.path);
          });

          return;
        },
        child: Obx(() => (controller.editItemModel.value.voteItem?[controller.index].file?.path ?? '').isNotEmpty
            ? Container(
                height: 200.0,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: FileImage(
                      controller.editItemModel.value.voteItem![controller.index].file!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : (controller.editItemModel.value.voteItem?[controller.index].coverPageURL ?? '').isNotEmpty
                ? Container(
                    height: 200.0,
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          ConvertImageComponent.getImages(imageURL: controller.editItemModel.value.voteItem![controller.index].coverPageURL!),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : DashedContainer(
                    dashColor: Colors.grey.shade400,
                    borderRadius: 10.0,
                    strokeWidth: 1.0,
                    child: Container(
                      height: 200.0,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 36,
                            color: Colors.grey.shade400,
                          ),
                          Text(
                            'อัพโหลดรูปหน้าปก',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
