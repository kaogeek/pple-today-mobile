// ignore_for_file: must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../component/divider_component.dart';
import '../../../component/snack_bar_component.dart';
import '../../../controllers/post_detail_controller.dart';
import '../../../controllers/today_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/storage_keys.dart';
import 'widgets/post_detail_app_bat.dart';
import 'widgets/post_detail_body.dart';

class PostDetailPage extends GetView<PostDetailController> {
  PostDetailPage({Key? key}) : super(key: key);

  TodayController todayController = Get.put(TodayController());

  @override
  Widget build(BuildContext context) {
    final _isToken = (GetStorage().read(StorageKeys.token) ?? '').isNotEmpty;

    return MainLayoutView(
      body: GetBuilder<PostDetailController>(
        init: PostDetailController(),
        initState: (_) {},
        builder: (_) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                )
              : SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  bottom: _isToken,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CustomScrollView(
                        controller: controller.scrollController,
                        slivers: [
                          PostDetailAppBar(),
                          PostDetailBody(),
                        ],
                      ),
                      if (_isToken)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const DividerComponent(),
                            Container(
                              height: 58,
                              width: double.infinity,
                              color: Colors.grey.shade100,
                              child: Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(35),
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: TextField(
                                        controller: controller.commentTextController,
                                        focusNode: controller.focusNode,
                                        autofocus: controller.focus,
                                        onTap: () {
                                          500.milliseconds.delay(() {
                                            controller.maxScrollExtent();
                                          });
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(left: 18, top: 6),
                                          hintText: 'แสดงความคิดเห็น',
                                          hintStyle: TextStyle(
                                            color: primaryBlue,
                                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                            // fontSize:
                                          ),
                                        ),
                                        textInputAction: TextInputAction.send,
                                        onSubmitted: (_) => _onSendComment(),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: 1,
                                    icon: const Icon(
                                      Icons.send,
                                      size: 22,
                                      color: primaryBlue,
                                    ),
                                    onPressed: _onSendComment,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Future<void> _onSendComment() async {
    String _comment = controller.commentTextController.text;

    if (_comment.isEmpty) return;

    FocusManager.instance.primaryFocus?.unfocus();

    if (controller.isEdit) {
      controller.commentListModel.data!.forEach((element) {
        if (element.id == controller.commentId) {
          element.comment = _comment;
          controller.update();
        }
      });

      SnackBarComponent.show(
        title: 'แก้ไขความคิดเห็นสำเร็จ',
        type: SnackBarType.success,
      );

      await controller.fetchIsEditComment(
        postId: controller.postId,
        commentId: controller.commentId,
        commentText: _comment,
      );
      todayController.fetchStory(controller.postId);
      todayController.fetchPostStory();

      controller.isEdit = false;
    } else {
      controller.addComment();

      controller.fetchSendComment(
        postId: controller.postId,
        comment: _comment,
      );
    }

    controller.commentTextController.clear();
    controller.maxScrollExtent();
    controller.update();
    return;
  }
}
