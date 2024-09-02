import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_detail_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class ListTileAs extends GetWidget<MfpVoteDetailController> {
  ListTileAs({Key? key}) : super(key: key);

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            // TODO: Profile User
          },
          contentPadding: context.isPhone ? EdgeInsets.zero : const EdgeInsets.only(top: 16.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: Image.network(
                controller.pageImage,
                width: context.isPhone ? 48 : 56,
                height: context.isPhone ? 48 : 56,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Icon(
                    Icons.person,
                    size: context.isPhone ? 48 : 56,
                    color: Colors.grey,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    size: context.isPhone ? 48 : 56,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          title: Text(
            controller.pageName,
            maxLines: 1,
            style: TextStyle(
              fontSize: context.isPhone ? 14 : 18,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.status == 'support')
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 4),
                  child: Obx(() => LinearProgressIndicator(
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        value: controller.countSupport.value / controller.minminSupport,
                      )),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: controller.close || isEndVote() || isBefore1Days() || isBefore3Days() ? 8 : 0, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: controller.close || isEndVote()
                          ? const Color(0xFF0085FF)
                          : isBefore1Days()
                              ? const Color(0xFFFFEFEF)
                              : isBefore3Days()
                                  ? const Color(0xFFFFF2CC)
                                  : Colors.transparent,
                    ),
                    child: Text(
                      controller.close || isEndVote()
                          ? controller.status == 'support'
                              ? 'ปิดลงชื่อแล้ว'
                              : 'ปิดโหวตแล้ว'
                          : controller.voteTimeOut,
                      style: TextStyle(
                        color: controller.close || isEndVote()
                            ? Colors.white
                            : isBefore1Days()
                                ? const Color(0xFFF94343)
                                : isBefore3Days()
                                    ? const Color(0xFFE7AD00)
                                    : Colors.grey,
                        fontSize: context.isPhone ? 12 : 16,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      ),
                    ),
                  ),
                  /*  Text(
                    controller.close || isEndVote()
                        ? controller.status == 'support'
                            ? 'ปิดลงชื่อแล้ว'
                            : 'ปิดโหวตแล้ว'
                        : controller.voteTimeOut,
                    style: TextStyle(
                      color: controller.close
                          ? Colors.grey
                          : isBefore1Days()
                              ? Colors.white
                              : isBefore3Days()
                                  ? Colors.grey
                                  : Colors.grey,
                      fontSize: 12,
                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      backgroundColor: controller.close
                          ? Colors.transparent
                          : isBefore1Days()
                              ? Colors.redAccent
                              : isBefore3Days()
                                  ? Colors.yellowAccent
                                  : Colors.transparent,
                    ),
                  ), */
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  //   decoration: BoxDecoration(
                  //     color: controller.close
                  //         ? Colors.transparent
                  //         : isBefore3Days()
                  //             ? Colors.yellowAccent
                  //             : isBefore1Days()
                  //                 ? Colors.grey.shade400
                  //                 : Colors.transparent,
                  //     borderRadius: BorderRadius.circular(4),
                  //   ),
                  //   child: Text(
                  //     controller.close || isEndVote()
                  //         ? controller.status == 'support'
                  //             ? 'ปิดลงชื่อแล้ว'
                  //             : 'ปิดโหวตแล้ว'
                  //         : controller.voteTimeOut,
                  //     style: TextStyle(
                  //       color: Colors.grey,
                  //       fontSize: 10,
                  //       fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  //     ),
                  //   ),
                  // ),
                  if (controller.status == 'support')
                    Obx(() => RichText(
                          text: TextSpan(
                            text: '${controller.countSupport.value}',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 10,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '/${controller.minminSupport}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                ),
                              ),
                            ],
                          ),
                        )),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }

  bool isEndVote() {
    return controller.endDateTime.isBefore(now);
  }

  bool isBefore3Days() {
    return controller.endDateTime.difference(now).inDays <= 3;
  }

  bool isBefore1Days() {
    return controller.endDateTime.difference(now).inDays <= 1;
  }
}
