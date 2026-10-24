import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sun_events_model.g.dart';

/// Sunrise and sunset, in UTC.
///
/// Either can be missing on its own — near the poles the sun may not rise or
/// set at all on a given day.
@JsonSerializable(explicitToJson: true)
class SunEventsModel extends Equatable {
  const SunEventsModel({this.sunriseTime, this.sunsetTime});

  @TimestampConverter()
  final DateTime? sunriseTime;

  @TimestampConverter()
  final DateTime? sunsetTime;

  factory SunEventsModel.fromJson(Map<String, dynamic> json) =>
      _$SunEventsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SunEventsModelToJson(this);

  @override
  List<Object?> get props => [sunriseTime, sunsetTime];
}
