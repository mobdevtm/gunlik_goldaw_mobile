// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeModel _$DateTimeModelFromJson(Map<String, dynamic> json) =>
    DateTimeModel(
      year: (json['year'] as num?)?.toInt(),
      month: (json['month'] as num?)?.toInt(),
      day: (json['day'] as num?)?.toInt(),
      hours: (json['hours'] as num?)?.toInt(),
      minutes: (json['minutes'] as num?)?.toInt(),
      seconds: (json['seconds'] as num?)?.toInt(),
      nanos: (json['nanos'] as num?)?.toInt(),
      utcOffset: json['utcOffset'] as String?,
      timeZone: json['timeZone'] == null
          ? null
          : TimeZoneModel.fromJson(json['timeZone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DateTimeModelToJson(DateTimeModel instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'hours': instance.hours,
      'minutes': instance.minutes,
      'seconds': instance.seconds,
      'nanos': instance.nanos,
      'utcOffset': instance.utcOffset,
      'timeZone': instance.timeZone?.toJson(),
    };
