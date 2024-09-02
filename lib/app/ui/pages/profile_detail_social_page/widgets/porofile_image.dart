import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/divider_component.dart';
import '../../../../controllers/profile_controller.dart';
import '../../../utils/assets.dart';

class ProfileImage extends GetWidget<ProfileController> {
  const ProfileImage({Key? key}) : super(key: key);

  final double _sizeImage = 136;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // TODO: Change image profile
                },
                child: (controller.profileModel.data?.imageUrl ?? '').isEmpty
                    ? Container(
                        height: _sizeImage,
                        width: _sizeImage,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Assets.assetsImagesPlaceholderPerson),
                          ),
                          borderRadius: BorderRadius.circular(300.0),
                        ),
                      )
                    : Container(
                        height: _sizeImage,
                        width: _sizeImage,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(controller.profileModel.data!.imageUrl!),
                          ),
                          borderRadius: BorderRadius.circular(300.0),
                        ),
                      ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            '${controller.profileModel.data?.mfpUser?.firstName ?? ''} ${controller.profileModel.data?.mfpUser?.lastName ?? ''}',
            maxLines: 1,
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const DividerComponent(),
      ],
    );
  }
}
