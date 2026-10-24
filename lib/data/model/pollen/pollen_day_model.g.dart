// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pollen_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollenDayModel _$PollenDayModelFromJson(Map<String, dynamic> json) =>
    PollenDayModel(
      date: json['date'] == null
          ? null
          : DateModel.fromJson(json['date'] as Map<String, dynamic>),
      pollenTypeInfo: (json['pollenTypeInfo'] as List<dynamic>?)
          ?.map((e) => PollenTypeInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      plantInfo: (json['plantInfo'] as List<dynamic>?)
          ?.map((e) => PlantInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PollenDayModelToJson(
  PollenDayModel instance,
) => <String, dynamic>{
  'date': instance.date?.toJson(),
  'pollenTypeInfo': instance.pollenTypeInfo?.map((e) => e.toJson()).toList(),
  'plantInfo': instance.plantInfo?.map((e) => e.toJson()).toList(),
};
