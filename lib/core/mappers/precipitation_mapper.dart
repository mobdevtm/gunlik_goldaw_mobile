import 'package:phosphor_flutter/phosphor_flutter.dart';

/// How a `precipitation.probability.type` is drawn and worded.
class PrecipitationVisual {
  const PrecipitationVisual({required this.icon, required this.labelKey});

  final PhosphorIconData icon;
  final String labelKey;
}

class PrecipitationMapper {
  PrecipitationMapper._();

  static PrecipitationVisual map(
    String? type, {
    PhosphorIconsStyle style = PhosphorIconsStyle.duotone,
  }) => switch (type) {
    'NONE' => PrecipitationVisual(
      icon: PhosphorIcons.dropSimple(style),
      labelKey: 'precip_none',
    ),
    'RAIN' => PrecipitationVisual(
      icon: PhosphorIcons.drop(style),
      labelKey: 'precip_rain',
    ),
    'LIGHT_RAIN' => PrecipitationVisual(
      icon: PhosphorIcons.dropHalfBottom(style),
      labelKey: 'precip_light_rain',
    ),
    'HEAVY_RAIN' => PrecipitationVisual(
      icon: PhosphorIcons.umbrella(style),
      labelKey: 'precip_heavy_rain',
    ),
    'SNOW' => PrecipitationVisual(
      icon: PhosphorIcons.snowflake(style),
      labelKey: 'precip_snow',
    ),
    'RAIN_AND_SNOW' => PrecipitationVisual(
      icon: PhosphorIcons.cloudSnow(style),
      labelKey: 'precip_rain_and_snow',
    ),
    'SLEET' => PrecipitationVisual(
      icon: PhosphorIcons.cloudSnow(style),
      labelKey: 'precip_sleet',
    ),
    'FREEZING_RAIN' => PrecipitationVisual(
      icon: PhosphorIcons.thermometerCold(style),
      labelKey: 'precip_freezing_rain',
    ),
    _ => PrecipitationVisual(
      icon: PhosphorIcons.drop(style),
      labelKey: 'precipitation',
    ),
  };
}
