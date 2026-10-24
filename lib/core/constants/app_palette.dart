import 'package:flutter/cupertino.dart';

/// The iOS system colours the app is drawn with.
///
/// Each is a [CupertinoDynamicColor], resolved against the ambient theme, so
/// light and dark (and high contrast) come for free and stay the colours
/// iOS users already know.
class AppPalette {
  AppPalette._();

  static Color _resolve(Color color, BuildContext context) =>
      CupertinoDynamicColor.resolve(color, context);

  /// The screen behind the cards — `systemGroupedBackground`.
  static Color background(BuildContext context) =>
      _resolve(CupertinoColors.systemGroupedBackground, context);

  /// A card on that screen — `secondarySystemGroupedBackground`.
  static Color card(BuildContext context) =>
      _resolve(CupertinoColors.secondarySystemGroupedBackground, context);

  /// A tile, track or chip inside a card — `tertiarySystemFill`.
  static Color fill(BuildContext context) =>
      _resolve(CupertinoColors.tertiarySystemFill, context);

  static Color label(BuildContext context) =>
      _resolve(CupertinoColors.label, context);

  static Color secondaryLabel(BuildContext context) =>
      _resolve(CupertinoColors.secondaryLabel, context);

  static Color separator(BuildContext context) =>
      _resolve(CupertinoColors.separator, context);

  /// The app's tint — iOS system blue.
  static Color tint(BuildContext context) =>
      _resolve(CupertinoColors.systemBlue, context);

  static Color warning(BuildContext context) =>
      _resolve(CupertinoColors.systemOrange, context);
}
