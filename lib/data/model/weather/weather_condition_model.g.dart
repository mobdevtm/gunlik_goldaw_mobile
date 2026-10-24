// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherConditionModel _$WeatherConditionModelFromJson(
  Map<String, dynamic> json,
) => WeatherConditionModel(
  iconBaseUri: json['iconBaseUri'] as String?,
  description: json['description'] == null
      ? null
      : LocalizedTextModel.fromJson(
          json['description'] as Map<String, dynamic>,
        ),
  type: json['type'] as String?,
);

Map<String, dynamic> _$WeatherConditionModelToJson(
  WeatherConditionModel instance,
) => <String, dynamic>{
  'iconBaseUri': instance.iconBaseUri,
  'description': instance.description?.toJson(),
  'type': instance.type,
};
