import 'package:easy_localization/easy_localization.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/date_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/air_pressure_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/precipitation_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/temperature_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/visibility_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_hour_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/wind_model.dart';

/// Turns readings into the text shown on screen.
///
/// Every value can be missing, so every formatter answers [placeholder] for
/// null rather than leaving a gap or a "null" on a card. Units come from the
/// reading itself, not from the settings: a card always shows the unit the
/// number was actually measured in, even mid-way through a units switch.
class WeatherFormatters {
  WeatherFormatters._();

  static const placeholder = '—';

  static const _unitKeys = {
    'KILOMETERS_PER_HOUR': 'unit_kmh',
    'MILES_PER_HOUR': 'unit_mph',
    'MILLIMETERS': 'unit_mm',
    'INCHES': 'unit_in',
    'KILOMETERS': 'unit_km',
    'MILES': 'unit_mi',
  };

  static String _unit(String? unit) {
    final key = _unitKeys[unit];
    return key == null ? '' : ' ${key.tr()}';
  }

  /// `23°`. The scale is left to the units setting the user chose.
  static String temperature(TemperatureModel? temperature) {
    final degrees = temperature?.degrees;
    return degrees == null ? placeholder : '${degrees.round()}°';
  }

  /// `+3°` / `−2°`, for the change over the last 24 hours.
  static String temperatureChange(TemperatureModel? change) {
    final degrees = change?.degrees;
    if (degrees == null) return placeholder;
    final rounded = degrees.round();
    return rounded > 0 ? '+$rounded°' : '$rounded°';
  }

  static String percent(int? value) => value == null ? placeholder : '$value%';

  static String plain(int? value) => value == null ? placeholder : '$value';

  static String speed(WindSpeedModel? speed) {
    final value = speed?.value;
    return value == null
        ? placeholder
        : '${value.round()}${_unit(speed?.unit)}';
  }

  static String distance(VisibilityModel? visibility) {
    final value = visibility?.distance;
    return value == null
        ? placeholder
        : '${_trim(value)}${_unit(visibility?.unit)}';
  }

  static String amount(QpfModel? qpf) {
    final value = qpf?.quantity;
    return value == null
        ? placeholder
        : '${_trim(value, digits: qpf?.unit == 'INCHES' ? 2 : 1)}'
              '${_unit(qpf?.unit)}';
  }

  /// Millibars are hectopascals, so the value is shown as it comes.
  static String pressure(AirPressureModel? pressure) {
    final value = pressure?.meanSeaLevelMillibars;
    return value == null ? placeholder : '${value.round()} ${'unit_hpa'.tr()}';
  }

  /// `2 h 14 min`, in the user's language.
  static String duration(Duration? duration) {
    if (duration == null) return placeholder;
    return 'daylight_duration'.tr(
      args: ['${duration.inHours}', '${duration.inMinutes.remainder(60)}'],
    );
  }

  // ── Time at the location ──────────────────────────────────────────

  /// The location's offset from UTC, read off the first hour that has one.
  ///
  /// Hours carry it in `displayDateTime.utcOffset`; current conditions and
  /// sun events do not. Falls back to null, which the time formatters read
  /// as the device's own offset.
  static Duration? utcOffsetOf(Iterable<WeatherHourModel>? hours) {
    if (hours == null) return null;
    for (final hour in hours) {
      final offset = hour.displayDateTime?.utcOffsetDuration;
      if (offset != null) return offset;
    }
    return null;
  }

  /// [instant] read on the location's clock.
  ///
  /// The result keeps the location's wall-clock values in a UTC [DateTime],
  /// so formatting prints them as they are instead of shifting them again
  /// into the device's zone.
  static DateTime? wallClock(DateTime? instant, Duration? utcOffset) {
    if (instant == null) return null;
    return instant.toUtc().add(utcOffset ?? DateTime.now().timeZoneOffset);
  }

  /// `14:05` at the location.
  static String time(DateTime? instant, Duration? utcOffset, String locale) {
    final clock = wallClock(instant, utcOffset);
    return clock == null ? placeholder : DateFormat.Hm(locale).format(clock);
  }

  /// `14:00` for an hour of the hourly forecast or history.
  static String hour(WeatherHourModel hour, String locale) {
    final clock = hour.displayDateTime?.toWallClock();
    return clock == null ? placeholder : DateFormat.Hm(locale).format(clock);
  }

  /// "Today", "Tomorrow", or the weekday, judged against the location's
  /// own date rather than the device's.
  static String dayLabel(DateModel? date, Duration? utcOffset, String locale) {
    final day = date?.toDateTime();
    if (day == null) return placeholder;

    final now = wallClock(DateTime.now(), utcOffset)!;
    final today = DateTime(now.year, now.month, now.day);
    final difference = day.difference(today).inDays;

    if (difference == 0) return 'today'.tr();
    if (difference == 1) return 'tomorrow'.tr();
    return DateFormat.EEEE(locale).format(day);
  }

  /// `21 October`.
  static String dayMonth(DateModel? date, String locale) {
    final day = date?.toDateTime();
    return day == null ? placeholder : DateFormat.MMMMd(locale).format(day);
  }

  static String _trim(double value, {int digits = 1}) {
    final fixed = value.toStringAsFixed(digits);
    return fixed.contains('.')
        ? fixed.replaceFirst(RegExp(r'\.?0+$'), '')
        : fixed;
  }
}
