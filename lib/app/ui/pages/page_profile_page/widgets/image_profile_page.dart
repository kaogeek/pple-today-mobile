import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/page_profile_controller.dart';
import '../../../utils/assets.dart';

class ImageProfilePage extends StatelessWidget {
  const ImageProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<PageProfileController>(
        init: PageProfileController(),
        initState: (_) {},
        builder: (controller) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: (controller.pageModel.data?.coverUrl ?? '').isEmpty
                        ? Image.asset(
                            Assets.assetsImagesPlaceholderJPG,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            controller.pageModel.data!.coverUrl!,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      bottom: -55,
                      child: SizedBox(
                        width: 130,
                        height: 130,
                        child: (controller.pageModel.data?.imageUrl ?? '').isEmpty
                            ? CircleAvatar(
                                backgroundImage: AssetImage(Assets.assetsImagesPlaceholderPerson),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(controller.pageModel.data!.imageUrl!),
                              ),
                      )),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
