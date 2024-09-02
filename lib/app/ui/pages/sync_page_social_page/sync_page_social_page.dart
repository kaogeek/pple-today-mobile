import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/sync_page_social_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/sync_page_app_bar.dart';
import 'widgets/sync_page_body.dart';

class SyncPageSocialPage extends GetView<SyncPageSocialController> {
  const SyncPageSocialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainLayoutView(
      appBar: SyncPageAppBar(),
      body: SyncPageBody(),
    );
  }
}
