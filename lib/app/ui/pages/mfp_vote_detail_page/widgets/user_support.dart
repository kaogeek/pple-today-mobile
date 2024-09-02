import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_detail_controller.dart';
import '../../../utils/assets.dart';

class UserSupport extends GetWidget<MfpVoteDetailController> {
  const UserSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if ((controller.userSupportVoteModel.value.data?.userSupport ?? []).isEmpty) return const SizedBox();

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: (!(controller.voteChoiceModel.value.data?.showVoterName ?? false) && !(controller.voteChoiceModel.value.data?.showVoteResult ?? false))
                ? Text(
                    'โหวตนี้มีผู้สนับสนุนแล้วทั้งหมด ${controller.userSupportVoteModel.value.data?.count} คน',
                    style: TextStyle(
                      fontSize: context.isPhone ? 12 : 16,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                    ),
                  )
                : (!(controller.voteChoiceModel.value.data?.showVoterName ?? false) && (controller.voteChoiceModel.value.data?.showVoteResult ?? false))
                    ? Text(
                        'โหวตนี้มีผู้สนับสนุนแล้วทั้งหมด ${controller.userSupportVoteModel.value.data?.count} คน',
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
                              children: controller.userSupportVoteModel.value.data!.count! > controller.userCount
                                  ? controller.userSupportVoteModel.value.data!.userSupport!
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
                                  : controller.userSupportVoteModel.value.data!.userSupport!
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
                              controller.userSupportVoteModel.value.data!.count! <= controller.userCount
                                  ? '\t${controller.userSupportVoteModel.value.data!.userSupport!.last.user!.displayName!}'
                                      '\t...และคนเหล่านี้สนับสนุนแล้ว'
                                  : '\t${controller.userSupportVoteModel.value.data!.userSupport![4].user!.displayName!}'
                                      '\t...และอีก ${controller.userSupportVoteModel.value.data!.userSupport!.length - controller.userCount} คนโหวตแล้ว',
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
                'โหวตแล้ว (${controller.userSupportVoteModel.value.data!.userSupport!.length})',
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
                  itemCount: controller.userSupportVoteModel.value.data!.userSupport!.length,
                  itemBuilder: (context, index) {
                    var _voted = controller.userSupportVoteModel.value.data!.userSupport![index];

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
