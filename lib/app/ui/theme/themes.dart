import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/assets.dart';
import '../utils/colors.dart';

class Themes {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    focusColor: kPrimaryColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kPrimaryColor,
    ),
    fontFamily: Assets.assetsFontsAnakotmaiLight,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
