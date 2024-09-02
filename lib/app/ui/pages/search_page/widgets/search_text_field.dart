import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../component/loading.dart';
import '../../../../controllers/search_controller.dart' as search;
import '../../../utils/colors.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({Key? key}) : super(key: key);

  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GetBuilder<search.SearchController>(
        init: search.SearchController(),
        initState: (_) {},
        builder: (controller) {
          return TextField(
            controller: controller.textController,
            focusNode: controller.focusNode,
            autofocus: true,
            maxLines: 1,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: const Icon(
                Icons.search,
                color: textDark,
                // size: 22,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) async {
              if (value.isNotEmpty) {
                _debouncer.call(() async {
                  Loading.show();
                  await controller.fetchSearch(value);
                  Loading.dismiss();
                });
              } else {
                controller.searchModel.data!.result!.clear();
                controller.update();
              }
            },
            onSubmitted: (value) async {
              if (value.isNotEmpty) {
                Loading.show();
                await controller.fetchSearch(value);
                Loading.dismiss();
              } else {
                controller.searchModel.data!.result!.clear();
                controller.update();
              }
            },
          );
        },
      ),
    );
  }
}
