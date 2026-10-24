// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_conditions_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentConditionsHistoryModel _$CurrentConditionsHistoryModelFromJson(
  Map<String, dynamic> json,
) => CurrentConditionsHistoryModel(
  temperatureChange: json['temperatureChange'] == null
      ? null
      : TemperatureModel.fromJson(
          json['temperatureChange'] as Map<String, dynamic>,
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
  snowQpf: json['snowQpf'] == null
      ? null
      : QpfModel.fromJson(json['snowQpf'] as Map<String, dynamic>),
  qpf: json['qpf'] == null
      ? null
      : QpfModel.fromJson(json['qpf'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CurrentConditionsHistoryModelToJson(
  CurrentConditionsHistoryModel instance,
) => <String, dynamic>{
  'temperatureChange': instance.temperatureChange?.toJson(),
  'maxTemperature': instance.maxTemperature?.toJson(),
  'minTemperature': instance.minTemperature?.toJson(),
  'snowQpf': instance.snowQpf?.toJson(),
  'qpf': instance.qpf?.toJson(),
};
