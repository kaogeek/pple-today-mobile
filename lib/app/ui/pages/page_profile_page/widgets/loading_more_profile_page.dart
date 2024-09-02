// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/page_profile_controller.dart';

class LoadingMoreProfilePage extends StatelessWidget {
  const LoadingMoreProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: GetBuilder<PageProfileController>(
          init: PageProfileController(),
          initState: (_) {},
          builder: (controller) {
            return controller.isLoadMore
                ? SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'กำลังโหลด',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                : controller.isNoMore
                    ? SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'ไม่มีโพสแล้ว',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                    : SizedBox();
          },
        ),
      ),
    );
  }
}
