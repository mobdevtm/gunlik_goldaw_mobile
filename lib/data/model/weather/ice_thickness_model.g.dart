// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ice_thickness_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IceThicknessModel _$IceThicknessModelFromJson(Map<String, dynamic> json) =>
    IceThicknessModel(
      thickness: (json['thickness'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$IceThicknessModelToJson(IceThicknessModel instance) =>
    <String, dynamic>{'thickness': instance.thickness, 'unit': instance.unit};
