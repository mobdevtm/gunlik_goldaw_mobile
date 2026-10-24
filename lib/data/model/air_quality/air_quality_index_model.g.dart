// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality_index_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirQualityIndexModel _$AirQualityIndexModelFromJson(
  Map<String, dynamic> json,
) => AirQualityIndexModel(
  code: json['code'] as String?,
  displayName: json['displayName'] as String?,
  aqi: (json['aqi'] as num?)?.toInt(),
  aqiDisplay: json['aqiDisplay'] as String?,
  color: json['color'] == null
      ? null
      : ColorModel.fromJson(json['color'] as Map<String, dynamic>),
  category: json['category'] as String?,
  dominantPollutant: json['dominantPollutant'] as String?,
);

Map<String, dynamic> _$AirQualityIndexModelToJson(
  AirQualityIndexModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'displayName': instance.displayName,
  'aqi': instance.aqi,
  'aqiDisplay': instance.aqiDisplay,
  'color': instance.color?.toJson(),
  'category': instance.category,
  'dominantPollutant': instance.dominantPollutant,
};
