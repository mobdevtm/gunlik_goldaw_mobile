import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/timestamp_converter.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/air_pressure_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/current_conditions_history_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/precipitation_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/temperature_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/time_zone_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/visibility_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_condition_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/wind_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_conditions_model.g.dart';

/// The answer of `currentConditions:lookup`: the weather right now.
@JsonSerializable(explicitToJson: true)
class CurrentConditionsModel extends Equatable {
  const CurrentConditionsModel({
    this.currentTime,
    this.timeZone,
    this.isDaytime,
    this.weatherCondition,
    this.temperature,
    this.feelsLikeTemperature,
    this.dewPoint,
    this.heatIndex,
    this.windChill,
    this.relativeHumidity,
    this.uvIndex,
    this.precipitation,
    this.thunderstormProbability,
    this.airPressure,
    this.wind,
    this.visibility,
    this.cloudCover,
    this.currentConditionsHistory,
  });

  /// When these conditions were observed, in UTC.
  @TimestampConverter()
  final DateTime? currentTime;

  final TimeZoneModel? timeZone;
  final bool? isDaytime;
  final WeatherConditionModel? weatherCondition;
  final TemperatureModel? temperature;
  final TemperatureModel? feelsLikeTemperature;
  final TemperatureModel? dewPoint;
  final TemperatureModel? heatIndex;
  final TemperatureModel? windChill;

  /// Percent, 0 to 100.
  final int? relativeHumidity;
  final int? uvIndex;
  final PrecipitationModel? precipitation;

  /// Percent, 0 to 100.
  final int? thunderstormProbability;
  final AirPressureModel? airPressure;
  final WindModel? wind;
  final VisibilityModel? visibility;

  /// Percent of the sky covered, 0 to 100.
  final int? cloudCover;
  final CurrentConditionsHistoryModel? currentConditionsHistory;

  factory CurrentConditionsModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentConditionsModelToJson(this);

  @override
  List<Object?> get props => [
    currentTime,
    timeZone,
    isDaytime,
    weatherCondition,
    temperature,
    feelsLikeTemperature,
    dewPoint,
    heatIndex,
    windChill,
    relativeHumidity,
    uvIndex,
    precipitation,
    thunderstormProbability,
    airPressure,
    wind,
    visibility,
    cloudCover,
    currentConditionsHistory,
  ];
}
