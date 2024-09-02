import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/dashboard_controller.dart';
import '../../../utils/colors.dart';

class DashboardBody extends StatelessWidget {
  final List<Widget> children;

  const DashboardBody({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<DashboardController>(
        init: DashboardController(),
        initState: (_) {},
        builder: (controller) {
          // return IndexedStack(
          //   index: controller.selectedIndex,
          //   children: children,
          // );

          return IndexedSemantics(
            index: controller.selectedIndex,
            child: ExcludeSemantics(
              child: Column(
                children: [
                  children[controller.selectedIndex],
                  if (controller.isLoadMore)
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                ],
              ),
            ),
          );

          // return Stack(
          //   children: children
          //       .asMap()
          //       .map((i, e) => MapEntry(
          //             i,
          //             Offstage(
          //               offstage: controller.selectedIndex != i,
          //               child: e,
          //             ),
          //           ))
          //       .values
          //       .toList(),
          // );
        },
      ),
    );
  }
}
