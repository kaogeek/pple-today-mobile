// ignore_for_file: must_be_immutable, avoid_function_literals_in_foreach_calls, library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as datePicker;
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:intl/intl.dart';
import 'package:mfp_app/app/ui/utils/enum.dart';

import '../../../../controllers/register_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/environment.dart';
import '../../../utils/formatter.dart';
import '../../../utils/log.dart';
import 'button_submit.dart';

class FormInputDetail extends StatelessWidget {
  FormInputDetail({Key? key}) : super(key: key);

  RegisterController controller = Get.put(RegisterController());

  final _f = DateFormat('yyyy-MM-dd');
  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'โปรไฟล์',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          _buildGeneral(),
          _buildPersonal(),
          _buildOther(),
          SizedBox(
            height: 56,
            child: Center(
              child: GetBuilder<RegisterController>(
                init: RegisterController(),
                initState: (_) {},
                builder: (_) {
                  return Text(
                    controller.errorMassage,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
          GetBuilder<RegisterController>(
            init: RegisterController(),
            initState: (_) {},
            builder: (_) {
              return ButtonSubmit(
                title: 'ถัดไป',
                value: controller.isVelidateInputDetail,
                onPressed: _submitInfo,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGeneral() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'ข้อมูลทั่วไป',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[300],
            ),
          ),
        ),
        SizedBox(height: Get.height * .04),
        _buildTextField(
          controller: controller.displayNameTextController,
          hintText: 'ชื่อที่ต้องการแสดง',
          onChanged: _onChanged,
        ),
        _buildTextField(
          controller: controller.uniqueIdTextController,
          inputFormatters: Formatter.inputUserName,
          hintText: '@ ยูสเซอร์เนม',
          onChanged: (String value) {
            controller.errorMassage = '';
            controller.isChangedUniqueId = true;
            controller.update();

            if (value.isNotEmpty) {
              _debouncer.call(() async {
                await controller.fetchCheckUniqueId(value);
                controller.isChangedUniqueId = false;
                controller.update();
              });
            }
          },
          prefixIcon: const Icon(
            Icons.alternate_email_rounded,
            size: 18,
            color: textGrey,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: GetBuilder<RegisterController>(
            init: RegisterController(),
            initState: (_) {},
            builder: (_) {
              return Text(
                '${Environment.domainName}/@${controller.uniqueIdTextController.text}',
                style: TextStyle(
                  fontSize: 12,
                  color: controller.uniqueIdTextController.text.isEmpty || controller.isChangedUniqueId
                      ? Colors.grey.shade300
                      : controller.isValidUniqueId
                          ? Colors.green
                          : Colors.red,
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GetBuilder<RegisterController>(
            init: RegisterController(),
            initState: (_) {},
            builder: (_) {
              return Text(
                controller.uniqueIdTextController.text.isEmpty || controller.isChangedUniqueId
                    ? 'ยูสเซอร์เนมจะถูกใช้เป็น URL ของคุณ'
                    : controller.isValidUniqueId
                        ? 'ยูสเซอร์เนมนี้สามารถใช้ได้'
                        : 'ยูสเซอร์เนมนี้มีคนใช้แล้ว',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPersonal() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Get.height * .04,
            bottom: Get.height * .04,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ข้อมูลส่วนตัว',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        controller.arguments?.type == ModeType.apple
            ? const SizedBox()
            : _buildTextField(
                controller: controller.firstNameTextController,
                hintText: 'ชื่อ',
                onChanged: _onChanged,
              ),
        controller.arguments?.type == ModeType.apple
            ? const SizedBox()
            : _buildTextField(
                controller: controller.lastNameTextController,
                hintText: 'นามสกุล',
                onChanged: _onChanged,
              ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.all(5),
          width: Get.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.2,
              color: Colors.black12,
            ),
            color: Colors.white,
          ),
          child: GetBuilder<RegisterController>(
            init: RegisterController(),
            initState: (_) {},
            builder: (_) {
              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                  items: controller.provinceModel.data!.map<DropdownMenuItem<String>>(
                    (value) {
                      return DropdownMenuItem(
                        child: Text(
                          value.nameTh!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: value.nameTh!,
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    controller.provinceModel.data!.forEach((element) {
                      if (element.nameTh == value) {
                        controller.provinceId = element.id!;
                        controller.provinceName = element.nameTh!;
                      }
                    });
                    _onChanged(value.toString());
                  },
                  hint: const Text(
                    'กรุณาเลือกจังหวัด',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: controller.provinceName,
                ),
              );
            },
          ),
        ),
        controller.arguments?.type == ModeType.apple
            ? const SizedBox()
            : _buildTextField(
                controller: controller.emailTextController,
                hintText: 'อีเมล',
                readOnly: controller.emailTextController.text.isNotEmpty,
                enabled: controller.emailTextController.text.isEmpty,
                onChanged: _onChanged,
              ),
      ],
    );
  }

  Widget _buildOther() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Get.height * .04,
            bottom: Get.height * .04,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'อื่นๆ',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        _buildTextField(
          controller: controller.birthdayTextController,
          hintText: 'วันเกิด',
          onChanged: _onChanged,
          readOnly: true,
          suffixIcon: IconButton(
            onPressed: () {
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
                  controller.birthdayTextController.text = _f.format(date);
                  controller.errorMassage = '';
                  controller.update();
                },
                currentTime: DateTime.now(),
                locale: datePicker.LocaleType.th,
              );
            },
            icon: const Icon(
              Icons.calendar_today,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
    Widget? prefixIcon,
    required String hintText,
    required void Function(String)? onChanged,
    Widget? suffixIcon,
    bool readOnly = false,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: !enabled && readOnly ? lightGrey : Colors.white,
          border: Border.all(
            width: 1.2,
            color: Colors.black12,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextField(
          controller: controller,
          inputFormatters: inputFormatters,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.symmetric(
              vertical: Get.height / 100 * 2.5,
              horizontal: Get.width / 100 * 2.5,
            ),
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
          keyboardType: TextInputType.text,
          autocorrect: false,
          readOnly: readOnly,
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _onChanged(String value) {
    controller.isVelidateInputDetail = controller.displayNameTextController.text.isNotEmpty &&
        controller.uniqueIdTextController.text.isNotEmpty &&
        controller.isValidUniqueId &&
        controller.firstNameTextController.text.isNotEmpty &&
        controller.lastNameTextController.text.isNotEmpty &&
        (controller.provinceId != 0) &&
        controller.emailTextController.text.isNotEmpty;

    controller.errorMassage = '';
    controller.update();
  }

  Future<void> _submitInfo() async {
    if (controller.displayNameTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่ชื่อที่ต้องการแสดง';
      controller.update();
      return;
    }

    if (controller.uniqueIdTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่ยูสเซอร์เนม';
      controller.update();
      return;
    }

    if (!controller.isValidUniqueId) {
      controller.errorMassage = 'ยูสเซอร์เนมนี้มีคนใช้แล้ว';
      controller.update();
      return;
    }

    if (controller.firstNameTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่ชื่อ';
      controller.update();
      return;
    }

    if (controller.lastNameTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่นามสกุล';
      controller.update();
      return;
    }

    if (controller.provinceId == 0) {
      controller.errorMassage = 'กรุณาเลือกจังหวัด';
      controller.update();
      return;
    }

    // if (controller.genderTextCtrl.text.isEmpty) {
    //   controller.errorMassage = 'กรุณาใส่เพศ';
    //   return;
    // }

    if (controller.emailTextController.text.isEmpty) {
      controller.errorMassage = 'กรุณาใส่อีเมล';
      controller.update();
      return;
    } else if (!controller.emailTextController.text.isEmail) {
      controller.errorMassage = 'กรุณาใส่อีเมลให้ถูกต้อง';
      controller.update();
      return;
    }

    controller.errorMassage = '';
    controller.update();
    Log.print('Type: ${controller.arguments?.type}');
    Log.print('Email: ${controller.arguments?.email}');
    Log.print('Name: ${controller.arguments?.name}');
    Log.print('Picture: ${controller.arguments?.imagePath}');

    Get.toNamed(
      AppRoutes.REGISTER_PREVIEW,
      arguments: controller.arguments,
    );
    return;
  }
}
