// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindModel _$WindModelFromJson(Map<String, dynamic> json) => WindModel(
  direction: json['direction'] == null
      ? null
      : WindDirectionModel.fromJson(json['direction'] as Map<String, dynamic>),
  speed: json['speed'] == null
      ? null
      : WindSpeedModel.fromJson(json['speed'] as Map<String, dynamic>),
  gust: json['gust'] == null
      ? null
      : WindSpeedModel.fromJson(json['gust'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WindModelToJson(WindModel instance) => <String, dynamic>{
  'direction': instance.direction?.toJson(),
  'speed': instance.speed?.toJson(),
  'gust': instance.gust?.toJson(),
};

WindDirectionModel _$WindDirectionModelFromJson(Map<String, dynamic> json) =>
    WindDirectionModel(
      degrees: (json['degrees'] as num?)?.toInt(),
      cardinal: json['cardinal'] as String?,
    );

Map<String, dynamic> _$WindDirectionModelToJson(WindDirectionModel instance) =>
    <String, dynamic>{
      'degrees': instance.degrees,
      'cardinal': instance.cardinal,
    };

WindSpeedModel _$WindSpeedModelFromJson(Map<String, dynamic> json) =>
    WindSpeedModel(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$WindSpeedModelToJson(WindSpeedModel instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};
