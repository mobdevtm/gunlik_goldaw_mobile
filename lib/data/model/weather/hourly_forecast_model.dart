import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/time_zone_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_hour_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hourly_forecast_model.g.dart';

/// One page of `forecast/hours:lookup`.
@JsonSerializable(explicitToJson: true)
class HourlyForecastModel extends Equatable {
  const HourlyForecastModel({
    this.forecastHours,
    this.timeZone,
    this.nextPageToken,
  });

  final List<WeatherHourModel>? forecastHours;
  final TimeZoneModel? timeZone;
  final String? nextPageToken;

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyForecastModelToJson(this);

  @override
  List<Object?> get props => [forecastHours, timeZone, nextPageToken];
}
