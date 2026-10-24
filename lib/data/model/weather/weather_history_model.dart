import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/time_zone_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_hour_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_history_model.g.dart';

/// One page of `history/hours:lookup`, newest hour first.
@JsonSerializable(explicitToJson: true)
class WeatherHistoryModel extends Equatable {
  const WeatherHistoryModel({
    this.historyHours,
    this.timeZone,
    this.nextPageToken,
  });

  final List<WeatherHourModel>? historyHours;
  final TimeZoneModel? timeZone;
  final String? nextPageToken;

  factory WeatherHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherHistoryModelToJson(this);

  @override
  List<Object?> get props => [historyHours, timeZone, nextPageToken];
}
