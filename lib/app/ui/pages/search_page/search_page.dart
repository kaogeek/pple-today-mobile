import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/search_controller.dart' as search;
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/search_app_bar.dart';
import 'widgets/search_body.dart';

class SearchPage extends GetView<search.SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      onWillPop: () async {
        controller.scrollController.dispose();
        return true;
      },
      body: GetBuilder<search.SearchController>(
        init: search.SearchController(),
        initState: (_) {},
        builder: (_) {
          return CustomScrollView(
            controller: controller.scrollController,
            slivers: const [
              SearchAppBar(),
              SearchBody(),
            ],
          );
        },
      ),
    );
  }
}
