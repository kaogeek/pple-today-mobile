import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/mfp_vote_edit_view_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/create_add_question_button.dart';
import 'widgets/create_next_button.dart';
import 'widgets/edit_app_bar.dart';
import 'widgets/edit_topic.dart';
import 'widgets/edit_vote_item.dart';

class MfpVoteEditViewPage extends GetView<MfpVoteEditViewController> {
  const MfpVoteEditViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      onWillPop: () {
        Get.back(
          result: {'DATA': controller.editVoteItemModel.value},
        );
        return Future.value(false);
      },
      appBar: const EditAppBar(),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Center(
          child: Column(
            children: [
              EditTopic(),
              EditVoteItme(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CreateAddAuestionButton(),
          const CreateNextButton(),
        ],
      ),
    );
  }
}
