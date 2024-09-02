// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mfp_app/app/data/models/vote_choice_model.dart';

import '../../../component/elevated_button_component.dart';
import '../../../component/my_dialog.dart';
import '../../../controllers/mfp_vote_resultes_controller.dart';
import '../../../controllers/slider_show_image_controller.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/enum.dart';

class MfpVoteResultesPage extends GetView<MfpVoteResultesController> {
  MfpVoteResultesPage({Key? key}) : super(key: key);

  @override
  MfpVoteResultesController controller = Get.put(MfpVoteResultesController());

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      backgroundColor: dashBlue,
      appBar: AppBar(
        elevation: 1,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            if (Get.currentRoute == AppRoutes.MFP_VOTE_RESULTES) Get.back();
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
      body: Obx(() => (controller.voteChoiceModel.value.data?.voteItem ?? []).isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.voteChoiceModel.value.data!.voteItem!.length,
              itemBuilder: (context, index) {
                final _data = controller.voteChoiceModel.value.data!.voteItem![index];

                int random = Random().nextInt(8) + 1;

                return _data.type == VoteChoiceType.text ? _buildVoteAnswer(index, random, _data) : _buildVoteChoice(index, random, _data);
              },
            )),
    );
  }

  Widget _buildVoteChoice(int index, int random, VoteItem _data) {
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
              /*  trailing: PopupMenuButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Text('แก้ไข'),
                                value: 'edit',
                              ),
                              const PopupMenuItem(
                                child: Text('ลบ'),
                                value: 'delete',
                              ),
                            ],
                            onSelected: (value) {
                              print('value: $value');
                            },
                          ), */
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

                int number = index2 % 3 + 1;

                int scoreTotal = _data.voteChoice!.map((e) => e.votedCount ?? 0).reduce((value, element) => value + element);

                return GestureDetector(
                  onTap: () {
                    // TODO: Voted
                    // MyDialog.defaultDialog(
                    //   content: 'ระบบ MFP Vote ยังอยู่ในระหว่างการพัฒนา'
                    //       '\nขออภัยในความไม่สะดวกค่ะ',
                    // );
                  },
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        title: Text(
                          _voteChoice.title ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          ),
                        ),
                        trailing: Text(
                          /// format number
                          _voteChoice.votedCount!.toString().replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},',
                              ),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          ),
                        ),
                      ),

                      /// percent indicator
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: (index2 + 1) == _data.voteChoice!.length ? 16 : 0,
                        ),
                        child: LinearProgressIndicator(
                          value: scoreTotal == 0 ? 0 : _voteChoice.votedCount! / scoreTotal,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(colors[number - 1]),
                        ),
                      ),
                    ],
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
              /*  trailing: PopupMenuButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Text('แก้ไข'),
                                value: 'edit',
                              ),
                              const PopupMenuItem(
                                child: Text('ลบ'),
                                value: 'delete',
                              ),
                            ],
                            onSelected: (value) {
                              print('value: $value');
                            },
                          ), */
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
                  Get.toNamed(
                    AppRoutes.SLIDER_SHOW_IMAGE,
                    arguments: SliderShowImageArguments(galleryList: [_data.image]),
                  );
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
            ElevatedButtonComponent(
              height: 46,
              padding: const EdgeInsets.all(16.0),
              borderColor: kPrimaryColor,
              labelText: 'ดูคำตอบ (${_data.votedCount ?? 0})',
              style: const TextStyle(
                fontSize: 14,
                color: kPrimaryColor,
              ),
              onPressed: () {
                if ((_data.votedCount ?? 0) == 0) {
                  MyDialog.defaultDialog(
                    title: 'ขออภัย',
                    content: 'ยังไม่มีคนตอบคำถามนี้',
                  );
                  return;
                }

                Get.toNamed(
                  AppRoutes.MFP_VOTE_ANSWERING,
                  arguments: {
                    "VOTE_ID": _data.id,
                    "VOTE_TITLE": _data.title,
                    "VOTE_IMAGE": _data.image,
                    "NUMBER": random,
                    "SHOW_VOTER_NAME": controller.showVoterName ?? false,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
