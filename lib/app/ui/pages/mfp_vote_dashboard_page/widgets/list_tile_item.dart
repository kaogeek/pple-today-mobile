// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/carouse_loading.dart';
import '../../../../component/convert_time_componenet.dart';
import '../../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../../data/models/vote_main_contents_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/log.dart';
import '../../../utils/storage_keys.dart';

class ListTileItem extends StatelessWidget {
  final String topic;
  final String tabName;
  final List? data;
  final bool? isResults;

  ListTileItem({
    Key? key,
    required this.topic,
    required this.tabName,
    required this.data,
    this.isResults = false,
  }) : super(key: key);

  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  final _dateNow = DateTime.now();
  final _uid = GetStorage().read(StorageKeys.uid) ?? '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTopic(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: data!.asMap().entries.map((e) {
                int index = e.key;
                VotingEvent votingEvent = e.value;

                return buildVoteListTile(
                  index,
                  votingEvent,
                  (votingEvent.userId ?? 'A') == _uid,
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(thickness: 1),
          ),
        ],
      ),
    );
  }

  Widget buildTopic() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        topic,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
        ),
      ),
      /*  trailing: GestureDetector(
        onTap: () {
          // TODO: View All
          // Get.toNamed(
          //   AppRoutes.MFP_VOTE_POST_ALL,
          //   arguments: {
          //     'TOPIC': topic,
          //     'DATA': data,
          //     'IS_RESULTS': isResults ?? false,
          //   },
          // );
        },
        child: Text(
          'ดูทั้งหมด',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 12,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
          ),
        ),
      ), */
    );
  }

  Widget buildVoteListTile(
    int index,
    VotingEvent votingEvent,
    bool myCreated,
  ) {
    int number = Random().nextInt(8) + 1;

    DateTime endDatetime;
    late String voteTimeOut;
    late bool closeVote;

    if (votingEvent.status == 'support') {
      endDatetime = DateTime.parse(votingEvent.endSupportDatetime!);
      voteTimeOut = 'ปิดลงชื่อใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';

      closeVote = votingEvent.closed as bool;
    } else {
      endDatetime = DateTime.parse(votingEvent.endVoteDatetime!);
      voteTimeOut = 'ปิดโหวตใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';

      closeVote = votingEvent.closed as bool;
    }

    return GestureDetector(
      onTap: () {
        dynamic page = votingEvent.user ?? votingEvent.page;

        Log.print('voteId: ${votingEvent.id}');

        isResults!
            ? Get.toNamed(
                AppRoutes.MFP_VOTE_RESULTES,
                arguments: {
                  'PAGE_ID': page!.id,
                  'PAGE_NAME': page!.name ?? '',
                  'PAGE_IMAGE': page!.imageUrl ?? '',
                  'VOTE_ID': votingEvent.id,
                  'VOTE_IMAGE': votingEvent.voteImage ?? '',
                  'VOTE_TITLE': votingEvent.title ?? '',
                  'VOTE_DETAIL': votingEvent.detail ?? '',
                  'VOTE_TIME_OUT': voteTimeOut,
                  'MEMBER_TYPE': (votingEvent.type ?? '') == 'member',
                  'NUMBER': number,
                },
              )
            : Get.toNamed(
                AppRoutes.MFP_VOTE_DETAIL,
                arguments: {
                  'PAGE_ID': page!.id,
                  'PAGE_NAME': page!.name ?? '',
                  'PAGE_IMAGE': page!.imageUrl ?? '',
                  'VOTE_ID': votingEvent.id,
                  'VOTE_IMAGE': votingEvent.voteImage ?? '',
                  'VOTE_TITLE': votingEvent.title ?? '',
                  'VOTE_DETAIL': votingEvent.detail ?? '',
                  'VOTE_TIME_OUT': voteTimeOut,
                  'END_DATE_TIME': votingEvent.status == 'support' ? DateTime.parse(votingEvent.endSupportDatetime ?? '') : DateTime.parse(votingEvent.endVoteDatetime ?? ''),
                  'STATUS': votingEvent.status ?? '',
                  'HASHTAG': votingEvent.hashTag ?? '',
                  'CLOSE': votingEvent.closed ?? false,
                  'SERVICE': votingEvent.service ?? '',
                  'MEMBER_TYPE': (votingEvent.type ?? '') == 'member',
                  'MY_SUPPORT': votingEvent.userSupport ?? false,
                  'MIN_SUPPORT': votingEvent.minSupport,
                  'COUNT_SUPPORT': votingEvent.countSupport,
                  'NUMBER': number,
                },
              );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  Image.network(
                    votingEvent.voteImage ?? '',
                    width: 120,
                    height: 156,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CarouselLoading(
                        width: 120,
                        height: 156,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/vote_0$number.jpg',
                        width: 120,
                        height: 156,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 6,
                          child: CircleAvatar(
                            backgroundColor: votingEvent.type == 'member' ? const Color(kColorCodePrimary) : const Color(kColorCodeGray),
                            radius: 5,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          votingEvent.type == 'member' ? 'สมาชิกพรรค' : 'ทั่วไป',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width - 120 - 40,
              height: 156,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          child: Image.network(
                            votingEvent.user == null ? votingEvent.page?.imageUrl ?? '' : votingEvent.user?.imageUrl ?? '',
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Icon(
                                Icons.person,
                                size: 36,
                                color: Colors.grey,
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 36,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            votingEvent.user == null ? votingEvent.page?.name ?? '' : votingEvent.user!.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: closeVote || isEndVote(endDatetime) || isBefore1Days(endDatetime) || isBefore3Days(endDatetime) ? 8 : 0, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: closeVote || isEndVote(endDatetime)
                                  ? const Color(0xFF0085FF)
                                  : isBefore1Days(endDatetime)
                                      ? const Color(0xFFFFEFEF)
                                      : isBefore3Days(endDatetime)
                                          ? const Color(0xFFFFF2CC)
                                          : Colors.transparent,
                            ),
                            child: Text(
                              closeVote || isEndVote(endDatetime)
                                  ? votingEvent.status == 'support'
                                      ? 'ปิดลงชื่อแล้ว'
                                      : 'ปิดโหวตแล้ว'
                                  : voteTimeOut,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: closeVote || isEndVote(endDatetime)
                                    ? Colors.white
                                    : isBefore1Days(endDatetime)
                                        ? const Color(0xFFF94343)
                                        : isBefore3Days(endDatetime)
                                            ? const Color(0xFFE7AD00)
                                            : Colors.grey,
                                fontSize: 12,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing:
                          //  votingEvent.status != 'support'
                          //     ? const SizedBox()
                          //     :
                          !myCreated
                              ? const SizedBox()
                              : PopupMenuButton(
                                  padding: EdgeInsets.zero,
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.grey.withOpacity(0.5),
                                    radius: 14,
                                    child: const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                  itemBuilder: (context) => [
                                    // const PopupMenuItem(
                                    //   child: Text('แก้ไข'),
                                    //   value: 'edit',
                                    // ),
                                    const PopupMenuItem(
                                      child: Text('ลบโหวต'),
                                      value: 'delete',
                                    ),
                                  ],
                                  onSelected: (value) async {
                                    // TODO: แก้ไข
                                    print('value: $value');

                                    switch (value) {
                                      case 'edit':
                                        Get.toNamed(
                                          AppRoutes.MFP_VOTE_EDIT,
                                          arguments: {
                                            'DATA': votingEvent,
                                          },
                                        );
                                        break;

                                      case 'delete':
                                        await controller.fetchDeleteVoting(votingEvent.id ?? '');
                                        break;

                                      default:
                                        break;
                                    }
                                  },
                                ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        votingEvent.title ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isEndVote(DateTime endVoteDateTime) {
    return endVoteDateTime.isBefore(_dateNow);
  }

  bool isBefore3Days(DateTime endVoteDateTime) {
    return endVoteDateTime.difference(_dateNow).inDays <= 3;
  }

  bool isBefore1Days(DateTime endVoteDateTime) {
    return endVoteDateTime.difference(_dateNow).inDays <= 1;
  }
}
