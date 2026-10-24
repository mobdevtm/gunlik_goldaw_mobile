import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/date_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_part_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/interval_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/moon_events_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/sun_events_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/temperature_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast_day_model.g.dart';

/// One day of the daily forecast.
@JsonSerializable(explicitToJson: true)
class ForecastDayModel extends Equatable {
  const ForecastDayModel({
    this.interval,
    this.displayDate,
    this.daytimeForecast,
    this.nighttimeForecast,
    this.maxTemperature,
    this.minTemperature,
    this.feelsLikeMaxTemperature,
    this.feelsLikeMinTemperature,
    this.maxHeatIndex,
    this.sunEvents,
    this.moonEvents,
  });

  final IntervalModel? interval;

  /// The calendar day at the location — what the row is labelled with.
  final DateModel? displayDate;
  final ForecastDayPartModel? daytimeForecast;
  final ForecastDayPartModel? nighttimeForecast;
  final TemperatureModel? maxTemperature;
  final TemperatureModel? minTemperature;
  final TemperatureModel? feelsLikeMaxTemperature;
  final TemperatureModel? feelsLikeMinTemperature;
  final TemperatureModel? maxHeatIndex;
  final SunEventsModel? sunEvents;
  final MoonEventsModel? moonEvents;

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDayModelToJson(this);

  @override
  List<Object?> get props => [
    interval,
    displayDate,
    daytimeForecast,
    nighttimeForecast,
    maxTemperature,
    minTemperature,
    feelsLikeMaxTemperature,
    feelsLikeMinTemperature,
    maxHeatIndex,
    sunEvents,
    moonEvents,
  ];
}
