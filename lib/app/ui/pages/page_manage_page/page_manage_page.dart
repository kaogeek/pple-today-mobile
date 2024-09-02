import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/page_manage_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/manage_page_app_bar.dart';
import 'widgets/page_manage_body.dart';

class PageManagePage extends GetView<PageManageController> {
  const PageManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: const ManagePageAppBar(),
      body: PageManageBody(),
    );
  }
}
