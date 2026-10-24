import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'moon_events_model.g.dart';

/// The moon's phase and its rises and sets over the day.
@JsonSerializable(explicitToJson: true)
class MoonEventsModel extends Equatable {
  const MoonEventsModel({
    this.moonPhase,
    this.moonriseTimes,
    this.moonsetTimes,
  });

  /// `NEW_MOON`, `WAXING_CRESCENT`, `FIRST_QUARTER`, `WAXING_GIBBOUS`,
  /// `FULL_MOON`, `WANING_GIBBOUS`, `LAST_QUARTER` or `WANING_CRESCENT`.
  final String? moonPhase;

  /// Raw timestamps: a day can hold zero, one or two of each.
  final List<String>? moonriseTimes;
  final List<String>? moonsetTimes;

  factory MoonEventsModel.fromJson(Map<String, dynamic> json) =>
      _$MoonEventsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoonEventsModelToJson(this);

  /// The first moonrise of the day, if it has one.
  DateTime? get firstMoonrise => _first(moonriseTimes);

  /// The first moonset of the day, if it has one.
  DateTime? get firstMoonset => _first(moonsetTimes);

  static DateTime? _first(List<String>? times) {
    if (times == null) return null;
    for (final raw in times) {
      final parsed = const TimestampConverter().fromJson(raw);
      if (parsed != null) return parsed;
    }
    return null;
  }

  @override
  List<Object?> get props => [moonPhase, moonriseTimes, moonsetTimes];
}
