import 'package:flutter/material.dart';

import '../config/app_information.dart';

class AllRightsReserve extends StatelessWidget {
  const AllRightsReserve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(height: 15),
        Center(
          child: Text(
            AppInformation.allRightsReserve,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SafeArea(
          left: false,
          top: false,
          right: false,
          child: SizedBox(),
        ),
      ],
    );
  }
}
