import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The Universal AQI's bands, where higher is cleaner air.
enum AqiLevel {
  excellent(
    labelKey: 'aqi_excellent',
    light: Color(0xFF2E9E5B),
    dark: Color(0xFF5FD08C),
  ),
  good(labelKey: 'aqi_good', light: Color(0xFF7FA31E), dark: Color(0xFFB4D45A)),
  moderate(
    labelKey: 'aqi_moderate',
    light: Color(0xFFC9A11B),
    dark: Color(0xFFF0CC4E),
  ),
  low(labelKey: 'aqi_low', light: Color(0xFFDB7A1F), dark: Color(0xFFF5A05A)),
  poor(labelKey: 'aqi_poor', light: Color(0xFFD0453F), dark: Color(0xFFF0807A));

  const AqiLevel({
    required this.labelKey,
    required this.light,
    required this.dark,
  });

  final String labelKey;
  final Color light;
  final Color dark;

  Color color(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}

class AirQualityMapper {
  AirQualityMapper._();

  /// The index code of the Universal AQI in `indexes[]`.
  static const universalAqiCode = 'uaqi';

  static PhosphorIconData icon([
    PhosphorIconsStyle style = PhosphorIconsStyle.duotone,
  ]) => PhosphorIcons.wind(style);

  /// Bands as Google defines them for the Universal AQI (0–100).
  static AqiLevel? level(int? aqi) => switch (aqi) {
    null => null,
    >= 80 => AqiLevel.excellent,
    >= 60 => AqiLevel.good,
    >= 40 => AqiLevel.moderate,
    >= 20 => AqiLevel.low,
    _ => AqiLevel.poor,
  };
}
