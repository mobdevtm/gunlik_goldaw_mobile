// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_conditions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentConditionsModel _$CurrentConditionsModelFromJson(
  Map<String, dynamic> json,
) => CurrentConditionsModel(
  currentTime: const TimestampConverter().fromJson(
    json['currentTime'] as String?,
  ),
  timeZone: json['timeZone'] == null
      ? null
      : TimeZoneModel.fromJson(json['timeZone'] as Map<String, dynamic>),
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
  currentConditionsHistory: json['currentConditionsHistory'] == null
      ? null
      : CurrentConditionsHistoryModel.fromJson(
          json['currentConditionsHistory'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CurrentConditionsModelToJson(
  CurrentConditionsModel instance,
) => <String, dynamic>{
  'currentTime': const TimestampConverter().toJson(instance.currentTime),
  'timeZone': instance.timeZone?.toJson(),
  'isDaytime': instance.isDaytime,
  'weatherCondition': instance.weatherCondition?.toJson(),
  'temperature': instance.temperature?.toJson(),
  'feelsLikeTemperature': instance.feelsLikeTemperature?.toJson(),
  'dewPoint': instance.dewPoint?.toJson(),
  'heatIndex': instance.heatIndex?.toJson(),
  'windChill': instance.windChill?.toJson(),
  'relativeHumidity': instance.relativeHumidity,
  'uvIndex': instance.uvIndex,
  'precipitation': instance.precipitation?.toJson(),
  'thunderstormProbability': instance.thunderstormProbability,
  'airPressure': instance.airPressure?.toJson(),
  'wind': instance.wind?.toJson(),
  'visibility': instance.visibility?.toJson(),
  'cloudCover': instance.cloudCover,
  'currentConditionsHistory': instance.currentConditionsHistory?.toJson(),
};
