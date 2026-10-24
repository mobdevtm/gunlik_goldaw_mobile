// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDayModel _$ForecastDayModelFromJson(
  Map<String, dynamic> json,
) => ForecastDayModel(
  interval: json['interval'] == null
      ? null
      : IntervalModel.fromJson(json['interval'] as Map<String, dynamic>),
  displayDate: json['displayDate'] == null
      ? null
      : DateModel.fromJson(json['displayDate'] as Map<String, dynamic>),
  daytimeForecast: json['daytimeForecast'] == null
      ? null
      : ForecastDayPartModel.fromJson(
          json['daytimeForecast'] as Map<String, dynamic>,
        ),
  nighttimeForecast: json['nighttimeForecast'] == null
      ? null
      : ForecastDayPartModel.fromJson(
          json['nighttimeForecast'] as Map<String, dynamic>,
        ),
  maxTemperature: json['maxTemperature'] == null
      ? null
      : TemperatureModel.fromJson(
          json['maxTemperature'] as Map<String, dynamic>,
        ),
  minTemperature: json['minTemperature'] == null
      ? null
      : TemperatureModel.fromJson(
          json['minTemperature'] as Map<String, dynamic>,
        ),
  feelsLikeMaxTemperature: json['feelsLikeMaxTemperature'] == null
      ? null
      : TemperatureModel.fromJson(
          json['feelsLikeMaxTemperature'] as Map<String, dynamic>,
        ),
  feelsLikeMinTemperature: json['feelsLikeMinTemperature'] == null
      ? null
      : TemperatureModel.fromJson(
          json['feelsLikeMinTemperature'] as Map<String, dynamic>,
        ),
  maxHeatIndex: json['maxHeatIndex'] == null
      ? null
      : TemperatureModel.fromJson(json['maxHeatIndex'] as Map<String, dynamic>),
  sunEvents: json['sunEvents'] == null
      ? null
      : SunEventsModel.fromJson(json['sunEvents'] as Map<String, dynamic>),
  moonEvents: json['moonEvents'] == null
      ? null
      : MoonEventsModel.fromJson(json['moonEvents'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ForecastDayModelToJson(ForecastDayModel instance) =>
    <String, dynamic>{
      'interval': instance.interval?.toJson(),
      'displayDate': instance.displayDate?.toJson(),
      'daytimeForecast': instance.daytimeForecast?.toJson(),
      'nighttimeForecast': instance.nighttimeForecast?.toJson(),
      'maxTemperature': instance.maxTemperature?.toJson(),
      'minTemperature': instance.minTemperature?.toJson(),
      'feelsLikeMaxTemperature': instance.feelsLikeMaxTemperature?.toJson(),
      'feelsLikeMinTemperature': instance.feelsLikeMinTemperature?.toJson(),
      'maxHeatIndex': instance.maxHeatIndex?.toJson(),
      'sunEvents': instance.sunEvents?.toJson(),
      'moonEvents': instance.moonEvents?.toJson(),
    };
