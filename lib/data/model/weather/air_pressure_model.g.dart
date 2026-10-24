// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_pressure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirPressureModel _$AirPressureModelFromJson(Map<String, dynamic> json) =>
    AirPressureModel(
      meanSeaLevelMillibars: (json['meanSeaLevelMillibars'] as num?)
          ?.toDouble(),
    );

Map<String, dynamic> _$AirPressureModelToJson(AirPressureModel instance) =>
    <String, dynamic>{'meanSeaLevelMillibars': instance.meanSeaLevelMillibars};
