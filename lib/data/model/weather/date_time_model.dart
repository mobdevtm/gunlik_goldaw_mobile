import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/time_zone_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_time_model.g.dart';

/// A wall-clock time at the forecast location (`google.type.DateTime`).
///
/// This is what an hour is shown as. It carries the location's offset from
/// UTC in [utcOffset], so the place's own clock can be shown without a time
/// zone database on the device.
@JsonSerializable(explicitToJson: true)
class DateTimeModel extends Equatable {
  const DateTimeModel({
    this.year,
    this.month,
    this.day,
    this.hours,
    this.minutes,
    this.seconds,
    this.nanos,
    this.utcOffset,
    this.timeZone,
  });

  final int? year;
  final int? month;
  final int? day;
  final int? hours;
  final int? minutes;
  final int? seconds;
  final int? nanos;

  /// Duration string in whole seconds, e.g. `"18000s"` for UTC+5.
  final String? utcOffset;

  /// Sent instead of [utcOffset], never together with it.
  final TimeZoneModel? timeZone;

  factory DateTimeModel.fromJson(Map<String, dynamic> json) =>
      _$DateTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateTimeModelToJson(this);

  /// [utcOffset] as a [Duration], or null when absent or unreadable.
  Duration? get utcOffsetDuration {
    final raw = utcOffset;
    if (raw == null || !raw.endsWith('s')) return null;
    final seconds = double.tryParse(raw.substring(0, raw.length - 1));
    return seconds == null ? null : Duration(seconds: seconds.round());
  }

  /// The location's wall-clock time as a plain [DateTime], or null when the
  /// date is incomplete.
  ///
  /// Built as a local value on purpose: it is a reading of the place's clock
  /// for display, not an instant to convert.
  DateTime? toWallClock() {
    final y = year, m = month, d = day;
    if (y == null || m == null || d == null) return null;
    if (y == 0 || m == 0 || d == 0) return null;
    return DateTime(y, m, d, hours ?? 0, minutes ?? 0, seconds ?? 0);
  }

  @override
  List<Object?> get props => [
    year,
    month,
    day,
    hours,
    minutes,
    seconds,
    nanos,
    utcOffset,
    timeZone,
  ];
}
