// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_hour_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherHourModel _$WeatherHourModelFromJson(
  Map<String, dynamic> json,
) => WeatherHourModel(
  interval: json['interval'] == null
      ? null
      : IntervalModel.fromJson(json['interval'] as Map<String, dynamic>),
  displayDateTime: json['displayDateTime'] == null
      ? null
      : DateTimeModel.fromJson(json['displayDateTime'] as Map<String, dynamic>),
  isDaytime: json['isDaytime'] as bool?,
  weatherCondition: json['weatherCondition'] == null
      ? null
      : WeatherConditionModel.fromJson(
          json['weatherCondition'] as Map<String, dynamic>,
        ),
  temperature: json['temperature'] == null
      ? null
      : TemperatureModel.fromJson(json['temperature'] as Map<String, dynamic>),
  feelsLikeTemperature: json['feelsLikeTemperature'] == null
      ? null
      : TemperatureModel.fromJson(
          json['feelsLikeTemperature'] as Map<String, dynamic>,
        ),
  dewPoint: json['dewPoint'] == null
      ? null
      : TemperatureModel.fromJson(json['dewPoint'] as Map<String, dynamic>),
  heatIndex: json['heatIndex'] == null
      ? null
      : TemperatureModel.fromJson(json['heatIndex'] as Map<String, dynamic>),
  windChill: json['windChill'] == null
      ? null
      : TemperatureModel.fromJson(json['windChill'] as Map<String, dynamic>),
  wetBulbTemperature: json['wetBulbTemperature'] == null
      ? null
      : TemperatureModel.fromJson(
          json['wetBulbTemperature'] as Map<String, dynamic>,
        ),
  relativeHumidity: (json['relativeHumidity'] as num?)?.toInt(),
  uvIndex: (json['uvIndex'] as num?)?.toInt(),
  precipitation: json['precipitation'] == null
      ? null
      : PrecipitationModel.fromJson(
          json['precipitation'] as Map<String, dynamic>,
        ),
  thunderstormProbability: (json['thunderstormProbability'] as num?)?.toInt(),
  airPressure: json['airPressure'] == null
      ? null
      : AirPressureModel.fromJson(json['airPressure'] as Map<String, dynamic>),
  wind: json['wind'] == null
      ? null
      : WindModel.fromJson(json['wind'] as Map<String, dynamic>),
  visibility: json['visibility'] == null
      ? null
      : VisibilityModel.fromJson(json['visibility'] as Map<String, dynamic>),
  cloudCover: (json['cloudCover'] as num?)?.toInt(),
  iceThickness: json['iceThickness'] == null
      ? null
      : IceThicknessModel.fromJson(
          json['iceThickness'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$WeatherHourModelToJson(WeatherHourModel instance) =>
    <String, dynamic>{
      'interval': instance.interval?.toJson(),
      'displayDateTime': instance.displayDateTime?.toJson(),
      'isDaytime': instance.isDaytime,
      'weatherCondition': instance.weatherCondition?.toJson(),
      'temperature': instance.temperature?.toJson(),
      'feelsLikeTemperature': instance.feelsLikeTemperature?.toJson(),
      'dewPoint': instance.dewPoint?.toJson(),
      'heatIndex': instance.heatIndex?.toJson(),
      'windChill': instance.windChill?.toJson(),
      'wetBulbTemperature': instance.wetBulbTemperature?.toJson(),
      'relativeHumidity': instance.relativeHumidity,
      'uvIndex': instance.uvIndex,
      'precipitation': instance.precipitation?.toJson(),
      'thunderstormProbability': instance.thunderstormProbability,
      'airPressure': instance.airPressure?.toJson(),
      'wind': instance.wind?.toJson(),
      'visibility': instance.visibility?.toJson(),
      'cloudCover': instance.cloudCover,
      'iceThickness': instance.iceThickness?.toJson(),
    };
