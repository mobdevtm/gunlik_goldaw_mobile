import 'package:gunluk_goldaw_mobile/core/mappers/weather_tone.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef PhosphorIconBuilder =
    PhosphorIconData Function([PhosphorIconsStyle style]);

/// How one `weatherCondition.type` is drawn and worded.
class WeatherConditionVisual {
  const WeatherConditionVisual({
    required this.icon,
    required this.labelKey,
    required this.tone,
  });

  final PhosphorIconData icon;

  /// A translation key. Google's own `description.text` is never shown —
  /// it has no Turkmen.
  final String labelKey;
  final WeatherTone tone;
}

/// Maps the Weather API's condition enum to an icon, a label and a colour.
///
/// Grouped the way Google's own icon set groups them (see
/// `ApiDocs.weatherIcons`): drizzle, showers, heavy rain, flurries, snow
/// showers, heavy snow, wintry mix, storms. Only the clear and cloudy-with-sun
/// families have a night form — everything else looks the same after dark.
class WeatherConditionMapper {
  WeatherConditionMapper._();

  static const _unknown = _Spec(
    day: PhosphorIcons.question,
    labelKey: 'condition_unknown',
    tone: WeatherTone.unknown,
  );

  static const Map<String, _Spec> _specs = {
    'CLEAR': _Spec(
      day: PhosphorIcons.sun,
      night: PhosphorIcons.moon,
      labelKey: 'condition_clear',
      tone: WeatherTone.clearDay,
      nightTone: WeatherTone.clearNight,
    ),
    'MOSTLY_CLEAR': _Spec(
      day: PhosphorIcons.sunDim,
      night: PhosphorIcons.moonStars,
      labelKey: 'condition_mostly_clear',
      tone: WeatherTone.clearDay,
      nightTone: WeatherTone.clearNight,
    ),
    'PARTLY_CLOUDY': _Spec(
      day: PhosphorIcons.cloudSun,
      night: PhosphorIcons.cloudMoon,
      labelKey: 'condition_partly_cloudy',
      tone: WeatherTone.clearDay,
      nightTone: WeatherTone.clearNight,
    ),
    'MOSTLY_CLOUDY': _Spec(
      day: PhosphorIcons.cloudSun,
      night: PhosphorIcons.cloudMoon,
      labelKey: 'condition_mostly_cloudy',
      tone: WeatherTone.cloudy,
    ),
    'CLOUDY': _Spec(
      day: PhosphorIcons.cloud,
      labelKey: 'condition_cloudy',
      tone: WeatherTone.cloudy,
    ),
    'WINDY': _Spec(
      day: PhosphorIcons.wind,
      labelKey: 'condition_windy',
      tone: WeatherTone.wind,
    ),
    'WIND_AND_RAIN': _Spec(
      day: PhosphorIcons.cloudRain,
      labelKey: 'condition_wind_and_rain',
      tone: WeatherTone.wind,
    ),

    // Drizzle.
    'LIGHT_RAIN_SHOWERS': _Spec(
      day: PhosphorIcons.drop,
      labelKey: 'condition_light_rain_showers',
      tone: WeatherTone.rain,
    ),
    'CHANCE_OF_SHOWERS': _Spec(
      day: PhosphorIcons.drop,
      labelKey: 'condition_chance_of_showers',
      tone: WeatherTone.rain,
    ),
    'LIGHT_RAIN': _Spec(
      day: PhosphorIcons.drop,
      labelKey: 'condition_light_rain',
      tone: WeatherTone.rain,
    ),

    // Showers.
    'SCATTERED_SHOWERS': _Spec(
      day: PhosphorIcons.cloudRain,
      labelKey: 'condition_scattered_showers',
      tone: WeatherTone.rain,
    ),
    'RAIN_SHOWERS': _Spec(
      day: PhosphorIcons.cloudRain,
      labelKey: 'condition_rain_showers',
      tone: WeatherTone.rain,
    ),
    'LIGHT_TO_MODERATE_RAIN': _Spec(
      day: PhosphorIcons.cloudRain,
      labelKey: 'condition_light_to_moderate_rain',
      tone: WeatherTone.rain,
    ),
    'RAIN': _Spec(
      day: PhosphorIcons.cloudRain,
      labelKey: 'condition_rain',
      tone: WeatherTone.rain,
    ),

    // Heavy rain.
    'HEAVY_RAIN_SHOWERS': _Spec(
      day: PhosphorIcons.umbrella,
      labelKey: 'condition_heavy_rain_showers',
      tone: WeatherTone.rain,
    ),
    'MODERATE_TO_HEAVY_RAIN': _Spec(
      day: PhosphorIcons.umbrella,
      labelKey: 'condition_moderate_to_heavy_rain',
      tone: WeatherTone.rain,
    ),
    'HEAVY_RAIN': _Spec(
      day: PhosphorIcons.umbrella,
      labelKey: 'condition_heavy_rain',
      tone: WeatherTone.rain,
    ),
    'RAIN_PERIODICALLY_HEAVY': _Spec(
      day: PhosphorIcons.umbrella,
      labelKey: 'condition_rain_periodically_heavy',
      tone: WeatherTone.rain,
    ),

    // Flurries.
    'LIGHT_SNOW_SHOWERS': _Spec(
      day: PhosphorIcons.snowflake,
      labelKey: 'condition_light_snow_showers',
      tone: WeatherTone.snow,
    ),
    'LIGHT_SNOW': _Spec(
      day: PhosphorIcons.snowflake,
      labelKey: 'condition_light_snow',
      tone: WeatherTone.snow,
    ),

    // Snow showers.
    'CHANCE_OF_SNOW_SHOWERS': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_chance_of_snow_showers',
      tone: WeatherTone.snow,
    ),
    'SCATTERED_SNOW_SHOWERS': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_scattered_snow_showers',
      tone: WeatherTone.snow,
    ),
    'SNOW_SHOWERS': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_snow_showers',
      tone: WeatherTone.snow,
    ),
    'LIGHT_TO_MODERATE_SNOW': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_light_to_moderate_snow',
      tone: WeatherTone.snow,
    ),
    'SNOW': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_snow',
      tone: WeatherTone.snow,
    ),
    'SNOWSTORM': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_snowstorm',
      tone: WeatherTone.storm,
    ),

    // Heavy snow.
    'HEAVY_SNOW_SHOWERS': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_heavy_snow_showers',
      tone: WeatherTone.snow,
    ),
    'MODERATE_TO_HEAVY_SNOW': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_moderate_to_heavy_snow',
      tone: WeatherTone.snow,
    ),
    'HEAVY_SNOW': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_heavy_snow',
      tone: WeatherTone.snow,
    ),
    'SNOW_PERIODICALLY_HEAVY': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_snow_periodically_heavy',
      tone: WeatherTone.snow,
    ),
    'HEAVY_SNOW_STORM': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_heavy_snow_storm',
      tone: WeatherTone.storm,
    ),
    'BLOWING_SNOW': _Spec(
      day: PhosphorIcons.wind,
      labelKey: 'condition_blowing_snow',
      tone: WeatherTone.snow,
    ),

    // Wintry mix and hail.
    'RAIN_AND_SNOW': _Spec(
      day: PhosphorIcons.cloudSnow,
      labelKey: 'condition_rain_and_snow',
      tone: WeatherTone.mixed,
    ),
    'HAIL': _Spec(
      day: PhosphorIcons.cloudArrowDown,
      labelKey: 'condition_hail',
      tone: WeatherTone.mixed,
    ),
    'HAIL_SHOWERS': _Spec(
      day: PhosphorIcons.cloudArrowDown,
      labelKey: 'condition_hail_showers',
      tone: WeatherTone.mixed,
    ),

    // Thunderstorms.
    'THUNDERSTORM': _Spec(
      day: PhosphorIcons.cloudLightning,
      labelKey: 'condition_thunderstorm',
      tone: WeatherTone.storm,
    ),
    'THUNDERSHOWER': _Spec(
      day: PhosphorIcons.cloudLightning,
      labelKey: 'condition_thundershower',
      tone: WeatherTone.storm,
    ),
    'LIGHT_THUNDERSTORM_RAIN': _Spec(
      day: PhosphorIcons.cloudLightning,
      labelKey: 'condition_light_thunderstorm_rain',
      tone: WeatherTone.storm,
    ),
    'SCATTERED_THUNDERSTORMS': _Spec(
      day: PhosphorIcons.lightning,
      labelKey: 'condition_scattered_thunderstorms',
      tone: WeatherTone.storm,
    ),
    'HEAVY_THUNDERSTORM': _Spec(
      day: PhosphorIcons.cloudLightning,
      labelKey: 'condition_heavy_thunderstorm',
      tone: WeatherTone.storm,
    ),
  };

  /// [isDaytime] picks the night form where one exists. Null is read as
  /// day, the safer default when the field is missing.
  static WeatherConditionVisual map(
    String? type, {
    bool? isDaytime,
    PhosphorIconsStyle style = PhosphorIconsStyle.duotone,
  }) {
    final spec = _specs[type] ?? _unknown;
    final night = isDaytime == false;

    return WeatherConditionVisual(
      icon: ((night ? spec.night : null) ?? spec.day)(style),
      labelKey: spec.labelKey,
      tone: (night ? spec.nightTone : null) ?? spec.tone,
    );
  }
}

class _Spec {
  const _Spec({
    required this.day,
    required this.labelKey,
    required this.tone,
    this.night,
    this.nightTone,
  });

  final PhosphorIconBuilder day;
  final PhosphorIconBuilder? night;
  final String labelKey;
  final WeatherTone tone;
  final WeatherTone? nightTone;
}
