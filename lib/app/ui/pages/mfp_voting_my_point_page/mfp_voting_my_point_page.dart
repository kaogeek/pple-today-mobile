// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/read_more_text.dart';
import '../../../controllers/mfp_voting_my_point_controller.dart';
import '../../../controllers/slider_show_image_controller.dart';
import '../../../data/models/vote_choice_model.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/enum.dart';

class MfpVotingMyPointPage extends GetView<MfpVotingMyPointController> {
  MfpVotingMyPointPage({Key? key}) : super(key: key);

  @override
  MfpVotingMyPointController controller = Get.put(MfpVotingMyPointController());

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      backgroundColor: dashBlue,
      appBar: AppBar(
        elevation: 1,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            if (Get.currentRoute == AppRoutes.MFP_VOTING_MY_POINT) Get.back();
          },
        ),
        title: const Text(
          'ผลโหวต',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() => (controller.voteChoiceModel.value.data?.voteItem ?? []).isEmpty || (controller.votingOwn.value.data ?? []).isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.voteChoiceModel.value.data!.voteItem!.length,
              itemBuilder: (context, index) {
                final _data = controller.voteChoiceModel.value.data!.voteItem![index];

                int random = Random().nextInt(8) + 1;

                return _data.type == VoteChoiceType.single
                    ? _buildSingleChoice(index, random, _data)
                    : _data.type == VoteChoiceType.multi
                        ? _buildMutiChoice(index, random, _data)
                        : _buildVoteAnswer(index, random, _data);
              },
            )),
    );
  }

  Widget _buildSingleChoice(int index, int random, VoteItem _data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 16),
              title: Text(
                'คำถามที่ ${index + 1}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _data.title ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  if ((_data.image ?? '').isNotEmpty) {
                    Get.toNamed(
                      AppRoutes.SLIDER_SHOW_IMAGE,
                      arguments: SliderShowImageArguments(galleryList: [_data.image]),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: (_data.image ?? '').isEmpty
                      ? Image.asset(
                          'assets/images/vote_0$random.jpg',
                          height: 240,
                          width: Get.width,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          _data.image!,
                          height: 240,
                          width: Get.width,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/vote_0$random.jpg',
                              height: 240,
                              width: Get.width,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),
              ),
            ),
            ...List.generate(
              _data.voteChoice!.length,
              (index2) {
                final _voteChoice = _data.voteChoice![index2];
                final _selected = controller.votingOwn.value.data!.whereType().any((element) => element.voteChoiceId == _voteChoice.id);

                final _last = index2 == _data.voteChoice!.length - 1;

                return Padding(
                  padding: _last ? const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0) : const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    color: _selected ? const Color(0xFFfff3eb) : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: _selected ? kPrimaryColor : Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Theme(
                      data: ThemeData(
                        checkboxTheme: const CheckboxThemeData(shape: CircleBorder()),
                      ),
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        controlAffinity: ListTileControlAffinity.trailing,
                        dense: true,
                        selected: _selected,
                        title: Text(
                          _voteChoice.title ?? '',
                          style: TextStyle(
                            color: _selected ? kPrimaryColor : Colors.black,
                            fontSize: 12,
                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          ),
                        ),
                        activeColor: kPrimaryColor,
                        value: _selected,
                        onChanged: (_) {
                          // choice.forEach((element) {
                          //   element.isSelect = false;
                          // });
                          // choice[key].isSelect = !_selected;
                          // controller.dataModel.refresh();

                          // controller.selectChoice(
                          //   voteChoiceType: VoteChoiceType.single,
                          //   voteItemId: value.voteItemId!,
                          //   answer: choice[key].title ?? '',
                          //   voteChoiceId: choice[key].id!,
                          //   isSelect: choice[key].isSelect ?? false,
                          // );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMutiChoice(int index, int random, VoteItem _data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 16),
              title: Text(
                'คำถามที่ ${index + 1}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _data.title ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  if ((_data.image ?? '').isNotEmpty) {
                    Get.toNamed(
                      AppRoutes.SLIDER_SHOW_IMAGE,
                      arguments: SliderShowImageArguments(galleryList: [_data.image]),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: (_data.image ?? '').isEmpty
                      ? Image.asset(
                          'assets/images/vote_0$random.jpg',
                          height: 240,
                          width: Get.width,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          _data.image!,
                          height: 240,
                          width: Get.width,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/vote_0$random.jpg',
                              height: 240,
                              width: Get.width,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),
              ),
            ),
            ...List.generate(
              _data.voteChoice!.length,
              (index2) {
                final _voteChoice = _data.voteChoice![index2];
                final _selected = controller.votingOwn.value.data!.whereType().any((element) => element.voteChoiceId == _voteChoice.id);

                final _last = index2 == _data.voteChoice!.length - 1;

                return Padding(
                  padding: _last ? const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0) : const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    color: _selected ? const Color(0xFFfff3eb) : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: _selected ? kPrimaryColor : Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      onTap: () {
                        // print('key: $key');

                        // choice[key].isSelect = !_selected;
                        // controller.dataModel.refresh();

                        // controller.selectChoice(
                        //   voteChoiceType: VoteChoiceType.multi,
                        //   voteItemId: value.voteItemId!,
                        //   answer: choice[key].title ?? '',
                        //   voteChoiceId: choice[key].id!,
                        //   isSelect: choice[key].isSelect ?? false,
                        // );
                      },
                      dense: true,
                      selected: _selected,
                      title: Text(
                        _voteChoice.title ?? '',
                        style: TextStyle(
                          color: _selected ? kPrimaryColor : Colors.black,
                          fontSize: 12,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      ),
                      trailing: Icon(
                        Icons.check,
                        color: _selected ? kPrimaryColor : Colors.transparent,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoteAnswer(int index, int random, VoteItem _data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 16),
              title: Text(
                'คำถามที่ ${index + 1}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ReadMoreText(
                _data.title ?? '',
                trimLines: 6,
                trimLength: 200,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  if ((_data.image ?? '').isNotEmpty) {
                    Get.toNamed(
                      AppRoutes.SLIDER_SHOW_IMAGE,
                      arguments: SliderShowImageArguments(galleryList: [_data.image]),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: (_data.image ?? '').isEmpty
                      ? Image.asset(
                          'assets/images/vote_0$random.jpg',
                          height: 240,
                          width: Get.width,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          _data.image!,
                          height: 240,
                          width: Get.width,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/vote_0$random.jpg',
                              height: 240,
                              width: Get.width,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: ReadMoreText(
                () {
                  try {
                    return controller.votingOwn.value.data!.whereType().firstWhere((element) => element.voteItemId == _data.id).answer ?? '';
                  } catch (e) {
                    return '-';
                  }
                }(),
                trimLines: 6,
                trimLength: 200,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                  fontFamily: Assets.assetsFontsAnakotmaiLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
