// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/mfp_vote_edit_view_controller.dart';
import '../../../../data/models/edit_vote_item_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';
import '../../../utils/log.dart';

class CreateAddAuestionButton extends GetWidget<MfpVoteEditViewController> {
  CreateAddAuestionButton({Key? key}) : super(key: key);

  List<Map<String, dynamic>> choiceList = [
    {
      'title': 'เลือกคำตอบเดียว',
      'icon': Icons.check_circle_outline_rounded,
      'type': VoteChoiceType.single,
    },
    {
      'title': 'เลือกหลายคำตอบ',
      'icon': Icons.checklist_rtl_rounded,
      'type': VoteChoiceType.multi,
    },
    {
      'title': 'กล่องข้อความ',
      'icon': Icons.abc_rounded,
      'type': VoteChoiceType.text,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              side: BorderSide(color: kPrimaryColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_rounded,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'เพิ่มคำถาม',
                style: TextStyle(
                  // fontSize: 18,
                  color: kPrimaryColor,
                  fontFamily: Assets.assetsFontsAnakotmaiMedium,
                ),
              ),
            ],
          ),
          onPressed: () {
            /// unfocus keyboard
            FocusScope.of(context).unfocus();

            Get.bottomSheet(
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: choiceList
                        .map((e) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.only(left: 16),
                                  onTap: () {
                                    onAddItem(e);
                                  },
                                  leading: Icon(e['icon']),
                                  title: Text(
                                    e['title'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                    ),
                                  ),
                                ),
                                const Divider(),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> onAddItem(Map<String, dynamic> e) async {
    if (Get.isBottomSheetOpen ?? false) Get.back();

    List<VoteChoice> defaultVoteChoice = [
      VoteChoice(
        controller: TextEditingController(text: ''),
        focusNode: FocusNode(),
        title: '',
        assetId: null,
        image: null,
        s3CoverPageUrl: null,
      ),
      VoteChoice(
        controller: TextEditingController(text: ''),
        focusNode: FocusNode(),
        title: '',
        assetId: null,
        image: null,
        s3CoverPageUrl: null,
      ),
      VoteChoice(
        controller: TextEditingController(text: ''),
        focusNode: FocusNode(),
        title: '',
        assetId: null,
        image: null,
        s3CoverPageUrl: null,
      ),
    ];

    VoteChoiceType _type = e['type'];
    Log.print('$_type');

    EditVoteItemModel data = controller.editVoteItemModel.value;
    Log.print('length: ${data.voteItem!.length + 1}');

    switch (_type) {
      case VoteChoiceType.single:
        data.voteItem!.add(
          VoteItem(
            controller: TextEditingController(),
            focusNode: FocusNode(),
            ordering: data.voteItem!.length + 1,
            title: '',
            type: _type,
            assetId: null,
            coverPageURL: null,
            s3CoverPageUrl: null,
            voteChoice: defaultVoteChoice,
          ),
        );
        break;

      case VoteChoiceType.multi:
        data.voteItem!.add(
          VoteItem(
            controller: TextEditingController(),
            focusNode: FocusNode(),
            ordering: data.voteItem!.length + 1,
            title: '',
            type: _type,
            assetId: null,
            coverPageURL: null,
            s3CoverPageUrl: null,
            voteChoice: defaultVoteChoice,
          ),
        );
        break;

      default:
        data.voteItem!.add(
          VoteItem(
            controller: TextEditingController(),
            focusNode: FocusNode(),
            ordering: data.voteItem!.length + 1,
            title: '',
            type: _type,
            assetId: null,
            coverPageURL: null,
            s3CoverPageUrl: null,
            voteChoice: [],
          ),
        );

        break;
    }

    dynamic result = await Get.toNamed(
      AppRoutes.MFP_VOTE_EDIT_ITEM,
      arguments: {
        'INDEX': data.voteItem!.length - 1,
        'DATA': data,
        'IS_EDIT': false,
      },
    );

    if (result == null) {
      controller.editVoteItemModel.update((val) {
        val!.voteItem!.removeLast();
      });
    } else {
      controller.editVoteItemModel(result);
      controller.editVoteItemModel.refresh();
    }
    return;
  }
}
