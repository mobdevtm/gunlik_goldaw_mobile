import 'package:flutter/material.dart';

/// The colour family a reading belongs to.
///
/// Colour is spent sparingly on the grouped cards: one accent per condition
/// for the icon, and a soft two-stop gradient that sits behind it. Dark mode
/// lifts each accent a step so it still reads on the black ground without
/// glowing.
enum WeatherTone {
  clearDay(light: Color(0xFFE09A1E), dark: Color(0xFFF5B94A)),
  clearNight(light: Color(0xFF4A5BB5), dark: Color(0xFF8E9CF0)),
  cloudy(light: Color(0xFF6E7C86), dark: Color(0xFFA3B0B9)),
  rain(light: Color(0xFF2A6FA8), dark: Color(0xFF6FB3E8)),
  snow(light: Color(0xFF3E8FAE), dark: Color(0xFF9AD8EE)),
  storm(light: Color(0xFF6A4BB0), dark: Color(0xFFA690F0)),
  wind(light: Color(0xFF2D8C84), dark: Color(0xFF6FD0C4)),
  mixed(light: Color(0xFF5B7896), dark: Color(0xFFA6BCD3)),
  unknown(light: Color(0xFF8A938B), dark: Color(0xFF9BA69C));

  const WeatherTone({required this.light, required this.dark});

  final Color light;
  final Color dark;

  Color accent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;

  /// Two stops from a faint wash of the accent to transparent, for the
  /// backdrop behind an icon or a hero card.
  List<Color> gradient(BuildContext context) {
    final color = accent(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      color.withValues(alpha: isDark ? 0.28 : 0.22),
      color.withValues(alpha: 0),
    ];
  }
}
