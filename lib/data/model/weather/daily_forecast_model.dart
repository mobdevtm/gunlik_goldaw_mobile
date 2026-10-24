import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/time_zone_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_forecast_model.g.dart';

/// One page of `forecast/days:lookup`.
///
/// The repository follows [nextPageToken] and hands the blocs a single model
/// holding every day.
@JsonSerializable(explicitToJson: true)
class DailyForecastModel extends Equatable {
  const DailyForecastModel({
    this.forecastDays,
    this.timeZone,
    this.nextPageToken,
  });

  final List<ForecastDayModel>? forecastDays;
  final TimeZoneModel? timeZone;
  final String? nextPageToken;

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyForecastModelToJson(this);

  @override
  List<Object?> get props => [forecastDays, timeZone, nextPageToken];
}
