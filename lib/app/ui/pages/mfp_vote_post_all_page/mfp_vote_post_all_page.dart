// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../component/carouse_loading.dart';
import '../../../component/convert_time_componenet.dart';
import '../../../controllers/mfp_vote_dashboard_controller.dart';
import '../../../controllers/mfp_vote_post_all_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/storage_keys.dart';
import 'widgets/appbar_vote_post_all.dart';

class MfpVotePostAllPage extends GetView<MfpVotePostAllController> {
  MfpVotePostAllPage({Key? key, this.isResults = false}) : super(key: key);

  final bool isResults;

  @override
  MfpVotePostAllController controller = Get.put(MfpVotePostAllController());
  MfpVoteDashboardController mainController = Get.put(MfpVoteDashboardController());

  final _dateNow = DateTime.now();
  final _uid = GetStorage().read(StorageKeys.uid) ?? '';

  double get widthImage => 120;
  double get heightImage => 156;
  double get sizePage => 36;

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: const AppBarVotePostAll(),
      body: GetBuilder<MfpVotePostAllController>(
        init: MfpVotePostAllController(),
        initState: (_) {},
        builder: (_) {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              dynamic items = controller.data[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Topic
                    if (index == 0) buildTopic(),

                    /// Vote List
                    buildVoteListTile(
                      index,
                      items,
                      (items.userId ?? 'A') == _uid,
                    ),

                    /// Load More
                    /// ถ้า index ตรงกับตำแหน่งสุดท้ายของข้อมูล ให้แสดง CircularProgressIndicator()
                    if (index == controller.data.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          height: kToolbarHeight,
                          child: Center(
                            child: controller.isLoadMoreRunning
                                ? const CircularProgressIndicator()
                                : controller.isFinalLoadMore
                                    ? const Text('ไม่มีข้อมูลเพิ่มเติมแล้ว')
                                    : const SizedBox(),
                          ),
                        ),
                      )
                  ],
                ),
              );
            },
          );
        },
      ),
      /* SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          children: [
            buildTopic(),
            GetBuilder<MfpVotePostAllController>(
              init: MfpVotePostAllController(),
              initState: (_) {},
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: controller.data.asMap().entries.map((e) {
                      int index = e.key;
                      dynamic data = e.value;

                      return buildVoteListTile(
                        index,
                        data,
                        (data.userId ?? 'A') == _uid,
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(thickness: 1),
            ),
          ],
        ),
      ), */
    );
  }

  Widget buildTopic() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        controller.topic,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
        ),
      ),
      /* trailing: Text(
        'ทั้งหมด (${controller.data.length})',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
        ),
      ), */
    );
  }

  Widget buildVoteListTile(int index, dynamic data, bool myCreated) {
    int number = index % 8 + 1;

    dynamic page = data.user ?? data.page;
    dynamic endDatetime;
    late String voteTimeOut;
    late bool closeVote;

    if (data.status == 'close') {
      closeVote = data.closed as bool;
      endDatetime = DateTime.parse(data.endSupportDatetime!);
      voteTimeOut = 'ปิดโหวตแล้ว';
    } else if (data.status == 'support') {
      closeVote = data.closed as bool;
      endDatetime = DateTime.parse(data.endSupportDatetime!);
      voteTimeOut = 'ปิดลงชื่อใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';
    } else {
      closeVote = data.closed as bool;
      endDatetime = DateTime.parse(data.endVoteDatetime!);
      voteTimeOut = 'ปิดโหวตใน ${ConvertTimeComponenet.between(endDatetime.toLocal(), _dateNow.toLocal())}';
    }

    return GestureDetector(
      onTap: () {
        debugPrint('VOTE_ID: ${data.id}', wrapWidth: 1024);

        isResults
            ? Get.toNamed(
                AppRoutes.MFP_VOTE_RESULTES,
                arguments: {
                  'PAGE_ID': page!.id,
                  'PAGE_NAME': page!.name ?? '',
                  'PAGE_IMAGE': page!.imageUrl ?? '',
                  'VOTE_ID': data.id,
                  'VOTE_IMAGE': data.voteImage ?? '',
                  'VOTE_TITLE': data.title ?? '',
                  'VOTE_DETAIL': data.detail ?? '',
                  'VOTE_TIME_OUT': voteTimeOut,
                  'MEMBER_TYPE': (data.type ?? '') == 'member',
                  'NUMBER': number,
                },
              )
            : Get.toNamed(
                AppRoutes.MFP_VOTE_DETAIL,
                arguments: {
                  'PAGE_ID': page!.id,
                  'PAGE_NAME': page!.name ?? '',
                  'PAGE_IMAGE': page!.imageUrl ?? '',
                  'VOTE_ID': data.id,
                  'VOTE_IMAGE': data.voteImage ?? '',
                  'VOTE_TITLE': data.title ?? '',
                  'VOTE_DETAIL': data.detail ?? '',
                  'VOTE_TIME_OUT': voteTimeOut,
                  'END_DATE_TIME': data.status == 'support' ? DateTime.parse(data.endSupportDatetime ?? '') : DateTime.parse(data.endVoteDatetime ?? ''),
                  'STATUS': data.status ?? '',
                  'HASHTAG': data.hashTag ?? '',
                  'CLOSE': data.closed ?? false,
                  'SERVICE': data.service ?? '',
                  'MEMBER_TYPE': (data.type ?? '') == 'member',
                  'MY_SUPPORT': data.userSupport ?? false,
                  'MIN_SUPPORT': data.minSupport,
                  'COUNT_SUPPORT': data.countSupport,
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
                    data.voteImage ?? '',
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
                            backgroundColor: data.type == 'member' ? const Color(kColorCodePrimary) : const Color(kColorCodeGray),
                            radius: 5,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          data.type == 'member' ? 'สมาชิกพรรค' : 'ทั่วไป',
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
                            data.user == null ? data.page?.imageUrl ?? '' : data.user?.imageUrl ?? '',
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
                            data.user == null ? data.page?.name ?? '' : data.user!.name ?? '',
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
                                  ? data.status == 'support'
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
                                          arguments: {'DATA': data},
                                        );
                                        break;

                                      case 'delete':
                                        await mainController.fetchDeleteVoting(data.id ?? '');
                                        controller.data.removeAt(index);
                                        controller.update();
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
                        data.title ?? '',
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
