import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/account_merge_controller.dart';
import '../../layouts/main/widgets/main_layout_view.dart';
import 'widgets/app_bar_merge.dart';
import 'widgets/button_merge.dart';
import 'widgets/detail_merge.dart';
import 'widgets/display_profile.dart';

class AccountMergePage extends GetView<AccountMergeController> {
  const AccountMergePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: const AppBarMerge(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: context.isPhone ? 32 : 112,
              ),
              DisplayProfile(),
              SizedBox(
                height: context.isPhone ? 32 : 56,
              ),
              const DetailMerge(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtonMerge(),
    );
  }
}
