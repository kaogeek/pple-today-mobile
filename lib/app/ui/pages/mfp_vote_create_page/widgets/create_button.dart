// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../component/my_dialog.dart';
// import '../../../../controllers/mfp_vote_create_controller.dart';
// import '../../../../data/models/create_item_model.dart';
// import '../../../../data/models/file_temp_model.dart';
// import '../../../../routes/app_routes.dart';
// import '../../../utils/assets.dart';
// import '../../../utils/colors.dart';
// import '../../../utils/enum.dart';

// class CreateButton extends GetWidget<MfpVoteCreateController> {
//   CreateButton({Key? key}) : super(key: key);

//   List<Map<String, dynamic>> choiceList = [
//     {
//       'title': 'เลือกคำตอบเดียว',
//       'icon': Icons.check_circle_outline_rounded,
//       'type': VoteChoiceType.single,
//     },
//     {
//       'title': 'เลือกหลายคำตอบ',
//       'icon': Icons.checklist_rtl_rounded,
//       'type': VoteChoiceType.multi,
//     },
//     {
//       'title': 'กล่องข้อความ',
//       'icon': Icons.abc_rounded,
//       'type': VoteChoiceType.text,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: SizedBox(
//         width: Get.width,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 36, 16, 8),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               backgroundColor: kPrimaryColor,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(30),
//                 ),
//                 side: BorderSide(color: kPrimaryColor),
//               ),
//             ),
//             child: Text(
//               'สร้างคำถาม',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: Assets.assetsFontsAnakotmaiMedium,
//               ),
//             ),
//             onPressed: _onCreate,
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _onCreate() async {
//     if (controller.titleController.value.text.trim().isEmpty) {
//       MyDialog.defaultDialog(
//         title: 'เกิดข้อผิดพลาด',
//         content: 'กรุณาตั้งชื่อการโหวต',
//       );
//       return;
//     }

//     if (controller.descriptionController.value.text.trim().isEmpty) {
//       MyDialog.defaultDialog(
//         title: 'เกิดข้อผิดพลาด',
//         content: 'กรุณาเพิ่มคำอธิบาย',
//       );
//       return;
//     }

//     /*  if (controller.startDate.value == null || controller.endDate.value == null) {
//       MyDialog.defaultDialog(
//         title: 'เกิดข้อผิดพลาด',
//         content: 'กรุณากำหนดวันเริ่มโหวตและวันปิดโหวต',
//       );
//       return;
//     } */

//     FileTempModel model = await controller.createFileTemp();

//     CreateItemModel data = CreateItemModel(
//       title: controller.titleController.text,
//       detail: controller.descriptionController.text,
//       assetId: model.data?.id,
//       coverPageUrl: model.data?.id == null ? null : '/file/${model.data!.id!}',
//       s3CoverPageUrl: model.data == null ? null : model.data!.s3FilePath,
//       approved: false,
//       closed: false,
//       minSupport: 500,
//       countSupport: 0,
//       // startVoteDatetime: controller.startDate.value!.toIso8601String(),
//       // endVoteDatetime: controller.endDate.value!.toIso8601String(),
//       voteDaysRange: int.parse(controller.openVoteController.value.text.trim()),
//       status: 'support',
//       createAsPage: controller.indexPage.value == 0 ? null : controller.userAccessPageModel.value.data![controller.indexPage.value].page!.id,
//       type: controller.type.value,
//       hashTag: controller.hashTagController.text.trim(),
//       pin: false,
//       showVoterName: controller.showVoteName.value,
//       showVoteResult: controller.showVoteResult.value,
//       voteItem: [],
//     );

//     /// button sheet create question listtile choice
//     Get.bottomSheet(
//       Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: choiceList
//                 .map((e) => Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ListTile(
//                           contentPadding: const EdgeInsets.only(left: 16),
//                           onTap: () {
//                             if (Get.isBottomSheetOpen ?? false) Get.back();

//                             switch (e['type']) {
//                               case VoteChoiceType.single:
//                                 List<VoteChoice>? voteChoice = [
//                                   VoteChoice(
//                                     controller: TextEditingController(),
//                                     focusNode: FocusNode(),
//                                     title: '',
//                                     assetId: null,
//                                     coverPageUrl: null,
//                                     s3CoverPageUrl: null,
//                                   ),
//                                   VoteChoice(
//                                     controller: TextEditingController(),
//                                     focusNode: FocusNode(),
//                                     title: '',
//                                     assetId: null,
//                                     coverPageUrl: null,
//                                     s3CoverPageUrl: null,
//                                   ),
//                                   VoteChoice(
//                                     controller: TextEditingController(),
//                                     focusNode: FocusNode(),
//                                     title: '',
//                                     assetId: null,
//                                     coverPageUrl: null,
//                                     s3CoverPageUrl: null,
//                                   ),
//                                 ];

//                                 data.voteItem?.add(VoteItem(
//                                   controller: TextEditingController(),
//                                   focusNode: FocusNode(),
//                                   ordering: 1,
//                                   titleItem: '',
//                                   typeChoice: (e['type'] as VoteChoiceType).name,
//                                   assetIdItem: null,
//                                   coverPageUrlItem: null,
//                                   s3CoverPageUrlItem: null,
//                                   voteChoice: voteChoice,
//                                 ));
//                                 break;

//                               case VoteChoiceType.multi:
//                                 List<VoteChoice>? voteChoice = [
//                                   VoteChoice(
//                                     controller: TextEditingController(),
//                                     focusNode: FocusNode(),
//                                     title: '',
//                                     assetId: null,
//                                     coverPageUrl: null,
//                                     s3CoverPageUrl: null,
//                                   ),
//                                   VoteChoice(
//                                     controller: TextEditingController(),
//                                     focusNode: FocusNode(),
//                                     title: '',
//                                     assetId: null,
//                                     coverPageUrl: null,
//                                     s3CoverPageUrl: null,
//                                   ),
//                                   VoteChoice(
//                                     controller: TextEditingController(),
//                                     focusNode: FocusNode(),
//                                     title: '',
//                                     assetId: null,
//                                     coverPageUrl: null,
//                                     s3CoverPageUrl: null,
//                                   ),
//                                 ];

//                                 data.voteItem?.add(VoteItem(
//                                   controller: TextEditingController(),
//                                   focusNode: FocusNode(),
//                                   ordering: 1,
//                                   titleItem: '',
//                                   typeChoice: (e['type'] as VoteChoiceType).name,
//                                   assetIdItem: null,
//                                   coverPageUrlItem: null,
//                                   s3CoverPageUrlItem: null,
//                                   voteChoice: voteChoice,
//                                 ));
//                                 break;

//                               case VoteChoiceType.text:
//                                 data.voteItem?.add(VoteItem(
//                                   controller: TextEditingController(),
//                                   focusNode: FocusNode(),
//                                   ordering: 1,
//                                   titleItem: '',
//                                   typeChoice: (e['type'] as VoteChoiceType).name,
//                                   assetIdItem: null,
//                                   coverPageUrlItem: null,
//                                   s3CoverPageUrlItem: null,
//                                   voteChoice: [],
//                                 ));
//                                 break;

//                               default:
//                             }

//                             Get.toNamed(
//                               AppRoutes.MFP_VOTE_CREATE_ITEM,
//                               preventDuplicates: false,
//                               arguments: {
//                                 'TYPE': e['type'],
//                                 'DATA': data,
//                               },
//                             );
//                           },
//                           leading: Icon(e['icon']),
//                           title: Text(
//                             e['title'],
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: Assets.assetsFontsAnakotmaiMedium,
//                             ),
//                           ),
//                         ),
//                         const Divider(),
//                       ],
//                     ))
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
