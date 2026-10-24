// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirQualityModel _$AirQualityModelFromJson(Map<String, dynamic> json) =>
    AirQualityModel(
      dateTime: const TimestampConverter().fromJson(
        json['dateTime'] as String?,
      ),
      regionCode: json['regionCode'] as String?,
      indexes: (json['indexes'] as List<dynamic>?)
          ?.map((e) => AirQualityIndexModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pollutants: (json['pollutants'] as List<dynamic>?)
          ?.map((e) => PollutantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      healthRecommendations: json['healthRecommendations'] == null
          ? null
          : HealthRecommendationsModel.fromJson(
              json['healthRecommendations'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AirQualityModelToJson(AirQualityModel instance) =>
    <String, dynamic>{
      'dateTime': const TimestampConverter().toJson(instance.dateTime),
      'regionCode': instance.regionCode,
      'indexes': instance.indexes?.map((e) => e.toJson()).toList(),
      'pollutants': instance.pollutants?.map((e) => e.toJson()).toList(),
      'healthRecommendations': instance.healthRecommendations?.toJson(),
    };
