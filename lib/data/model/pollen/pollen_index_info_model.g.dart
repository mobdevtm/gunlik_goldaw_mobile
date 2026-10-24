// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pollen_index_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollenIndexInfoModel _$PollenIndexInfoModelFromJson(
  Map<String, dynamic> json,
) => PollenIndexInfoModel(
  code: json['code'] as String?,
  displayName: json['displayName'] as String?,
  category: json['category'] as String?,
  indexDescription: json['indexDescription'] as String?,
  color: json['color'] == null
      ? null
      : ColorModel.fromJson(json['color'] as Map<String, dynamic>),
  value: (json['value'] as num?)?.toInt(),
);

Map<String, dynamic> _$PollenIndexInfoModelToJson(
  PollenIndexInfoModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'displayName': instance.displayName,
  'category': instance.category,
  'indexDescription': instance.indexDescription,
  'color': instance.color?.toJson(),
  'value': instance.value,
};
