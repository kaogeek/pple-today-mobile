// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/my_dialog.dart';
import '../../../controllers/mfp_vote_create_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';
import 'widgets/create_as.dart';
import 'widgets/create_cover_photo.dart';
import 'widgets/create_detail.dart';
import 'widgets/create_hash_tag.dart';
import 'widgets/create_setting.dart';
import 'widgets/create_title.dart';
import 'widgets/per_view_button.dart';

class MfpVoteCreatePage extends GetView<MfpVoteCreateController> {
  MfpVoteCreatePage({Key? key}) : super(key: key);

  @override
  MfpVoteCreateController controller = Get.put(MfpVoteCreateController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      onWillPop: () {
        _onBack();
        return Future.value(false);
      },
      backgroundColor: dashBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: _onBack,
        ),
        centerTitle: true,
        title: const Text(
          'สร้างโหวต',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              CreateCoverPhoto(),
              CreateTitle(),
              CreateDetail(),
              CreateAs(),
              CreateHashTag(),
              CreateSetting(),
              PerViewButton(),
              // CreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onBack() async {
    if (controller.titleController.text.isNotEmpty || controller.descriptionController.text.isNotEmpty) {
      await MyDialog.defaultDialog(
        title: 'คุณต้องการยกเลิกการสร้างโหวต?',
        content: 'ข้อมูลที่คุณกรอกจะหายไป',
        textConfirm: 'ตกลง',
        textCancel: 'ยกเลิก',
        onConfirm: () {
          if (Get.isDialogOpen ?? false) Get.back();
          if (Get.currentRoute == AppRoutes.MFP_VOTE_CREATE) Get.back();
        },
      );
      return;
    }

    Get.back();
    return;
  }
}
