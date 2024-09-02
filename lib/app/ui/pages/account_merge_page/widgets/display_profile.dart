// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'profile_merge_today.dart';
import 'profile_merge_user.dart';

class DisplayProfile extends StatelessWidget {
  DisplayProfile({Key? key}) : super(key: key);

  List<String> authUser = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProfileMergeUser(),
        const Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 50,
        ),
        ProfileMergeUserToday(),
      ],
    );
  }
}
