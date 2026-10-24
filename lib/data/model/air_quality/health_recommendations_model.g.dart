// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_recommendations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthRecommendationsModel _$HealthRecommendationsModelFromJson(
  Map<String, dynamic> json,
) => HealthRecommendationsModel(
  generalPopulation: json['generalPopulation'] as String?,
  elderly: json['elderly'] as String?,
  lungDiseasePopulation: json['lungDiseasePopulation'] as String?,
  heartDiseasePopulation: json['heartDiseasePopulation'] as String?,
  athletes: json['athletes'] as String?,
  pregnantWomen: json['pregnantWomen'] as String?,
  children: json['children'] as String?,
);

Map<String, dynamic> _$HealthRecommendationsModelToJson(
  HealthRecommendationsModel instance,
) => <String, dynamic>{
  'generalPopulation': instance.generalPopulation,
  'elderly': instance.elderly,
  'lungDiseasePopulation': instance.lungDiseasePopulation,
  'heartDiseasePopulation': instance.heartDiseasePopulation,
  'athletes': instance.athletes,
  'pregnantWomen': instance.pregnantWomen,
  'children': instance.children,
};
