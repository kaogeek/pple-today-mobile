import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/my_dialog.dart';
import '../../../../controllers/mfp_vote_edit_item_controller.dart';
import '../../../../data/models/edit_vote_item_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';
import '../../../utils/formatter.dart';
import 'group.dart';

class ChoiceItem extends GetWidget<MfpVoteEditItemController> {
  const ChoiceItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.editItemModel.value.voteItem ?? []).isNotEmpty && controller.editItemModel.value.voteItem![controller.index].type == VoteChoiceType.text
        ? Container()
        : Group(
            groupName: 'ตัวเลือก',
            child: Container(
              // padding: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Obx(() => Column(
                    children: [
                      ...List.generate(
                        controller.voteChoiceModel.length + 1,
                        (index) {
                          final _voteChoice = controller.voteChoiceModel;

                          if (index + 1 != _voteChoice.length + 1) {
                            return TextField(
                              focusNode: _voteChoice[index].focusNode,
                              controller: _voteChoice[index].controller,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'ตัวเลือกที่ ${index + 1}',
                                hintStyle: const TextStyle(fontSize: 14),
                                contentPadding: const EdgeInsets.fromLTRB(8, 14, 8, 0),
                                border: InputBorder.none,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // TODO: show image choice
                                    /*  Stack(
                                            alignment: Alignment.bottomLeft,
                                            children: [
                                              Image.asset(
                                                Assets.images.ppleTransparentPNG,
                                                width: 24,
                                              ),
                                              Positioned(
                                                top: -8,
                                                right: -8,
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  size: 24,
                                                  color: Colors.grey.shade400,
                                                ),
                                                /*  IconButton(
                                                  onPressed: () async {
                                                    XFile? image = await ImagePicker().pickImage(
                                                      source: ImageSource.gallery,
                                                      imageQuality: 50,
                                                    );

                                                    if (image == null) return;

                                                    controller.listChoice[index]['IMAGE_PATH'] = image.path;
                                                  },
                                                  icon: Icon(
                                                    Icons.add_photo_alternate_rounded,
                                                    size: 16,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ), */
                                              ),
                                            ],
                                          ), */
                                    IconButton(
                                      onPressed: () {
                                        MyDialog.defaultDialog(
                                          title: 'ลบตัวเลือก',
                                          content: _voteChoice[index].title!.isNotEmpty
                                              ? '"${_voteChoice[index].title}"'
                                              : 'ตัวเลือกที่ ${index + 1}'
                                                  '\nคุณต้องการลบตัวเลือกนี้ใช่หรือไม่?',
                                          textCancel: 'ยกเลิก',
                                          cancelTextColor: kPrimaryColor,
                                          textConfirm: 'ลบ',
                                          confirmTextColor: Colors.black,
                                          onConfirm: () {
                                            if (Get.isDialogOpen ?? false) Get.back();

                                            debugPrint('INDEX: $index', wrapWidth: 1024);

                                            try {
                                              if (controller.voteChoiceModel[index].id != null) {
                                                debugPrint('id: ${controller.voteChoiceModel[index].id}', wrapWidth: 1024);
                                                controller.deleteChoices.add(controller.voteChoiceModel[index].id!);
                                              }
                                            } finally {
                                              controller.voteChoiceModel.removeAt(index);
                                            }
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                                // suffixIcon: SizedBox(
                                //   width: 45,
                                //   height: 45,
                                //   child: Icon(
                                //     Icons.add_photo_alternate_rounded,
                                //     size: 36,
                                //     color: Colors.grey.shade400,
                                //   ),
                                // ),
                              ),
                              keyboardType: TextInputType.text,
                              inputFormatters: Formatter.inputText,
                              autocorrect: false,
                              onChanged: (value) {
                                controller.voteChoiceModel[index].title = value;
                                // controller.editItemModel.refresh();
                              },
                            );
                          } else {
                            return TextButton(
                              onPressed: () {
                                // controller.voteChoiceModel.removeWhere((element) => (element.title ?? '').isEmpty);
                                controller.voteChoiceModel.add(
                                  VoteChoice(
                                    controller: TextEditingController(text: ''),
                                    focusNode: FocusNode(),
                                    title: '',
                                    assetId: null,
                                    image: null,
                                    s3CoverPageUrl: null,
                                  ),
                                );
                                controller.voteChoiceModel.last.focusNode!.requestFocus();

                                // controller.editItemModel.update((val) {
                                //   val!.voteItem![controller.index].voteChoice!.removeWhere((element) => element.controller!.text.isEmpty);
                                //   val.voteItem![controller.index].voteChoice!.add(
                                //     VoteChoice(
                                //       controller: TextEditingController(text: ''),
                                //       focusNode: FocusNode(),
                                //       title: '',
                                //       assetId: null,
                                //       image: null,
                                //       s3CoverPageUrl: null,
                                //     ),
                                //   );
                                // });

                                // controller.editItemModel.value.voteItem![controller.index].voteChoice!.add(
                                //   VoteChoice(
                                //     controller: TextEditingController(),
                                //     focusNode: FocusNode(),
                                //     title: '',
                                //     assetId: null,
                                //     image: null,
                                //     s3CoverPageUrl: null,
                                //   ),
                                // );

                                // controller.editItemModel.value.voteItem![controller.index].voteChoice!.last.focusNode!.requestFocus();
                                // controller.editItemModel.refresh();
                              },
                              child: const Text(
                                'เพิ่มตัวเลือก',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  // fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  )),
            ),
          ));
  }
}
