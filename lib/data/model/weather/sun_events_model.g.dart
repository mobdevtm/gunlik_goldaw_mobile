// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sun_events_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SunEventsModel _$SunEventsModelFromJson(Map<String, dynamic> json) =>
    SunEventsModel(
      sunriseTime: const TimestampConverter().fromJson(
        json['sunriseTime'] as String?,
      ),
      sunsetTime: const TimestampConverter().fromJson(
        json['sunsetTime'] as String?,
      ),
    );

Map<String, dynamic> _$SunEventsModelToJson(SunEventsModel instance) =>
    <String, dynamic>{
      'sunriseTime': const TimestampConverter().toJson(instance.sunriseTime),
      'sunsetTime': const TimestampConverter().toJson(instance.sunsetTime),
    };
