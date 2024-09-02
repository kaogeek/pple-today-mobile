// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/login_main_controller.dart';
import '../../../utils/assets.dart';
import '../../../utils/colors.dart';

class ProfileMergeUserToday extends StatelessWidget {
  ProfileMergeUserToday({Key? key}) : super(key: key);

  LoginMainController controller = Get.put(LoginMainController());

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
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 55,
                  backgroundImage: NetworkImage(
                    (controller.checkEmailUserModel.data?.imageUrl ?? '').isEmpty
                        ? Assets.placeholderPerson
                        : controller.checkEmailUserModel.data!.imageUrl!,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: () {
                    List<String> authUser = controller.checkEmailUserModel.authUser ?? [];

                    if (authUser.contains('FACEBOOK')) {
                      return facebookColor;
                    } else if (authUser.contains('TWITTER')) {
                      return twitterColor;
                    } else if (authUser.contains('GOOGLE')) {
                      return googleColor;
                    } else {
                      return Colors.white;
                    }
                  }(),
                  backgroundImage: AssetImage(
                    () {
                      List<String> authUser = controller.checkEmailUserModel.authUser ?? [];

                      if (authUser.contains('FACEBOOK')) {
                        return Assets.assetsImagesFacebook;
                      } else if (authUser.contains('TWITTER')) {
                        return Assets.assetsImagesTwitter;
                      } else if (authUser.contains('GOOGLE')) {
                        return Assets.assetsImagesGoogle;
                      } else {
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
            '${controller.checkEmailUserModel.data?.displayName}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            '@${controller.checkEmailUserModel.data?.uniqueId}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
