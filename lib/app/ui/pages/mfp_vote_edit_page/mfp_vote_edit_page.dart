// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/mfp_vote_edit_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/edit_as.dart';
import 'widgets/edit_hash_tag.dart';
import 'widgets/edit_setting.dart';
import 'widgets/edit_detail.dart';
import 'widgets/edit_title.dart';
import 'widgets/edit_cover_photo.dart';
import 'widgets/edit_view_button.dart';

class MfpVoteEditPage extends GetView<MfpVoteEditController> {
  MfpVoteEditPage({Key? key}) : super(key: key);

  @override
  MfpVoteEditController controller = Get.put(MfpVoteEditController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      onWillPop: () {
        Get.back(result: null);
        return Future.value(false);
      },
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            Get.back(result: null);
          },
        ),
        centerTitle: true,
        title: const Text(
          'แก้ไขโหวต',
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
              EditCoverPhoto(),
              EditTitle(),
              EditDetail(),
              EditAs(),
              EditHashTag(),
              EditSetting(),
              EditViewButton(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const EditViewButton(),
    );
  }
}
