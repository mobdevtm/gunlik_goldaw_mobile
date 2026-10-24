import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiHelper {
  const SystemUiHelper._();

  static SystemUiOverlayStyle styleForTheme(bool isDark) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: isDark ? const Color(0xFF161B27) : Colors.white,
      systemNavigationBarIconBrightness: isDark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }

  static void applyForTheme(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(styleForTheme(isDark));
  }
}
