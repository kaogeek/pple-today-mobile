/* import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/search_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class HistorySearch extends GetWidget<SearchController> {
  const HistorySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      initState: (_) {},
      builder: (_) {
        return (controller.historySearchModel.data ?? []).isEmpty
            ? const SafeArea(
                child: SizedBox(),
              )
            : ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount: controller.historySearchModel.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final _data = controller.historySearchModel.data![index];

                  final type = _data.type!.toUpperCase();

                  return Column(
                    children: [
                      if (index == 0)
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              top: 20,
                            ),
                            child: Text(
                              'ค้นหาล่าสุด',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      InkWell(
                        onTap: () {
                          switch (type) {
                            case 'HASHTAG':
                              // TODO: Handle this case.
                              // Get.to(() => PostSearchSC(
                              //       label: _data.label!,
                              //     ));
                              break;

                            case 'PAGE':
                              // TODO: Handle this case.
                              // Get.to(() => ProfilePageSC(
                              //       pageId: _data.value!,
                              //     ));
                              break;

                            case 'USER':
                              // TODO: Handle this case.
                              break;

                            default:
                              // TODO: Handle this case.
                              break;
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            leading: (_data.imageUrl ?? '').isNotEmpty
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(_data.imageUrl!),
                                    backgroundColor: Colors.transparent,
                                  )
                                : CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                      Assets.assetsImagesPlaceholderPerson,
                                    ),
                                  ),
                            title: Text(
                              _data.label!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: textDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              type == 'PAGE'
                                  ? 'เพจ'
                                  : type == 'USER'
                                      ? 'ผู้ใช้'
                                      : type,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: textDark,
                            ),
                          ),
                        ),
                      ),
                      // (index + 1) != controller.historySearchModel.data!.length
                      //     ? const SizedBox()
                      //     : const SafeArea(
                      //         child: SizedBox(),
                      //       ),
                    ],
                  );
                },
              );
      },
    );
  }
}
 */