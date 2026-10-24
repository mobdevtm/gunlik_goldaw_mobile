import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/air_pressure_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/date_time_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/ice_thickness_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/interval_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/precipitation_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/temperature_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/visibility_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_condition_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/wind_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_hour_model.g.dart';

/// One hour of weather, forecast or past.
///
/// The API's `ForecastHour` and `HistoryHour` carry exactly the same fields,
/// so one model reads both: an hour on the history chart and an hour in the
/// forecast list are the same thing seen from different sides of now.
@JsonSerializable(explicitToJson: true)
class WeatherHourModel extends Equatable {
  const WeatherHourModel({
    this.interval,
    this.displayDateTime,
    this.isDaytime,
    this.weatherCondition,
    this.temperature,
    this.feelsLikeTemperature,
    this.dewPoint,
    this.heatIndex,
    this.windChill,
    this.wetBulbTemperature,
    this.relativeHumidity,
    this.uvIndex,
    this.precipitation,
    this.thunderstormProbability,
    this.airPressure,
    this.wind,
    this.visibility,
    this.cloudCover,
    this.iceThickness,
  });

  final IntervalModel? interval;

  /// The hour on the location's own clock, with its UTC offset.
  final DateTimeModel? displayDateTime;
  final bool? isDaytime;
  final WeatherConditionModel? weatherCondition;
  final TemperatureModel? temperature;
  final TemperatureModel? feelsLikeTemperature;
  final TemperatureModel? dewPoint;
  final TemperatureModel? heatIndex;
  final TemperatureModel? windChill;
  final TemperatureModel? wetBulbTemperature;
  final int? relativeHumidity;
  final int? uvIndex;
  final PrecipitationModel? precipitation;
  final int? thunderstormProbability;
  final AirPressureModel? airPressure;
  final WindModel? wind;
  final VisibilityModel? visibility;
  final int? cloudCover;
  final IceThicknessModel? iceThickness;

  factory WeatherHourModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherHourModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherHourModelToJson(this);

  @override
  List<Object?> get props => [
    interval,
    displayDateTime,
    isDaytime,
    weatherCondition,
    temperature,
    feelsLikeTemperature,
    dewPoint,
    heatIndex,
    windChill,
    wetBulbTemperature,
    relativeHumidity,
    uvIndex,
    precipitation,
    thunderstormProbability,
    airPressure,
    wind,
    visibility,
    cloudCover,
    iceThickness,
  ];
}
