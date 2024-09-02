import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../component/carouse_loading.dart';
import '../../../component/convert_time_componenet.dart';
import '../../../controllers/mfp_vote_seach_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/log.dart';

class MfpVoteSeachPage extends GetView<MfpVoteSeachController> {
  MfpVoteSeachPage({Key? key}) : super(key: key);

  final dateNow = DateTime.now();
  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: MainLayoutView(
        appBar: AppBar(
          elevation: 1,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              if (Get.currentRoute == AppRoutes.MFP_VOTE_SEACH) Get.back();
            },
          ),
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Obx(() => TextField(
                  controller: controller.textController.value,
                  focusNode: controller.focusNode.value,
                  autofocus: true,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'ค้นหาโหวต',
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) async {
                    _debouncer.call(() async {
                      /// dismiss keyboard
                      controller.focusNode.value.unfocus();

                      if (value.isNotEmpty) {
                        await controller.onSelectedTab(controller.indexTab.value);
                        // Loading.show();
                        // controller.searchVoteModel.value.data?.clear();
                        // controller.searchVoteModel.refresh();

                        // await controller.fetchGetVoteAll(value);
                        // Loading.dismiss();
                      } else {
                        controller.searchVoteModel.value.data?.clear();
                        controller.searchVoteModel.refresh();
                      }
                    });
                  },
                  onSubmitted: (value) async {
                    /// dismiss keyboard
                    controller.focusNode.value.unfocus();

                    if (value.isNotEmpty) {
                      await controller.onSelectedTab(controller.indexTab.value);
                      // Loading.show();
                      // controller.searchVoteModel.value.data?.clear();
                      // controller.searchVoteModel.refresh();

                      // await controller.fetchGetVoteAll(value);
                      // Loading.dismiss();
                    } else {
                      controller.searchVoteModel.value.data?.clear();
                      controller.searchVoteModel.refresh();
                    }
                  },
                )),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            indicatorPadding: const EdgeInsets.only(top: 8, bottom: 12),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: kPrimaryMFPColor,
            ),
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 12,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
            ),
            tabs: const [
              Tab(text: 'ทั้งหมด'),
              Tab(text: 'เปิดโหวต'),
              Tab(text: 'ล่ารายชื่อ'),
              Tab(text: 'ดูผลโหวต'),
            ],
            onTap: controller.onSelectedTab,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => controller.textController.value.text.isNotEmpty && (controller.searchVoteModel.value.data ?? []).isEmpty
              ? Center(
                  child: Text('ไม่พบข้อมูล "${controller.textController.value.text}" '),
                )
              : ListView.builder(
                  controller: controller.scrollController.value,
                  shrinkWrap: true,
                  itemCount: controller.searchVoteModel.value.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    int number = index % 8 + 1;

                    final _data = controller.searchVoteModel.value.data![index];

                    dynamic page = _data.page ?? _data.user;
                    dynamic voteDatetime;
                    late String voteTimeOut;
                    late bool closeVote;

                    // TODO: แก้ไขเวลา ของล่ารายชื่อ
                    if (_data.status == 'close') {
                      closeVote = _data.closed as bool;
                      voteDatetime = DateTime.parse(_data.endSupportDatetime!);
                      voteTimeOut = 'ปิดโหวตแล้ว';
                    } else if (_data.status == 'support') {
                      voteDatetime = DateTime.parse(_data.endSupportDatetime!);
                      voteTimeOut = 'ปิดลงชื่อใน ${ConvertTimeComponenet.between(voteDatetime.toLocal(), dateNow.toLocal())}';

                      closeVote = _data.closed as bool;
                    } else {
                      voteDatetime = DateTime.parse(_data.endVoteDatetime!);
                      voteTimeOut = 'ปิดโหวตใน ${ConvertTimeComponenet.between(voteDatetime.toLocal(), dateNow.toLocal())}';

                      closeVote = _data.closed as bool;
                    }

                    return GestureDetector(
                      onTap: () {
                        Log.print('voteId: ${_data.id}');

                        controller.indexTab.value == 3
                            ? Get.toNamed(
                                AppRoutes.MFP_VOTE_RESULTES,
                                arguments: {
                                  'PAGE_ID': page.id,
                                  'PAGE_NAME': page.name ?? '',
                                  'PAGE_IMAGE': page.imageUrl ?? '',
                                  'VOTE_ID': _data.id,
                                  'VOTE_IMAGE': _data.voteImage ?? '',
                                  'VOTE_TITLE': _data.title ?? '',
                                  'VOTE_DETAIL': _data.detail ?? '',
                                  'VOTE_TIME_OUT': voteTimeOut,
                                  'MEMBER_TYPE': (_data.type ?? '') == 'member',
                                  'NUMBER': number,
                                },
                              )
                            : Get.toNamed(
                                AppRoutes.MFP_VOTE_DETAIL,
                                arguments: {
                                  'PAGE_ID': page.id,
                                  'PAGE_NAME': page.name ?? '',
                                  'PAGE_IMAGE': page.imageUrl ?? '',
                                  'VOTE_ID': _data.id,
                                  'VOTE_IMAGE': _data.voteImage ?? '',
                                  'VOTE_TITLE': _data.title ?? '',
                                  'VOTE_DETAIL': _data.detail ?? '',
                                  'VOTE_TIME_OUT': voteTimeOut,
                                  'END_DATE_TIME': _data.status == 'support' ? DateTime.parse(_data.endSupportDatetime ?? '') : DateTime.parse(_data.endVoteDatetime ?? ''),
                                  'STATUS': _data.status ?? '',
                                  'HASHTAG': _data.hashTag ?? '',
                                  'CLOSE': _data.closed ?? false,
                                  'SERVICE': _data.service ?? '',
                                  'MEMBER_TYPE': (_data.type ?? '') == 'member',
                                  'MY_SUPPORT': _data.userSupport ?? false,
                                  'MIN_SUPPORT': _data.minSupport,
                                  'COUNT_SUPPORT': _data.countSupport,
                                  'NUMBER': number,
                                },
                              );
                      },
                      child: Card(
                        elevation: 2,
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
                                  (_data.voteImage ?? '').isEmpty
                                      ? Image.asset(
                                          'assets/images/vote_0$number.jpg',
                                          width: 120,
                                          height: 156,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          _data.voteImage!,
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
                                            backgroundColor: _data.type == 'member' ? const Color(kColorCodePrimary) : const Color(kColorCodeGray),
                                            radius: 5,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _data.type == 'member' ? 'สมาชิกพรรค' : 'ทั่วไป',
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
                                            _data.user == null ? _data.page?.imageUrl ?? '' : _data.user?.imageUrl ?? '',
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
                                            _data.user == null ? _data.page?.name ?? '' : _data.user!.name ?? '',
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
                                                horizontal: closeVote || isEndVote(voteDatetime) || isBefore1Days(voteDatetime) || isBefore3Days(voteDatetime) ? 8 : 0,
                                                vertical: 2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: closeVote || isEndVote(voteDatetime)
                                                  ? const Color(0xFF0085FF)
                                                  : isBefore1Days(voteDatetime)
                                                      ? const Color(0xFFFFEFEF)
                                                      : isBefore3Days(voteDatetime)
                                                          ? const Color(0xFFFFF2CC)
                                                          : Colors.transparent,
                                            ),
                                            child: Text(
                                              closeVote || isEndVote(voteDatetime)
                                                  ? _data.status == 'support'
                                                      ? 'ปิดลงชื่อแล้ว'
                                                      : 'ปิดโหวตแล้ว'
                                                  : voteTimeOut,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: closeVote || isEndVote(voteDatetime)
                                                    ? Colors.white
                                                    : isBefore1Days(voteDatetime)
                                                        ? const Color(0xFFF94343)
                                                        : isBefore3Days(voteDatetime)
                                                            ? const Color(0xFFE7AD00)
                                                            : Colors.grey,
                                                fontSize: 12,
                                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      height: 0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _data.title ?? '',
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
                  },
                )),
        ),
      ),
    );
  }

  bool isEndVote(DateTime endVoteDateTime) {
    return endVoteDateTime.isBefore(dateNow);
  }

  bool isBefore3Days(DateTime endVoteDateTime) {
    return endVoteDateTime.difference(dateNow).inDays <= 3;
  }

  bool isBefore1Days(DateTime endVoteDateTime) {
    return endVoteDateTime.difference(dateNow).inDays <= 1;
  }
}
