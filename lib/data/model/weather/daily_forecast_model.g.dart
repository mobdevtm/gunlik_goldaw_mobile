// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyForecastModel _$DailyForecastModelFromJson(Map<String, dynamic> json) =>
    DailyForecastModel(
      forecastDays: (json['forecastDays'] as List<dynamic>?)
          ?.map((e) => ForecastDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeZone: json['timeZone'] == null
          ? null
          : TimeZoneModel.fromJson(json['timeZone'] as Map<String, dynamic>),
      nextPageToken: json['nextPageToken'] as String?,
    );

Map<String, dynamic> _$DailyForecastModelToJson(DailyForecastModel instance) =>
    <String, dynamic>{
      'forecastDays': instance.forecastDays?.map((e) => e.toJson()).toList(),
      'timeZone': instance.timeZone?.toJson(),
      'nextPageToken': instance.nextPageToken,
    };
