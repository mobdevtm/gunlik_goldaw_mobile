// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntervalModel _$IntervalModelFromJson(Map<String, dynamic> json) =>
    IntervalModel(
      startTime: const TimestampConverter().fromJson(
        json['startTime'] as String?,
      ),
      endTime: const TimestampConverter().fromJson(json['endTime'] as String?),
    );

Map<String, dynamic> _$IntervalModelToJson(IntervalModel instance) =>
    <String, dynamic>{
      'startTime': const TimestampConverter().toJson(instance.startTime),
      'endTime': const TimestampConverter().toJson(instance.endTime),
    };
