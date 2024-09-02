import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? iconImage;

  const MyAppBar({Key? key, this.title = '', this.iconImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Get.back(),
      ),
      centerTitle: iconImage == null ? true : false,
      title: iconImage == null
          ? Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: textDark,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(iconImage!),
                  backgroundColor: Colors.transparent,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: textDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
