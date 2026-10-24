import 'package:gunluk_goldaw_mobile/data/model/weather/sun_events_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum SunEventKind { sunrise, sunset }

/// Icons and words for sunrise and sunset.
///
/// Phosphor draws one sun-on-the-horizon, so the two are told apart by the
/// arrow beside it: up for sunrise, down for sunset.
class SunEventsMapper {
  SunEventsMapper._();

  static PhosphorIconData icon([
    PhosphorIconsStyle style = PhosphorIconsStyle.duotone,
  ]) => PhosphorIcons.sunHorizon(style);

  static PhosphorIconData arrow(
    SunEventKind kind, [
    PhosphorIconsStyle style = PhosphorIconsStyle.bold,
  ]) => switch (kind) {
    SunEventKind.sunrise => PhosphorIcons.arrowUp(style),
    SunEventKind.sunset => PhosphorIcons.arrowDown(style),
  };

  static String labelKey(SunEventKind kind) => switch (kind) {
    SunEventKind.sunrise => 'sunrise',
    SunEventKind.sunset => 'sunset',
  };

  /// Time between sunrise and sunset, or null when either is missing.
  static Duration? daylight(SunEventsModel? events) {
    final rise = events?.sunriseTime;
    final set = events?.sunsetTime;
    if (rise == null || set == null || !set.isAfter(rise)) return null;
    return set.difference(rise);
  }
}
