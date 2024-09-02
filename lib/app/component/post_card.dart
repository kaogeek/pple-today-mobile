import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mfp_app/app/component/read_more_text.dart';

import '../routes/app_routes.dart';
import '../ui/utils/assets.dart';
import '../ui/utils/colors.dart';
import '../ui/utils/environment.dart';
import 'album_card.dart';
import 'button_social.dart';
import 'convert_time_componenet.dart';

class PostCard extends StatelessWidget {
  final String? pageId;
  final String postId;
  final String typePost;
  final String imageUrl;
  final String displayName;
  final DateTime? createdDate;
  final VoidCallback? onPressedUGC;
  final List gallery;
  final String titlePost;
  final String detailPost;
  final dynamic storyPost;
  final VoidCallback? onPressedStory;
  final bool isLike;
  final int likeCount;
  final VoidCallback onPressedLike;
  final bool isComment;
  final int commentCount;
  final VoidCallback onPressedComment;

  const PostCard({
    Key? key,
    required this.pageId,
    required this.postId,
    required this.typePost,
    required this.imageUrl,
    required this.displayName,
    required this.createdDate,
    required this.onPressedUGC,
    required this.gallery,
    required this.titlePost,
    required this.detailPost,
    required this.storyPost,
    required this.onPressedStory,
    required this.isLike,
    required this.likeCount,
    required this.onPressedLike,
    required this.isComment,
    required this.commentCount,
    required this.onPressedComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTitle(),
            _buildBody(),
            storyPost != null
                ? TextButton(
                    onPressed: onPressedStory,
                    child: const Text(
                      'อ่านสตอรี่...',
                      style: TextStyle(
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        fontSize: 14,
                        color: kPrimaryColor,
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            ButtonSocial(
              isLike: isLike,
              likeCount: likeCount,
              onTapLike: onPressedLike,
              isComment: isComment,
              commentCount: commentCount,
              onTapComment: onPressedComment,
              urlShare: '${Environment.domainName}/post/$postId',
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTitle() {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 8),
      onTap: () {
        if (pageId != null) {
          Get.toNamed(
            AppRoutes.PAGE_PROFILE,
            arguments: {'PAGE_ID': pageId!},
          );
        }
      },
      leading: imageUrl.isEmpty
          ? const CircleAvatar(
              backgroundImage: AssetImage(Assets.assetsImagesPlaceholderPerson),
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
      title: Text(
        displayName,
        maxLines: 1,
        style: const TextStyle(
          color: kPrimaryColor,
          fontFamily: Assets.assetsFontsAnakotmaiMedium,
          fontSize: 14,
          // overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Row(
        children: [
          () {
            switch (typePost) {
              case 'GENERAL':
                return _buildDotTypePost(
                  typePost: 'ทั่วไป',
                  colorCode: kColorCodeGray,
                );

              case 'NEEDS':
                return _buildDotTypePost(
                  typePost: 'มองหา',
                  colorCode: kColorCodeDarkBlue,
                );

              case 'MEMBERSHIP':
                return _buildDotTypePost(
                  typePost: 'สมาชิกพรรค',
                  colorCode: kColorCodePrimary,
                );

              case 'FULFILLMENT':
                return _buildDotTypePost(
                  typePost: 'เติมเต็ม',
                  colorCode: kColorCodeDarkBlue,
                );

              default:
                return _buildDotTypePost(
                  typePost: 'ทั่วไป',
                  colorCode: kColorCodeGray,
                );
            }
          }(),
          Text(
            createdDate == null ? '' : ConvertTimeComponenet.convertToAgo(createdDate!),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: textGrey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      // *UGC
      trailing: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: const Icon(
          Icons.more_horiz_rounded,
          color: primaryBlue,
        ),
        onPressed: onPressedUGC,
      ),
    );
  }

  GestureDetector _buildBody() {
    return GestureDetector(
      onTap: () {
        if (postId.isNotEmpty) {
          Get.toNamed(
            AppRoutes.POST_DETAIL,
            arguments: {
              'POST_ID': postId,
              'FOCUS': false,
            },
          );
          return;
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gallery.isEmpty
                ? const SizedBox()
                : AlbumCard(
                    gallery: gallery,
                    onTap: null,
                  ),
            titlePost.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      top: gallery.isEmpty ? 0 : 20,
                    ),
                    child: Text(
                      titlePost,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: Assets.assetsFontsAnakotmaiMedium,
                        fontSize: gallery.isEmpty ? 25 : 17,
                        color: primaryBlue,
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: ReadMoreText(
                detailPost,
                trimLines: 6,
                trimLength: 200,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontFamily: Assets.assetsFontsAnakotmaiLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotTypePost({required String typePost, required int colorCode}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Color(colorCode),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 24),
          child: Text(
            typePost,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: textGrey,
              fontFamily: Assets.assetsFontsAnakotmaiMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
