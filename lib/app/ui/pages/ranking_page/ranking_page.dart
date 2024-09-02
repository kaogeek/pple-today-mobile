import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/ranking_controller.dart';
import '../../utils/colors.dart';
import 'widgets/app_bar_ranking.dart';
import 'widgets/body_ranking.dart';

class RankingPage extends GetView<RankingController> {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRanking(),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        }

        return const BodyRanking();
      }),
    );
  }
}
