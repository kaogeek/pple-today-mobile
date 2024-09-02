import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/point_main_controller.dart';
import 'group_list_point_main.dart';
import 'pages_point_main.dart';

class BodyPointMain extends GetWidget<PointMainController> {
  const BodyPointMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      padding: EdgeInsets.only(top: context.isPhone ? 32.0 : 40.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.isPhone ? 24.0 : 40.0),
          topRight: Radius.circular(context.isPhone ? 24.0 : 40.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            // spreadRadius: 1,
            blurRadius: 32.0,
            offset: const Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          /// Category
          PagesPointMain(),

          /// Group List
          GroupListPointMain(),

          // ...List.generate(data!.productAggr!.length, (index) {
          //   return GroupListPointMain(
          //     groupName: data.productAggr![index].title ?? '',
          //     data: data.productAggr![index].product ?? [],
          //   );
          // }),
          SafeArea(
            child: SizedBox(height: 16.0),
          ),
        ],
      ),
    );
  }
}
