import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as datePicker;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../component/loading.dart';
import '../../../component/snack_bar_component.dart';
import '../../../controllers/edit_profile_controller.dart';
import '../../../controllers/edit_profile_text_field_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';

class EditProfileTextFieldPage extends GetView<EditProfileTextFieldController> {
  EditProfileTextFieldPage({Key? key}) : super(key: key);

  final _profileController = Get.put(ProfileController());
  final _editController = Get.put(EditProfileController());
  final _f = DateFormat('dd MMM yyyy', 'th');
  final _f2 = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    if (controller.title == 'วันเกิด') controller.textController.text = _f.format(DateTime.parse(controller.hintText));

    return MainLayoutView(
      appBar: AppBar(
        elevation: .3,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          controller.title,
          style: Get.textTheme.headline6?.copyWith(
            color: Colors.black,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text(
              'บันทึก',
              style: Get.textTheme.bodyText1?.copyWith(
                color: kPrimaryColor,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.title == 'วันเกิด'
                  ? TextField(
                      controller: controller.textController,
                      style: Get.textTheme.bodyText1?.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: _showDatePicker,
                          icon: const Icon(
                            Icons.calendar_today,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      onTap: _showDatePicker,
                      onSubmitted: (_) {
                        _onSave();
                      },
                    )
                  : TextField(
                      focusNode: controller.focusNode,
                      controller: controller.textController,
                      style: Get.textTheme.bodyText1?.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) {
                        _onSave();
                      },
                    ),
              Text(
                'คุณสามารถเปลี่ยน${controller.title}ของคุณได้อีกครั้ง 7 วันหลังจากนี้',
                style: Get.textTheme.bodyText1?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    datePicker.DatePicker.showDatePicker(
      Get.context!,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      theme: const datePicker.DatePickerTheme(
        headerColor: Colors.white,
        backgroundColor: Colors.white,
        itemStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        cancelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      onConfirm: (date) {
        controller.textController.text = _f.format(date);
        controller.birthdayController.text = _f2.format(date);
        controller.update();
      },
      currentTime: DateTime.parse(controller.birthdayController.text),
      locale: datePicker.LocaleType.th,
    );
  }

  Future<void> _onSave() async {
    final String textInput = controller.textController.text.trim();

    if (controller.focusNode.hasFocus) {
      controller.focusNode.unfocus();
    }

    if (textInput.isEmpty) {
      SnackBarComponent.show(
        title: 'แก้ไขไม่สำเร็จ',
        message: 'กรุณากรอกข้อมูลให้ครบถ้วน',
        type: SnackBarType.error,
      );
      return;
    }

    Loading.show();
    switch (controller.title) {
      case 'ชื่อ':
        if (textInput.contains(' ')) {
          String firstName = textInput.split(' ')[0];
          String lastName = textInput.split(' ')[1];

          await _editController.fetchEditProfile(
            firstName: firstName,
            lastName: lastName,
          );
        } else {
          await _editController.fetchEditProfile(
            firstName: textInput,
          );
        }
        break;

      case 'ชื่อผู้ใช้':
        await _editController.fetchEditProfile(
          displayName: textInput,
        );
        break;

      case 'วันเกิด':
        String birthdate = controller.birthdayController.text.split(' ').first;
        await _editController.fetchEditProfile(
          birthdate: birthdate,
        );
        break;

      default:
        break;
    }
    await _profileController.fetchProfileUser();
    Loading.dismiss();

    Get.back(); // close page
    SnackBarComponent.show(
      title: 'แก้ไข${controller.title}สำเร็จ',
      type: SnackBarType.success,
    );
  }
}
