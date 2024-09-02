// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/page_profile_controller.dart';
import '../../../utils/colors.dart';

class TextNameProfilePage extends StatelessWidget {
  const TextNameProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 12),
        child: Container(
          color: Colors.white,
          height: 142,
          child: GetBuilder<PageProfileController>(
            init: PageProfileController(),
            initState: (_) {},
            builder: (controller) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 56),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          controller.pageModel.data?.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  (controller.pageModel.data?.pageUsername ?? '').isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Center(
                            child: Text(
                              '@${controller.pageModel.data?.pageUsername ?? ''}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
