// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../controllers/profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/storage_keys.dart';

class EmailProfileUser extends StatelessWidget {
  EmailProfileUser({Key? key}) : super(key: key);

  ProfileController controller = Get.put(ProfileController());

  final double _sizeImage = 136;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Card(
            shape: RoundedRectangleBorder(
              // side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: GetBuilder<ProfileController>(
              init: ProfileController(),
              initState: (_) {},
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (controller.profileImage.path.isNotEmpty)
                      ? Container(
                          height: _sizeImage,
                          width: _sizeImage,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(controller.profileImage),
                            ),
                            borderRadius: BorderRadius.circular(300.0),
                          ),
                        )
                      : (controller.profileModel.data?.imageUrl ?? '').isEmpty
                          ? Container(
                              height: _sizeImage,
                              width: _sizeImage,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(Assets.assetsImagesPlaceholderPerson),
                                ),
                                borderRadius: BorderRadius.circular(300.0),
                              ),
                            )
                          : Container(
                              height: _sizeImage,
                              width: _sizeImage,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(controller.profileModel.data!.imageUrl!),
                                ),
                                borderRadius: BorderRadius.circular(300.0),
                              ),
                            ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            controller.profileModel.data?.displayName ?? '',
            maxLines: 1,
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
          ),
          onPressed: () async {
            await Get.toNamed(AppRoutes.EDIT_PROFILE);
            controller.profileImage = GetStorage().read(StorageKeys.imagePath) != null ? File(GetStorage().read(StorageKeys.imagePath)) : File('');
            controller.update();
          },
          child: Text(
            'แก้ไขโปรไฟล์',
            style: Get.textTheme.titleLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
