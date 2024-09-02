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
import '../../../utils/log.dart';
import '../../../utils/storage_keys.dart';

class CardItem extends StatelessWidget {
  final String topic;
  final String tabName;
  final List? data;
  final bool? isResults;

  CardItem({
    Key? key,
    required this.topic,
    required this.tabName,
    required this.data,
    this.isResults = false,
  }) : super(key: key);

  MfpVoteDashboardController controller = Get.put(MfpVoteDashboardController());

  final _dateNow = DateTime.now();
  final _uid = GetStorage().read(StorageKeys.uid) ?? '';

  final double _heightCard = 400;
  final double _widthCard = 253;
  final double _heightImage = 233;
  final double _widthImage = 253;

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
                  child: Row(
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
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: GestureDetector(
                                onTap: () {
                                  _onTap(page, value, voteTimeOut, number);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    height: _heightCard,
                                    width: _widthCard,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildVoteImage(
                                          voteId: value.id ?? '',
                                          voteImage: value.voteImage ?? '',
                                          number: number,
                                          type: value.type ?? '',
                                          status: value.status ?? '',
                                          myCreated: (value?.userId ?? 'A') == _uid,
                                          close: closeVote,
                                          endDateTime: endDatetime,
                                          data: value,
                                        ),
                                        buildVoteBy(
                                          pageImage: page.imageUrl ?? '',
                                          pageName: page.name ?? '',
                                          voteTimeOut: voteTimeOut,
                                          endDateTime: endDatetime,
                                          status: value.status ?? '',
                                          close: closeVote,
                                          minminSupport: value.minSupport,
                                          countSupport: value.countSupport,
                                        ),
                                        buildVoteTitle(value.title ?? ''),
                                      ],
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
      trailing: GestureDetector(
        onTap: () {
          // TODO: View All
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
      ),
    );
  }

  Widget buildVoteImage({
    required String voteId,
    required String voteImage,
    required int number,
    required String type,
    required String status,
    required bool myCreated,
    required bool close,
    required DateTime endDateTime,
    required dynamic data,
  }) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: voteImage.isEmpty
              ? Image.asset(
                  'assets/images/vote_0$number.jpg',
                  height: _heightImage,
                  width: _widthImage,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  voteImage,
                  height: _heightImage,
                  width: _widthImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CarouselLoading(
                      height: _heightImage,
                      width: _widthImage,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/vote_0$number.jpg',
                      height: _heightImage,
                      width: _widthImage,
                      fit: BoxFit.cover,
                    );
                  },
                ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 8),
          dense: true,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 6,
                child: CircleAvatar(
                  backgroundColor: type == 'member' ? const Color(kColorCodePrimary) : const Color(kColorCodeGray),
                  radius: 5,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                type == 'member' ? 'สมาชิกพรรค' : 'ทั่วไป',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing:
              // status != 'support'
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
                      itemBuilder: (context) {
                        Log.print('close: $close');
                        Log.print('isEndVote: ${isEndVote(endDateTime)}');
                        return [
                          if (status == 'support' && !isEndVote(endDateTime))
                            const PopupMenuItem(
                              child: Text('แก้ไข'),
                              value: 'edit',
                            ),
                          const PopupMenuItem(
                            child: Text('ลบโหวต'),
                            value: 'delete',
                          ),
                        ];
                      },
                      onSelected: (value) async {
                        // TODO: แก้ไข
                        print('value: $value');

                        switch (value) {
                          case 'edit':
                            dynamic result = await Get.toNamed(
                              AppRoutes.MFP_VOTE_EDIT_VIEW,
                              arguments: {'DATA': data},
                            );

                            // controller.createItemModel.value = result['DATA'] as CreateItemModel;
                            // controller.createItemModel.refresh();

                            /* Get.toNamed(
                              AppRoutes.MFP_VOTE_EDIT,
                              arguments: {'DATA': data},
                            ); */
                            break;

                          case 'delete':
                            await controller.fetchDeleteVoting(voteId);
                            break;

                          default:
                            break;
                        }
                      },
                    ),
        ),
      ],
    );
  }

  Widget buildVoteBy({
    required String pageImage,
    required String pageName,
    required String voteTimeOut,
    required DateTime endDateTime,
    required String status,
    required bool close,
    required int minminSupport,
    required int countSupport,
  }) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: Image.network(
                pageImage,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.grey,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          title: Text(
            pageName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (status == 'support')
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 4),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    value: countSupport / minminSupport,
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: close || isEndVote(endDateTime) || isBefore1Days(endDateTime) || isBefore3Days(endDateTime) ? 8 : 0, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: close || isEndVote(endDateTime)
                          ? const Color(0xFF0085FF)
                          : isBefore1Days(endDateTime)
                              ? const Color(0xFFFFEFEF)
                              : isBefore3Days(endDateTime)
                                  ? const Color(0xFFFFF2CC)
                                  : Colors.transparent,
                    ),
                    child: Text(
                      close || isEndVote(endDateTime)
                          ? status == 'support'
                              ? 'ปิดลงชื่อแล้ว'
                              : 'ปิดโหวตแล้ว'
                          : voteTimeOut,
                      style: TextStyle(
                        color: close || isEndVote(endDateTime)
                            ? Colors.white
                            : isBefore1Days(endDateTime)
                                ? const Color(0xFFF94343)
                                : isBefore3Days(endDateTime)
                                    ? const Color(0xFFE7AD00)
                                    : Colors.grey,
                        fontSize: 12,
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                      ),
                    ),
                  ),
                  if (status == 'support')
                    RichText(
                      text: TextSpan(
                        text: '$countSupport',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 10,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '/$minminSupport',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontFamily: Assets.assetsFontsAnakotmaiMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }

  Widget buildVoteTitle(String voteTitle) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          voteTitle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            fontFamily: Assets.assetsFontsAnakotmaiMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  void _onTap(dynamic page, dynamic value, String voteTimeOut, int number) {
    Log.print('voteId: ${value.id}');
    Log.print('service: ${value.service}');
    // TODO: แก้ไขเวลา ของล่ารายชื่อ
    isResults!
        ? Get.toNamed(
            AppRoutes.MFP_VOTE_RESULTES,
            arguments: {
              'PAGE_ID': page.id,
              'PAGE_NAME': page.name ?? '',
              'PAGE_IMAGE': page.imageUrl ?? '',
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
              'PAGE_ID': page.id,
              'PAGE_NAME': page.name ?? '',
              'PAGE_IMAGE': page.imageUrl ?? '',
              'VOTE_ID': value.id,
              'VOTE_IMAGE': value.voteImage ?? '',
              'VOTE_TITLE': value.title ?? '',
              'VOTE_DETAIL': value.detail ?? '',
              'VOTE_TIME_OUT': voteTimeOut,
              'END_DATE_TIME': value.status == 'support' || value.status == 'close' ? DateTime.parse(value.endSupportDatetime ?? '') : DateTime.parse(value.endVoteDatetime ?? ''),
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
    return;
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
