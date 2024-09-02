import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../component/divider_component.dart';
import '../../../../component/loading.dart';
import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/edit_profile_controller.dart';
import '../../../../controllers/profile_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/log.dart';

class ProfileName extends GetWidget<EditProfileController> {
  ProfileName({Key? key}) : super(key: key);

  final _profileController = Get.put(ProfileController());
  final double _sizeImage = 136;

  @override
  Widget build(BuildContext context) {
    Log.print('profile: ${_profileController.profileModel.data?.imageUrl}');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: _showActionSheet,
                child: Stack(
                  children: [
                    GetBuilder<ProfileController>(
                      init: ProfileController(),
                      initState: (_) {},
                      builder: (_) {
                        return (controller.profileImage.path.isNotEmpty)
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
                            : (_profileController.profileModel.data?.imageUrl ?? '').isEmpty
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
                                        image: NetworkImage(_profileController.profileModel.data!.imageUrl!),
                                      ),
                                      borderRadius: BorderRadius.circular(300.0),
                                    ),
                                  );
                      },
                    ),
                    Container(
                      height: _sizeImage,
                      width: _sizeImage,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        borderRadius: BorderRadius.circular(300.0),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            _profileController.profileModel.data?.displayName ?? '',
            maxLines: 1,
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const DividerComponent(),
      ],
    );
  }

  void _showActionSheet() {
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              // isDefaultAction: true,
              onPressed: () async {
                Get.back(); // close action sheet
                await _imagePicker(ImageSource.gallery);
              },
              child: const Text('อัลบั้ม'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Get.back(); // close action sheet
                await _imagePicker(ImageSource.camera);
              },
              child: const Text('กล้อง'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Get.back(),
              child: const Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _imagePicker(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(
      source: source,
      maxWidth: 400,
      maxHeight: 400,
    );

    if (image == null) return;

    controller.profileImage = File(image.path);
    controller.update();

    await _submitPic();

    return;
  }

  Future<void> _submitPic() async {
    Loading.show();

    bool value = await controller.fetchEditImageProfile();

    if (value) {
      await _profileController.fetchProfileUser();
      _profileController.update();
      Loading.dismiss();
      SnackBarComponent.show(
        title: 'สำเร็จ',
        message: 'อัพเดทรูปโปรไฟล์สำเร็จ',
        type: SnackBarType.success,
      );
    } else {
      Loading.dismiss();
      SnackBarComponent.show(
        title: 'เกิดข้อผิดพลาด',
        message: 'อัพเดทรูปโปรไฟล์ไม่สำเร็จ',
        type: SnackBarType.error,
      );
    }

    return;
  }
}
