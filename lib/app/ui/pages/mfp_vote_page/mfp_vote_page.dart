// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/carouse_loading.dart';
import '../../../controllers/mfp_vote_controller.dart';
import '../../../controllers/slider_show_image_controller.dart';
import '../../../data/models/vote_choice_model.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import '../../utils/assets.dart';
import '../../utils/colors.dart';
import '../../utils/enum.dart';

class MfpVotePage extends GetView<MfpVoteController> {
  const MfpVotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _heightImage = context.isPhone ? 422 : 622;
    final double _widthImage = Get.width;

    return MainLayoutView(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: () {
                if (Get.currentRoute == AppRoutes.MFP_VOTE) Get.back();
              },
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          /*  Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async {
                // TODO: Share URL & Subject
                try {
                  final box = context.findRenderObject() as RenderBox?;

                  await Share.share(
                    'https://pub.dev/packages/share_plus',
                    subject: 'share_plus',
                    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                  );
                } catch (_) {
                  await Share.share(
                    'https://pub.dev/packages/share_plus',
                    subject: 'share_plus',
                  );
                }
              },
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ), */
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if ((controller.dataModel.value.data!.voteItem![controller.index].image ?? '').isNotEmpty) {
                  Get.toNamed(
                    AppRoutes.SLIDER_SHOW_IMAGE,
                    arguments: SliderShowImageArguments(galleryList: [controller.dataModel.value.data!.voteItem![controller.index].image]),
                  );
                }
              },
              child: Container(
                decoration: const BoxDecoration(color: kPrimaryColor),
                child: Obx(() {
                  bool _endPage = (controller.dataModel.value.data!.voteItem!.length + 1 == controller.index + 1);

                  if (_endPage) {
                    return Image.asset(
                      Assets.assetsIconPpleIconTransparentW,
                      height: _heightImage,
                      width: _widthImage,
                    );
                  }

                  return (controller.dataModel.value.data!.voteItem![controller.index].image ?? '').isNotEmpty
                      ? Image.network(
                          controller.dataModel.value.data!.voteItem![controller.index].image!,
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
                              'assets/images/vote_0${controller.number}.jpg',
                              height: _heightImage,
                              width: _widthImage,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/images/vote_0${controller.number}.jpg',
                          height: _heightImage,
                          width: _widthImage,
                          fit: BoxFit.cover,
                        );
                }),
              ),
            ),
            Column(
              children: [
                SizedBox(height: context.isPhone ? 400 : 600),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Obx(() => Text(
                                (controller.dataModel.value.data!.voteItem!.length + 1 == controller.index + 1)
                                    ? controller.service
                                    : controller.dataModel.value.data?.voteItem?[controller.index].title ?? '',
                                style: TextStyle(
                                  fontSize: context.isPhone ? 18 : 24,
                                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                ),
                              )),
                        ),
                        Obx(() {
                          bool _endPage = (controller.dataModel.value.data!.voteItem!.length + 1 == controller.index + 1);

                          if (_endPage) return const SizedBox();

                          if ((controller.dataModel.value.data!.voteItem![controller.index].type ?? VoteChoiceType.single) == VoteChoiceType.text) {
                            return _buildTextBox(
                              voteItemId: controller.dataModel.value.data!.voteItem![controller.index].id ?? '',
                            );
                          }

                          if ((controller.dataModel.value.data!.voteItem![controller.index].voteChoice ?? []).isEmpty) {
                            return const SizedBox(
                              child: Text('ไม่มีข้อมูล'),
                            );
                          }

                          return Column(
                            children: (controller.dataModel.value.data!.voteItem![controller.index].voteChoice!)
                                .asMap()
                                .map((key, value) {
                                  bool _single = (controller.dataModel.value.data!.voteItem![controller.index].type ?? VoteChoiceType.single) == VoteChoiceType.single;
                                  List<VoteChoice> _choice = (controller.dataModel.value.data!.voteItem![controller.index].voteChoice ?? []);

                                  return _single
                                      ? (_choice[key].image ?? '').isEmpty
                                          ? _buildSingleChoice(
                                              context,
                                              key: key,
                                              value: value,
                                              choice: _choice,
                                            )
                                          : _buildSingleChoiceHasImage(
                                              context,
                                              key: key,
                                              value: value,
                                              choice: _choice,
                                            )
                                      : (_choice[key].image ?? '').isEmpty
                                          ? _buildMultipleChoice(
                                              context,
                                              key: key,
                                              value: value,
                                              choice: _choice,
                                            )
                                          : _buildMultipleChoiceHasImage(
                                              context,
                                              key: key,
                                              value: value,
                                              choice: _choice,
                                            );
                                })
                                .values
                                .toList(),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(height: 0),
              SizedBox(
                height: context.isPhone ? 48 : 56,
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Obx(() {
                    bool _endPage = (controller.dataModel.value.data!.voteItem!.length + 1 == controller.index + 1);

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      child: Text(
                        _endPage ? 'เสร็จสิ้น' : 'ถัดไป',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.isPhone ? 16 : 20,
                          fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        ),
                      ),
                      onPressed: _endPage
                          ? () async {
                              controller.fetchSendVotePoint();

                              if (Get.currentRoute == AppRoutes.MFP_VOTE) Get.back();
                              if (Get.currentRoute == AppRoutes.MFP_VOTE_DETAIL) Get.back();
                            }
                          : (controller.dataModel.value.data!.voteItem![controller.index].type ?? VoteChoiceType.single) == VoteChoiceType.text
                              ? () {
                                  controller.selectChoice(
                                    voteChoiceType: VoteChoiceType.text,
                                    voteItemId: controller.dataModel.value.data!.voteItem![controller.index].id ?? '',
                                    answer: controller.textController.value.text.trim().isEmpty ? '-' : controller.textController.value.text.trim(),
                                    voteChoiceId: '',
                                    isSelect: false,
                                  );

                                  controller.textController.value.clear();
                                  controller.index++;
                                  controller.randomNumber;
                                }
                              : ((controller.dataModel.value.data!.voteItem![controller.index].voteChoice ?? [])).any((element) => (element.isSelect ?? false) == true)
                                  // || controller.textController.value.text.isNotEmpty
                                  ? () {
                                      controller.textController.value.clear();
                                      controller.index++;
                                      controller.randomNumber;
                                    }
                                  : null,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  MapEntry<int, Widget> _buildSingleChoice(
    BuildContext context, {
    required int key,
    required VoteChoice value,
    required List<VoteChoice> choice,
  }) {
    bool _selected = choice[key].isSelect ?? false;

    return MapEntry(
      key,
      Card(
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
              value.title ?? '',
              style: TextStyle(
                color: _selected ? kPrimaryColor : Colors.black,
                fontSize: context.isPhone ? 14 : 16,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            activeColor: kPrimaryColor,
            value: value.isSelect ?? false,
            onChanged: (_) {
              choice.forEach((element) {
                element.isSelect = false;
              });
              choice[key].isSelect = !_selected;
              controller.dataModel.refresh();

              controller.selectChoice(
                voteChoiceType: VoteChoiceType.single,
                voteItemId: value.voteItemId!,
                answer: choice[key].title ?? '',
                voteChoiceId: choice[key].id!,
                isSelect: choice[key].isSelect ?? false,
              );
            },
          ),
        ),
      ),
    );
  }

  MapEntry<int, Widget> _buildSingleChoiceHasImage(
    BuildContext context, {
    required int key,
    required VoteChoice value,
    required List<VoteChoice> choice,
  }) {
    bool _selected = choice[key].isSelect ?? false;

    return MapEntry(
      key,
      Card(
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
            secondary: GestureDetector(
              onTap: () {
                if ((choice[key].image ?? '').isNotEmpty) {
                  Get.toNamed(
                    AppRoutes.SLIDER_SHOW_IMAGE,
                    arguments: SliderShowImageArguments(galleryList: [choice[key].image]),
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  choice[key].image!,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CarouselLoading(
                      height: 50,
                      width: 50,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    int _number = Random().nextInt(8) + 1;
                    return Image.asset(
                      'assets/images/vote_0$_number.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     if ((choice[key].image ?? '').isNotEmpty)
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(8.0),
              //         child: Image.network(
              //           choice[key].image!,
              //           height: 50,
              //           width: 50,
              //           fit: BoxFit.cover,
              //           errorBuilder: (context, error, stackTrace) {
              //             int _number = Random().nextInt(8) + 1;
              //             return Image.asset(
              //               'assets/images/vote_0$_number.jpg',
              //               height: 50,
              //               width: 50,
              //               fit: BoxFit.cover,
              //             );
              //           },
              //         ),
              //       ),
              //     const Icon(
              //       Icons.remove_red_eye,
              //       color: Colors.white,
              //       size: 18,
              //     ),
              //   ],
              // ),
            ),
            title: Text(
              value.title ?? '',
              style: TextStyle(
                color: _selected ? kPrimaryColor : Colors.black,
                fontSize: context.isPhone ? 14 : 16,
                fontFamily: Assets.assetsFontsAnakotmaiMedium,
              ),
            ),
            activeColor: kPrimaryColor,
            value: value.isSelect ?? false,
            onChanged: (_) {
              choice.forEach((element) {
                element.isSelect = false;
              });
              choice[key].isSelect = !_selected;
              controller.dataModel.refresh();

              // TODO: Select Choice image
              controller.selectChoice(
                voteChoiceType: VoteChoiceType.single,
                voteItemId: value.voteItemId!,
                answer: choice[key].title ?? '',
                voteChoiceId: choice[key].id!,
                isSelect: choice[key].isSelect ?? false,
              );
            },
          ),
        ),
      ),
    );
  }

  MapEntry<int, Widget> _buildMultipleChoice(
    BuildContext context, {
    required int key,
    required VoteChoice value,
    required List<VoteChoice> choice,
  }) {
    bool _selected = choice[key].isSelect ?? false;

    return MapEntry(
      key,
      Card(
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
            print('key: $key');

            choice[key].isSelect = !_selected;
            controller.dataModel.refresh();

            controller.selectChoice(
              voteChoiceType: VoteChoiceType.multi,
              voteItemId: value.voteItemId!,
              answer: choice[key].title ?? '',
              voteChoiceId: choice[key].id!,
              isSelect: choice[key].isSelect ?? false,
            );
          },
          dense: true,
          selected: _selected,
          title: Text(
            value.title ?? '',
            style: TextStyle(
              color: _selected ? kPrimaryColor : Colors.black,
              fontSize: context.isPhone ? 14 : 16,
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
  }

  MapEntry<int, Widget> _buildMultipleChoiceHasImage(
    BuildContext context, {
    required int key,
    required VoteChoice value,
    required List<VoteChoice> choice,
  }) {
    bool _selected = choice[key].isSelect ?? false;

    return MapEntry(
      key,
      Card(
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
            print('key: $key');

            choice[key].isSelect = !_selected;
            controller.dataModel.refresh();

            // TODO: Select Choice image
            controller.selectChoice(
              voteChoiceType: VoteChoiceType.multi,
              voteItemId: value.voteItemId!,
              answer: choice[key].title ?? '',
              voteChoiceId: choice[key].id!,
              isSelect: choice[key].isSelect ?? false,
            );
          },
          dense: true,
          selected: _selected,
          leading: GestureDetector(
            onTap: () {
              if ((choice[key].image ?? '').isNotEmpty) {
                Get.toNamed(
                  AppRoutes.SLIDER_SHOW_IMAGE,
                  arguments: SliderShowImageArguments(galleryList: [choice[key].image]),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                choice[key].image!,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CarouselLoading(
                    height: 50,
                    width: 50,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  int _number = Random().nextInt(8) + 1;
                  return Image.asset(
                    'assets/images/vote_0$_number.jpg',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     if ((choice[key].image ?? '').isNotEmpty)
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(8.0),
            //         child: Image.network(
            //           choice[key].image!,
            //           height: 50,
            //           width: 50,
            //           fit: BoxFit.cover,
            //           errorBuilder: (context, error, stackTrace) {
            //             int _number = Random().nextInt(8) + 1;
            //             return Image.asset(
            //               'assets/images/vote_0$_number.jpg',
            //               height: 50,
            //               width: 50,
            //               fit: BoxFit.cover,
            //             );
            //           },
            //         ),
            //       ),
            //     const Icon(
            //       Icons.remove_red_eye,
            //       color: Colors.white,
            //       size: 18,
            //     ),
            //   ],
            // ),
          ),
          title: Text(
            value.title ?? '',
            style: TextStyle(
              color: _selected ? kPrimaryColor : Colors.black,
              fontSize: context.isPhone ? 14 : 16,
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
  }

  Widget _buildTextBox({required String voteItemId}) {
    return TextField(
      controller: controller.textController.value,
      keyboardType: TextInputType.text,
      maxLines: 6,
      decoration: const InputDecoration(
        hintText: 'พิมพ์คำตอบของคุณที่นี่',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      onChanged: (String text) {
        controller.textController.refresh();

        // controller.selectChoice(
        //   voteChoiceType: VoteChoiceType.text,
        //   voteItemId: voteItemId,
        //   answer: text,
        //   voteChoiceId: '',
        //   isSelect: false,
        // );
      },
    );
  }
}
