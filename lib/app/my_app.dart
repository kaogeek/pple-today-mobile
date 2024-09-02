import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/theme_service.dart';
import 'data/services/analytics_service.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'ui/layouts/main/main_layout.dart';
import 'ui/theme/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PPLE Today',
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: kDebugMode,
      theme: Themes().lightTheme,
      // darkTheme: Themes().darkTheme,
      themeMode: ThemeService().getThemeMode(),
      // translations: Translation(),
      // locale: Locale('en'),
      // fallbackLocale: Locale('en'),
      initialRoute: AppRoutes.SPLASH,
      // unknownRoute: AppPages.unknownRoutePage,
      getPages: AppPages.pages,
      navigatorObservers: [
        AnalyticsService.observer,
      ],

      builder: (_, child) {
        return MainLayout(child: child);
      },
    );
  }
}
