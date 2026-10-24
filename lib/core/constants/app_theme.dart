import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dimens.dart';

/// The app's theme: the iOS system palette in light and dark.
///
/// The shell is a [MaterialApp], but every screen is drawn with Cupertino
/// widgets, so the colours here are Apple's own and the Cupertino theme is
/// set explicitly — Material would otherwise hand the Cupertino widgets a
/// theme derived from its own colour scheme.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    Color resolve(CupertinoDynamicColor color) =>
        isDark ? color.darkColor : color.color;

    final background = resolve(CupertinoColors.systemGroupedBackground);
    final card = resolve(CupertinoColors.secondarySystemGroupedBackground);
    final label = resolve(CupertinoColors.label);
    final secondaryLabel = resolve(CupertinoColors.secondaryLabel);
    final separator = resolve(CupertinoColors.separator);
    final tint = resolve(CupertinoColors.systemBlue);

    final scheme = ColorScheme.fromSeed(seedColor: tint, brightness: brightness)
        .copyWith(
          primary: tint,
          onPrimary: CupertinoColors.white,
          surface: background,
          onSurface: label,
          onSurfaceVariant: secondaryLabel,
          surfaceContainer: card,
          outlineVariant: separator,
          error: resolve(CupertinoColors.systemRed),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      cardColor: card,
      dividerColor: separator,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: tint,
        scaffoldBackgroundColor: background,
        barBackgroundColor: background.withValues(alpha: 0.9),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: label, fontSize: Dimens.fontNormal),
      ),
    );
  }
}
