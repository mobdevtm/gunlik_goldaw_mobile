// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moon_events_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoonEventsModel _$MoonEventsModelFromJson(Map<String, dynamic> json) =>
    MoonEventsModel(
      moonPhase: json['moonPhase'] as String?,
      moonriseTimes: (json['moonriseTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      moonsetTimes: (json['moonsetTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MoonEventsModelToJson(MoonEventsModel instance) =>
    <String, dynamic>{
      'moonPhase': instance.moonPhase,
      'moonriseTimes': instance.moonriseTimes,
      'moonsetTimes': instance.moonsetTimes,
    };
