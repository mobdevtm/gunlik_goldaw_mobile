// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_day_part_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDayPartModel _$ForecastDayPartModelFromJson(
  Map<String, dynamic> json,
) => ForecastDayPartModel(
  interval: json['interval'] == null
      ? null
      : IntervalModel.fromJson(json['interval'] as Map<String, dynamic>),
  weatherCondition: json['weatherCondition'] == null
      ? null
      : WeatherConditionModel.fromJson(
          json['weatherCondition'] as Map<String, dynamic>,
        ),
  relativeHumidity: (json['relativeHumidity'] as num?)?.toInt(),
  uvIndex: (json['uvIndex'] as num?)?.toInt(),
  precipitation: json['precipitation'] == null
      ? null
      : PrecipitationModel.fromJson(
          json['precipitation'] as Map<String, dynamic>,
        ),
  thunderstormProbability: (json['thunderstormProbability'] as num?)?.toInt(),
  wind: json['wind'] == null
      ? null
      : WindModel.fromJson(json['wind'] as Map<String, dynamic>),
  cloudCover: (json['cloudCover'] as num?)?.toInt(),
  iceThickness: json['iceThickness'] == null
      ? null
      : IceThicknessModel.fromJson(
          json['iceThickness'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ForecastDayPartModelToJson(
  ForecastDayPartModel instance,
) => <String, dynamic>{
  'interval': instance.interval?.toJson(),
  'weatherCondition': instance.weatherCondition?.toJson(),
  'relativeHumidity': instance.relativeHumidity,
  'uvIndex': instance.uvIndex,
  'precipitation': instance.precipitation?.toJson(),
  'thunderstormProbability': instance.thunderstormProbability,
  'wind': instance.wind?.toJson(),
  'cloudCover': instance.cloudCover,
  'iceThickness': instance.iceThickness?.toJson(),
};
