// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherHistoryModel _$WeatherHistoryModelFromJson(Map<String, dynamic> json) =>
    WeatherHistoryModel(
      historyHours: (json['historyHours'] as List<dynamic>?)
          ?.map((e) => WeatherHourModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeZone: json['timeZone'] == null
          ? null
          : TimeZoneModel.fromJson(json['timeZone'] as Map<String, dynamic>),
      nextPageToken: json['nextPageToken'] as String?,
    );

Map<String, dynamic> _$WeatherHistoryModelToJson(
  WeatherHistoryModel instance,
) => <String, dynamic>{
  'historyHours': instance.historyHours?.map((e) => e.toJson()).toList(),
  'timeZone': instance.timeZone?.toJson(),
  'nextPageToken': instance.nextPageToken,
};
