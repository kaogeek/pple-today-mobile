// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../component/carouse_loading.dart';
import '../../../../component/convert_time_componenet.dart';
import '../../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/storage_keys.dart';

class VoteListTile extends StatelessWidget {
  final String topic;
  final String tabName;
  final List? data;
  final bool? isResults;

  VoteListTile({
    Key? key,
    required this.topic,
    required this.tabName,
    required this.data,
    this.isResults = false,
  }) : super(key: key);

  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  final _dateNow = DateTime.now();
  final _uid = GetStorage().read(StorageKeys.uid) ?? '';

  double get widthImage => 120;
  double get heightImage => 156;
  double get sizePage => 36;

  @override
  Widget build(BuildContext context) {
    return (data ?? []).isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopic(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: data!
                        .asMap()
                        .map((key, value) {
                          int number = Random().nextInt(8) + 1;

                          dynamic page = value.page ?? value.user;
                          dynamic endDatetime;
                          late String voteTimeOut;
                          late bool closeVote;

                          if (value.status == 'close') {
                            closeVote = value.closed as bool;
                            endDatetime = DateTime.parse(value.endSupportDatetime!);
                            voteTimeOut = 'ปิดโหวตแล้ว';
                          } else if (value.status == 'support') {
                            closeVote = value.closed as bool;
                            endDatetime = DateTime.parse(value.endSupportDatetime!);
                            voteTimeOut = 'ปิดลงชื่อใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';
                          } else {
                            closeVote = value.closed as bool;
                            endDatetime = DateTime.parse(value.endVoteDatetime!);
                            voteTimeOut = 'ปิดโหวตใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';
                          }

                          return MapEntry(
                            key,
                            GestureDetector(
                              onTap: () {
                                debugPrint('VOTE_ID: ${value.id}', wrapWidth: 1024);

                                isResults!
                                    ? Get.toNamed(
                                        AppRoutes.MFP_VOTE_RESULTES,
                                        arguments: {
                                          'PAGE_ID': page!.id,
                                          'PAGE_NAME': page!.name ?? '',
                                          'PAGE_IMAGE': page!.imageUrl ?? '',
                                          'VOTE_ID': value.id,
                                          'VOTE_IMAGE': value.voteImage ?? '',
                                          'VOTE_TITLE': value.title ?? '',
                                          'VOTE_DETAIL': value.detail ?? '',
                                          'VOTE_TIME_OUT': voteTimeOut,
                                          'MEMBER_TYPE': (value.type ?? '') == 'member',
                                          'NUMBER': number,
                                        },
                                      )
                                    : Get.toNamed(
                                        AppRoutes.MFP_VOTE_DETAIL,
                                        arguments: {
                                          'PAGE_ID': page!.id,
                                          'PAGE_NAME': page!.name ?? '',
                                          'PAGE_IMAGE': page!.imageUrl ?? '',
                                          'VOTE_ID': value.id,
                                          'VOTE_IMAGE': value.voteImage ?? '',
                                          'VOTE_TITLE': value.title ?? '',
                                          'VOTE_DETAIL': value.detail ?? '',
                                          'VOTE_TIME_OUT': voteTimeOut,
                                          'END_DATE_TIME': value.status == 'support' ? DateTime.parse(value.endSupportDatetime ?? '') : DateTime.parse(value.endVoteDatetime ?? ''),
                                          'STATUS': value.status ?? '',
                                          'HASHTAG': value.hashTag ?? '',
                                          'CLOSE': value.closed ?? false,
                                          'SERVICE': value.service ?? '',
                                          'MEMBER_TYPE': (value.type ?? '') == 'member',
                                          'MY_SUPPORT': value.userSupport ?? false,
                                          'MIN_SUPPORT': value.minSupport,
                                          'COUNT_SUPPORT': value.countSupport,
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
                                          value.voteImage.isEmpty
                                              ? Image.asset(
                                                  'assets/images/vote_0$number.jpg',
                                                  width: widthImage,
                                                  height: heightImage,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  value.voteImage ?? '',
                                                  width: widthImage,
                                                  height: heightImage,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (context, child, loadingProgress) {
                                                    if (loadingProgress == null) return child;
                                                    return CarouselLoading(
                                                      width: widthImage,
                                                      height: heightImage,
                                                    );
                                                  },
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/vote_0$number.jpg',
                                                      width: widthImage,
                                                      height: heightImage,
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
                                                    backgroundColor: (value.type ?? '') == 'member' ? const Color(kColorCodePrimary) : const Color(kColorCodeGray),
                                                    radius: 5,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  (value.type ?? '') == 'member' ? 'สมาชิกพรรค' : 'ทั่วไป',
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
                                      width: Get.width - widthImage - 40,
                                      height: heightImage,
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
                                                    page.imageUrl ?? '',
                                                    width: sizePage,
                                                    height: sizePage,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Icon(
                                                        Icons.person,
                                                        size: sizePage,
                                                        color: Colors.grey,
                                                      );
                                                    },
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Icon(
                                                        Icons.person,
                                                        size: sizePage,
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
                                                    page.name ?? '',
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
                                                        horizontal: closeVote || isEndVote(endDatetime) || isBefore1Days(endDatetime) || isBefore3Days(endDatetime) ? 8 : 0,
                                                        vertical: 2),
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
                                                          ? (value.status ?? '') == 'support'
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
                                                  (value?.userId ?? 'A') != _uid
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
                                                          onSelected: (_value) async {
                                                            // TODO: แก้ไข
                                                            print('value: $_value');

                                                            switch (_value) {
                                                              case 'edit':
                                                                dynamic result = await Get.toNamed(
                                                                  AppRoutes.MFP_VOTE_EDIT_VIEW,
                                                                  arguments: {'DATA': data},
                                                                );
                                                                break;

                                                              case 'delete':
                                                                await controller.fetchDeleteVoting(value.id ?? '');
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
                                                value.title ?? '',
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
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(thickness: 1),
              ),
            ],
          );
  }

  Widget buildTopic() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        topic,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
        ),
      ),
      /*  trailing: GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.MFP_VOTE_POST_ALL,
            arguments: {
              'TOPIC': topic,
              'DATA': data,
              'IS_RESULTS': isResults ?? false,
            },
          )?.then((_) {
            controller.fetchGetVoteMainContents();
            controller.fetchGetVotemyCreate();
            controller.fetchGetVoteOpen();
            controller.fetchGetVoteSupport();
            controller.fetchGetVoteResults();
          });
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
