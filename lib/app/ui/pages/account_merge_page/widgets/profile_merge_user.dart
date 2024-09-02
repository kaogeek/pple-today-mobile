// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/account_merge_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum.dart';

class ProfileMergeUser extends StatelessWidget {
  ProfileMergeUser({Key? key}) : super(key: key);

  AccountMergeController controller = Get.put(AccountMergeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: kPrimaryColor,
                child: (controller.arguments.type == ModeType.email) || (controller.arguments.type == ModeType.apple)
                    ? const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 55,
                        backgroundImage: NetworkImage(Assets.placeholderPerson),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 55,
                        backgroundImage: NetworkImage(controller.arguments.imgUrl!),
                      ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: () {
                    switch (controller.arguments.type) {
                      case ModeType.facebook:
                        return facebookColor;

                      case ModeType.twitter:
                        return twitterColor;

                      case ModeType.google:
                        return googleColor;

                      case ModeType.apple:
                        return appleColor;

                      default:
                        return Colors.white;
                    }
                  }(),
                  backgroundImage: AssetImage(
                    () {
                      switch (controller.arguments.type) {
                        case ModeType.facebook:
                          return Assets.assetsImagesFacebook;

                        case ModeType.twitter:
                          return Assets.assetsImagesTwitter;

                        case ModeType.google:
                          return Assets.assetsImagesGoogle;

                        case ModeType.apple:
                          return Assets.assetsImagesApple;

                        default:
                          return Assets.assetsIconPpleIconTransparentO;
                      }
                    }(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            controller.arguments.email + '\n',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
