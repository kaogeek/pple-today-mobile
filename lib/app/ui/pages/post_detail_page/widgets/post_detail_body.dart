// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/button_social.dart';
import '../../../../component/check_member_ship.dart';
import '../../../../component/divider_component.dart';
import '../../../../controllers/post_detail_controller.dart';
import '../../../../controllers/today_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/environment.dart';
import '../../../utils/storage_keys.dart';
import 'post_detail_comment_view.dart';
import 'post_detail_view.dart';

class PostDetailBody extends StatelessWidget {
  PostDetailBody({Key? key}) : super(key: key);

  PostDetailController controller = Get.put(PostDetailController());
  TodayController todayController = Get.find();

  final _token = GetStorage().read(StorageKeys.token) ?? '';

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          PostDetailView(),
          ButtonSocial(
            isLike: controller.storyModel.data!.first.isLike ?? false,
            likeCount: controller.storyModel.data!.first.likeCount ?? 0,
            isComment: false,
            commentCount: controller.storyModel.data!.first.commentCount ?? 0,
            onTapLike: _onTapLike,
            onTapComment: _onTapComment,
            urlShare: '${Environment.domainName}/post/${controller.postId}',
          ),
          const DividerComponent(),
          PostDetailCommentView(),
          const SizedBox(height: 58),
        ],
      ),
    );
  }

  Future<void> _onTapLike() async {
    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.storyModel.data!.first.type!);
    if (!memberShip) return;

    if (todayController.timerLike != null && todayController.timerLike!.isActive) return;

    controller.storyModel.data!.first.isLike = !(controller.storyModel.data!.first.isLike ?? false);
    controller.storyModel.data!.first.likeCount = controller.storyModel.data!.first.isLike!
        ? controller.storyModel.data!.first.likeCount! + 1
        : controller.storyModel.data!.first.likeCount! > 0
            ? controller.storyModel.data!.first.likeCount! - 1
            : 0;
    controller.update();

    todayController.fetchIsLike(controller.postId).then((value) {
      if (!value) {
        controller.storyModel.data!.first.isLike = !(controller.storyModel.data!.first.isLike ?? false);
        controller.storyModel.data!.first.likeCount = controller.storyModel.data!.first.isLike!
            ? controller.storyModel.data!.first.likeCount! + 1
            : controller.storyModel.data!.first.likeCount! > 0
                ? controller.storyModel.data!.first.likeCount! - 1
                : 0;
        controller.update();
      }
    });

    return;
  }

  void _onTapComment() {
    if (_token.isEmpty) {
      Get.toNamed(AppRoutes.LOGIN_REGISTER);
      return;
    }

    bool memberShip = CheckMemberShip().get(controller.storyModel.data!.first.type!);
    if (!memberShip) return;

    controller.focusNode.requestFocus();
    500.milliseconds.delay(() => controller.maxScrollExtent());
    return;
  }
}
