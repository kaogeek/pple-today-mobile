import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/notification_card_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/notification_card_app_bar.dart';
import 'widgets/notification_card_read_all.dart';
import 'widgets/notification_card_unread.dart';

class NotificationCardPage extends GetView<NotificationCardController> {
  NotificationCardPage({Key? key}) : super(key: key);

  final List<Widget> _screens = [
    const NotifacationCardUnread(),
    const NotifacationCardReadAll(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _screens.length,
      child: MainLayoutView(
        appBar: const NotificationCardAppBar(),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
        ),
      ),
    );
  }
}
