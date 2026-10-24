// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyForecastModel _$HourlyForecastModelFromJson(Map<String, dynamic> json) =>
    HourlyForecastModel(
      forecastHours: (json['forecastHours'] as List<dynamic>?)
          ?.map((e) => WeatherHourModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeZone: json['timeZone'] == null
          ? null
          : TimeZoneModel.fromJson(json['timeZone'] as Map<String, dynamic>),
      nextPageToken: json['nextPageToken'] as String?,
    );

Map<String, dynamic> _$HourlyForecastModelToJson(
  HourlyForecastModel instance,
) => <String, dynamic>{
  'forecastHours': instance.forecastHours?.map((e) => e.toJson()).toList(),
  'timeZone': instance.timeZone?.toJson(),
  'nextPageToken': instance.nextPageToken,
};
