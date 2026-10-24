// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visibility_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisibilityModel _$VisibilityModelFromJson(Map<String, dynamic> json) =>
    VisibilityModel(
      distance: (json['distance'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$VisibilityModelToJson(VisibilityModel instance) =>
    <String, dynamic>{'distance': instance.distance, 'unit': instance.unit};
