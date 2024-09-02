import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/search_controller.dart'as search;
import '../../../../routes/app_routes.dart';
import '../../../utils/colors.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<search.SearchController>(
      init: search.SearchController(),
      initState: (_) {},
      builder: (controller) {
        if (controller.textController.text.isEmpty) {
          return const SizedBox();
        }

        if ((controller.searchModel.data?.result ?? []).isEmpty) {
          return const Center(
            child: Text(
              'ไม่พบข้อมูล',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.searchModel.data!.result!.length,
          itemBuilder: (context, index) {
            final _result = controller.searchModel.data!.result![index];

            return Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                onTap: () async {
                  if (controller.focusNode.hasFocus) {
                    controller.focusNode.unfocus();
                  }

                  controller.fetchHistorySearch();

                  switch (_result.type!.toUpperCase()) {
                    case 'HASHTAG':
                      Get.toNamed(
                        AppRoutes.HASH_TAG,
                        arguments: {
                          'HASH_TAG': _result.id!,
                          // 'EMER_TAG': _result.id!,
                        },
                      );

                      await controller.fetchHistory(
                        resultType: _result.type!,
                        resultId: _result.id!,
                        keyword: _result.label!,
                      );
                      break;

                    case 'PAGE':
                      Get.toNamed(
                        AppRoutes.PAGE_PROFILE,
                        arguments: {'PAGE_ID': _result.id!},
                      );

                      await controller.fetchHistory(
                        resultType: _result.type!,
                        resultId: _result.id!,
                        keyword: _result.label!,
                      );
                      break;

                    case 'USER':
                      // TODO: implement user
                      // MyDialog.showSnackBar(
                      //   title: 'ยังไม่สามารถเข้าไปดูโปรไฟล์ผู้ใช้ได้',
                      //   type: TypeSnackBar.warning,
                      // );

                      // TODO: fetchHistory
                      // controller.fetchHistory(
                      //   resultType: data.type!,
                      //   resultId: data.value!,
                      //   keyword: data.label!,
                      // );

                      break;

                    default:
                      // TODO: implement default
                      // MyDialog.showSnackBar(
                      //   title: 'ยังไม่สามารถเข้าไปได้ ณ ขณะนี้',
                      //   type: TypeSnackBar.warning,
                      // );
                      //statements;
                      break;
                  }
                },
                leading:
                    _result.historyId != null ? const Icon(Icons.timer_outlined) : const Icon(Icons.search_outlined),
                title: Text(
                  _result.label!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: textDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  _result.type!.toUpperCase() == 'PAGE'
                      ? 'เพจ'
                      : _result.type!.toUpperCase() == 'USER'
                          ? 'ผู้ใช้'
                          : _result.type!.toUpperCase(),
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
            );
          },
        );
      },
    );
  }
}
