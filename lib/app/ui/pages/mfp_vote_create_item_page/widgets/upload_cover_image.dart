import 'dart:io';

import 'package:another_dashed_container/another_dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/mfp_vote_create_item_controller.dart';

class UploadCoverImage extends GetWidget<MfpVoteCreateItemController> {
  const UploadCoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () async {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: 50,
          );

          if (image == null) return;

          controller.coverPhoto.value = File(image.path);

          // controller.createItemModel.update((val) {
          //   val!.voteItem![controller.index].file = File(image.path);
          // });

          return;
        },
        child: Obx(() => controller.coverPhoto.value.path.isNotEmpty
            ? Container(
                height: 200.0,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: FileImage(
                      controller.coverPhoto.value,
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
