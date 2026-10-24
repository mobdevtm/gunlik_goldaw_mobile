import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/ice_thickness_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/interval_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/precipitation_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_condition_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/wind_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast_day_part_model.g.dart';

/// Half of a forecast day: daytime (07:00–19:00) or nighttime
/// (19:00–07:00 the next day), local time.
@JsonSerializable(explicitToJson: true)
class ForecastDayPartModel extends Equatable {
  const ForecastDayPartModel({
    this.interval,
    this.weatherCondition,
    this.relativeHumidity,
    this.uvIndex,
    this.precipitation,
    this.thunderstormProbability,
    this.wind,
    this.cloudCover,
    this.iceThickness,
  });

  final IntervalModel? interval;
  final WeatherConditionModel? weatherCondition;
  final int? relativeHumidity;
  final int? uvIndex;
  final PrecipitationModel? precipitation;
  final int? thunderstormProbability;
  final WindModel? wind;
  final int? cloudCover;
  final IceThicknessModel? iceThickness;

  factory ForecastDayPartModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayPartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDayPartModelToJson(this);

  @override
  List<Object?> get props => [
    interval,
    weatherCondition,
    relativeHumidity,
    uvIndex,
    precipitation,
    thunderstormProbability,
    wind,
    cloudCover,
    iceThickness,
  ];
}
