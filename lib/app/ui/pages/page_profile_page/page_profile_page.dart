// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/page_profile_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/colors.dart';
import 'widgets/appbar_profile_page.dart';
import 'widgets/follow_page_profile_page.dart';
import 'widgets/image_profile_page.dart';
import 'widgets/last_month_profile_page.dart';
import 'widgets/loading_more_profile_page.dart';
import 'widgets/post_list.profile_page.dart';
import 'widgets/text_name_profile_page.dart';

class PageProfilePage extends GetView<PageProfileController> {
  const PageProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageProfileController>(
      init: PageProfileController(),
      initState: (_) {},
      builder: (_) {
        return MainLayoutView(
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                )
              : RefreshIndicator(
                  onRefresh: controller.onRefresh,
                  color: kPrimaryColor,
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    slivers: [
                      AppBarProfilePage(),
                      const ImageProfilePage(),
                      const TextNameProfilePage(),
                      FollowPageProfilePage(),
                      LastMonthProfilePage(),
                      PostListProfilePage(),
                      const LoadingMoreProfilePage(),
                    ],
                  ),
                ),
          floatingActionButton: controller.position <= 500
              ? null
              : FloatingActionButton.small(
                  child: const Icon(Icons.arrow_drop_up_outlined),
                  backgroundColor: kPrimaryColor,
                  onPressed: controller.topScrollExtent,
                ),
        );
      },
    );
  }
}
