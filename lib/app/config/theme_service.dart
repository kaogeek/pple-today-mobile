import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../ui/utils/storage_keys.dart';

class ThemeService {
  final _box = GetStorage();

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return _box.read(StorageKeys.isDarkMode) ?? false;
  }

  void saveThemeMode(bool isDarkMode) {
    _box.write(StorageKeys.isDarkMode, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
  }
}
