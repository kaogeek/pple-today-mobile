// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../component/snack_bar_component.dart';
import '../../../../controllers/register_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import 'button_submit.dart';

class FormProfileImage extends StatelessWidget {
  FormProfileImage({Key? key}) : super(key: key);

  RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            const Center(
              child: Text(
                'อัพโหลดโปรไฟล์',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 56),
            CircleAvatar(
              radius: 116,
              backgroundColor: Colors.white,
              child: controller.profileImage.path.isNotEmpty
                  ? CircleAvatar(
                      radius: 108,
                      backgroundImage: FileImage(controller.profileImage),
                    )
                  : CircleAvatar(
                      radius: 108,
                      backgroundImage: AssetImage(Assets.assetsImagesPlaceholderPNG),
                    ),
            ),
            const SizedBox(height: 56),
            buttonImagePicker(
              title: 'ถ่ายภาพ',
              onPressed: () async {
                await _imagePicker(ImageSource.camera);
              },
            ),
            const SizedBox(height: 16),
            buttonImagePicker(
              title: 'เลือกรูปภาพ',
              onPressed: () async {
                await _imagePicker(ImageSource.gallery);
              },
            ),
            ButtonSubmit(
              title: 'ถัดไป',
              value: controller.profileImage.path.isNotEmpty,
              onPressed: _submitPic,
            ),
          ],
        );
      },
    );
  }

  Widget buttonImagePicker({
    required String title,
    required void Function()? onPressed,
  }) {
    return SizedBox(
      width: Get.width * .9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.red),
          ),
          primary: kPrimaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
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

    return;
  }

  void _submitPic() {
    if (controller.profileImage.path.isEmpty) {
      SnackBarComponent.show(
        title: 'กรุณาใส่รูป',
        type: SnackBarType.warning,
      );
      return;
    }

    controller.onNextPage();
    return;
  }
}
