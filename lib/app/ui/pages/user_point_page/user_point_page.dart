// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_point_controller.dart';
import 'widgets/app_bar_user_point.dart';
import 'widgets/body_all_point_user_point.dart';
import 'widgets/body_receive_point_user_point.dart';
import 'widgets/body_redeem_point_user_point.dart';

class UserPointPage extends GetView<UserPointController> {
  const UserPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: const [
            AppBarUserPoint(),
            SliverFillRemaining(
              child: SafeArea(
                top: false,
                child: TabBarView(
                  children: [
                    BodyAllPointUserPoint(),
                    BodyReceivePointUserPoint(),
                    BodyRedeemPointUserPoint(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
