import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/user_access_page_model.dart';
import '../../../../controllers/mfp_vote_create_controller.dart';
import '../../../utils/assets.dart';
import 'group.dart';

class CreateAs extends GetWidget<MfpVoteCreateController> {
  const CreateAs({Key? key}) : super(key: key);

  @override
  Key get key => GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (controller.userAccessPageModel.value.data ?? []).isEmpty
          ? const SizedBox()
          : Group(
              groupName: 'สร้างโหวตโดย',
              child: Container(
                width: Get.width,
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
                child: Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   child: (controller.userAccessPageModel.value.data?[controller.indexPage.value].page?.imageUrl ?? '').isEmpty
                    //       ? CircleAvatar(
                    //           backgroundColor: Colors.black.withOpacity(0.5),
                    //           backgroundImage: AssetImage(Assets.assetsImagesUser),
                    //         )
                    //       : CircleAvatar(
                    //           backgroundColor: Colors.black.withOpacity(0.5),
                    //           backgroundImage: NetworkImage(controller.userAccessPageModel.value.data![controller.indexPage.value].page!.imageUrl!),
                    //         ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Obx(() => DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              items: controller.userAccessPageModel.value.data!.map((Data value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, right: 8),
                                        child: (value.page?.imageUrl ?? '').isEmpty
                                            ? CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.black.withOpacity(0.5),
                                                backgroundImage: const AssetImage(Assets.assetsImagesUser),
                                              )
                                            : CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.black.withOpacity(0.5),
                                                backgroundImage: NetworkImage(value.page!.imageUrl!),
                                              ),
                                      ),
                                      Text(value.page!.name!),
                                    ],
                                  ),
                                );
                              }).toList(),
                              value: controller.userAccessPageModel.value.data![controller.indexPage.value],
                              onChanged: (value) {
                                controller.indexPage.value = controller.userAccessPageModel.value.data!.indexOf(value as Data);
                              },
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: Assets.assetsFontsAnakotmaiMedium,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }

  /* @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (controller.userAccessPageModel.value.data ?? []).isEmpty
          ? const SizedBox()
          : Group(
              groupName: 'สร้างโหวตโดย',
              child: Container(
                width: Get.width,
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
                child: DropdownMenu<Data>(
                  // key: key,
                  width: Get.width - 36,
                  // enabled: false,
                  // enableFilter:  false,
                  enableSearch: false,
                  initialSelection: controller.userAccessPageModel.value.data!.first,
                  // controller: colorController,
                  inputDecorationTheme: const InputDecorationTheme(
                    border: InputBorder.none,
                  ),
                  leadingIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: (controller.userAccessPageModel.value.data?[controller.indexPage.value].page?.imageUrl ?? '').isEmpty
                        ? CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.5),
                            backgroundImage: AssetImage(Assets.assetsImagesUser),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.5),
                            backgroundImage: NetworkImage(controller.userAccessPageModel.value.data![controller.indexPage.value].page!.imageUrl!),
                          ),
                  ),
                  onSelected: (Data? value) {
                    controller.indexPage.value = controller.userAccessPageModel.value.data!.indexOf(value!);
                  },
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: Assets.assetsFontsAnakotmaiMedium,
                  ),
                  dropdownMenuEntries: controller.userAccessPageModel.value.data!.map<DropdownMenuEntry<Data>>((Data value) {
                    Log.print('-----------------------------------------------');
                    Log.print('indexPage2: ${controller.indexPage.value}');
                    Log.print('indexOf2: ${controller.userAccessPageModel.value.data!.indexOf(value)}');
                    Log.print('bool: ${controller.indexPage.value == controller.userAccessPageModel.value.data!.indexOf(value)}');
                    return DropdownMenuEntry(
                      value: value,
                      label: value.page!.name!,
                      style: ButtonStyle(
                        // foregroundColor: MaterialStateProperty.all<Color>(
                        //   controller.indexPage.value == controller.userAccessPageModel.value.data!.indexOf(value) ? kPrimaryColor : Colors.black,
                        // ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(
                            fontSize: 14,
                            fontFamily: Assets.assetsFontsAnakotmaiMedium,
                          ),
                        ),
                      ),
                      // enabled: value.page!.name != controller.userAccessPageModel.value.data!.first.page!.name,
                      leadingIcon: (value.page?.imageUrl ?? '').isEmpty
                          ? CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              backgroundImage: AssetImage(Assets.assetsImagesUser),
                            )
                          : CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              backgroundImage: NetworkImage(value.page!.imageUrl!),
                            ),
                      // style: MenuItemButton.styleFrom(
                      //   foregroundColor: color.color,
                      // ),
                    );
                  }).toList(),
                ),
              ),
            );
    });
  } */
}
