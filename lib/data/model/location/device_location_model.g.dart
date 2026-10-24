// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceLocationModel _$DeviceLocationModelFromJson(Map<String, dynamic> json) =>
    DeviceLocationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      label: json['label'] as String?,
      languageCode: json['languageCode'] as String?,
      fetchedAt: json['fetchedAt'] == null
          ? null
          : DateTime.parse(json['fetchedAt'] as String),
    );

Map<String, dynamic> _$DeviceLocationModelToJson(
  DeviceLocationModel instance,
) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
  'label': instance.label,
  'languageCode': instance.languageCode,
  'fetchedAt': instance.fetchedAt?.toIso8601String(),
};
