// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/mfp_vote_create_view_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/creaste_app_bar.dart';
import 'widgets/create_add_question_button.dart';
import 'widgets/create_next_button.dart';
import 'widgets/create_topic.dart';
import 'widgets/create_vote_item.dart';

class MfpVoteCreateViewPage extends GetView<MfpVoteCreateViewController> {
  MfpVoteCreateViewPage({Key? key}) : super(key: key);

  int random = Random().nextInt(8) + 1;

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      onWillPop: () {
        Get.back(
          result: {'DATA': controller.createItemModel.value},
        );
        return Future.value(false);

        /// disable back button
        // return Future.value(true);
      },
      appBar: const CreasteAppBar(),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Center(
          child: Column(
            children: [
              CreateTopic(),
              CreateVoteItme(),
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
