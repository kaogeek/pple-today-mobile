import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_detail_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/log.dart';

class UserVote extends GetWidget<MfpVoteDetailController> {
  const UserVote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if ((controller.voteChoiceModel.value.data?.voteCount ?? 0) == 0) return const SizedBox();

      Log.print('showVoterName: ${controller.voteChoiceModel.value.data?.showVoterName}');
      Log.print('showVoteResult: ${controller.voteChoiceModel.value.data?.showVoteResult}');

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: (!(controller.voteChoiceModel.value.data?.showVoterName ?? false) && !(controller.voteChoiceModel.value.data?.showVoteResult ?? false))
                ? Text(
                    'โหวตนี้มีผู้โหวตแล้วทั้งหมด ${controller.voteChoiceModel.value.data?.voteCount} คน',
                    style: TextStyle(
                      fontSize: context.isPhone ? 12 : 16,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    ),
                  )
                : (!(controller.voteChoiceModel.value.data?.showVoterName ?? false) && (controller.voteChoiceModel.value.data?.showVoteResult ?? false))
                    ? Text(
                        'โหวตนี้มีผู้โหวตแล้วทั้งหมด ${controller.voteChoiceModel.value.data?.voteCount} คน',
                        style: TextStyle(
                          fontSize: context.isPhone ? 12 : 16,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      )
                    // : (controller.voteChoiceModel.value.data?.showVoterName ?? false) || (controller.voteChoiceModel.value.data?.showVoteResult ?? false)
                    //     ? Text(
                    //         'โหวตนี้มีผู้โหวตแล้วทั้งหมด ${controller.voteChoiceModel.value.data?.voteCount} คน',
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    //         ),
                    //       )
                    : GestureDetector(
                        onTap: () {
                          _onTap(context);
                        },
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: controller.voteChoiceModel.value.data!.voteCount! > controller.userCount
                                  ? controller.voteChoiceModel.value.data!.voted!
                                      .sublist(0, controller.userCount)
                                      .asMap()
                                      .map((index, e) {
                                        return MapEntry(
                                          index,
                                          Padding(
                                            padding: EdgeInsets.only(left: index * 20.0),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                radius: 16,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(
                                                    e.user!.imageUrl!,
                                                    width: 32,
                                                    height: 32,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return const Icon(
                                                        Icons.person,
                                                        size: 32,
                                                        color: Colors.grey,
                                                      );
                                                    },
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return const Icon(
                                                        Icons.person,
                                                        size: 32,
                                                        color: Colors.white,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                      .values
                                      .toList()
                                  : controller.voteChoiceModel.value.data!.voted!
                                      .asMap()
                                      .map((index, e) {
                                        return MapEntry(
                                          index,
                                          Padding(
                                            padding: EdgeInsets.only(left: index * 20.0),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                radius: 16,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(
                                                    e.user!.imageUrl!,
                                                    width: 32,
                                                    height: 32,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return const Icon(
                                                        Icons.person,
                                                        size: 32,
                                                        color: Colors.white,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                      .values
                                      .toList(),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller.voteChoiceModel.value.data!.voteCount! <= controller.userCount
                                  ? '\t${controller.voteChoiceModel.value.data!.voted!.last.user!.displayName!}'
                                      '\t...และคนเหล่านี้โหวตแล้ว'
                                  : '\t${controller.voteChoiceModel.value.data!.voted![4].user!.displayName!}'
                                      '\t...และอีก ${controller.voteChoiceModel.value.data!.voted!.length - controller.userCount} คนโหวตแล้ว',
                              style: TextStyle(
                                fontSize: context.isPhone ? 12 : 16,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      );
    });
  }

  void _onTap(BuildContext context) {
    /// Show BottomSheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: Get.height * 0.8,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                'โหวตแล้ว (${controller.voteChoiceModel.value.data!.voted!.length})',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 0),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(height: 0);
                  },
                  padding: EdgeInsets.zero,
                  itemCount: controller.voteChoiceModel.value.data!.voted!.length,
                  itemBuilder: (context, index) {
                    var _voted = controller.voteChoiceModel.value.data!.voted![index];

                    return ListTile(
                      onTap: () {
                        // TODO: Profile User
                      },
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 16,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              _voted.user!.imageUrl!,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        _voted.user!.displayName!,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
