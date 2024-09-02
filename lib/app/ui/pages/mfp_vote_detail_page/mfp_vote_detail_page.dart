import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/read_more_text.dart';
import '../../../controllers/mfp_vote_detail_controller.dart';
import '../../utils/assets.dart';
import 'widgets/app_bar.dart';
import 'widgets/cover_image.dart';
import 'widgets/list_tile_as.dart';
import 'widgets/support_button.dart';
import 'widgets/user_support.dart';
import 'widgets/user_vote.dart';
import 'widgets/voting_button.dart';

class MfpVoteDetailPage extends GetView<MfpVoteDetailController> {
  const MfpVoteDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const CoverImage(),
            Column(
              children: [
                SizedBox(height: context.isPhone ? 400 : 600),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTileAs(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ReadMoreText(
                            controller.voteTitle,
                            trimLines: 6,
                            trimLength: 200,
                            style: TextStyle(
                              fontSize: context.isPhone ? 16 : 24,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                            ),
                          ),
                        ),
                        ReadMoreText(
                          controller.voteDetail,
                          trimLines: 6,
                          trimLength: 200,
                          style: TextStyle(fontSize: context.isPhone ? 14 : 18),
                        ),
                        if (controller.hashTag.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.only(top: 32),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Text(
                              '#' + controller.hashTag,
                              style: TextStyle(
                                fontSize: context.isPhone ? 12 : 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.status == 'support' ? const UserSupport() : const UserVote(),
          controller.status == 'support' ? SupportButton() : VotingButton(),
        ],
      ),
    );
  }
}
