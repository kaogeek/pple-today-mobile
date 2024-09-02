// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/mfp_vote_edit_item_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/done_button.dart';
import 'widgets/app_bar.dart';
import 'widgets/choice_item.dart';
import 'widgets/put_up_question.dart';
import 'widgets/upload_cover_image.dart';

class MfpVoteEditItemPage extends GetView<MfpVoteEditItemController> {
  MfpVoteEditItemPage({super.key});

  @override
  MfpVoteEditItemController controller = Get.put(MfpVoteEditItemController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      onWillPop: () {
        controller.onBack();
        return Future.value(false);
      },
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              UploadCoverImage(),
              PutUpQuestion(),
              ChoiceItem(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const DoneButton(),
    );
  }
}
