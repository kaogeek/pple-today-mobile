// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../ui/utils/colors.dart';
import 'divider_component.dart';

class ButtonSocial extends StatelessWidget {
  final bool isLike;
  final int likeCount;
  final void Function() onTapLike;
  final bool isComment;
  final int commentCount;
  final void Function() onTapComment;
  final String urlShare;

  const ButtonSocial({
    Key? key,
    required this.isLike,
    required this.likeCount,
    required this.onTapLike,
    required this.isComment,
    required this.commentCount,
    required this.onTapComment,
    required this.urlShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DividerComponent(),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPostButton(
                icon: isLike ? Icons.favorite : Icons.favorite_outline,
                isValue: isLike,
                label: '$likeCount ถูกใจ',
                onTap: onTapLike,
              ),
              _buildPostButton(
                // icon: isComment ? MdiIcons.comment : MdiIcons.commentOutline,
                // isValue: isComment,
                icon: MdiIcons.commentOutline,
                label: '$commentCount ความคิดเห็น',
                onTap: onTapComment,
              ),
              Builder(builder: (context) {
                return _buildPostButton(
                  icon: Icons.share,
                  label: 'แชร์',
                  onTap: () async {
                    final box = context.findRenderObject() as RenderBox?;

                    await Share.share(
                      urlShare,
                      subject: urlShare,
                      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                );
              }),
            ],
          ),
        ),
        // Divider(height: 0, thickness: 1),
        // SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPostButton({
    required IconData icon,
    required String label,
    required void Function() onTap,
    bool? isValue,
  }) {
    return TextButton.icon(
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      onPressed: onTap,
      icon: Icon(
        icon,
        color: (isValue ?? false) ? kPrimaryColor : primaryBlue,
        size: 19,
      ),
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: primaryBlue,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
