// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pollen_type_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollenTypeInfoModel _$PollenTypeInfoModelFromJson(Map<String, dynamic> json) =>
    PollenTypeInfoModel(
      code: json['code'] as String?,
      displayName: json['displayName'] as String?,
      indexInfo: json['indexInfo'] == null
          ? null
          : PollenIndexInfoModel.fromJson(
              json['indexInfo'] as Map<String, dynamic>,
            ),
      healthRecommendations: (json['healthRecommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      inSeason: json['inSeason'] as bool?,
    );

Map<String, dynamic> _$PollenTypeInfoModelToJson(
  PollenTypeInfoModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'displayName': instance.displayName,
  'indexInfo': instance.indexInfo?.toJson(),
  'healthRecommendations': instance.healthRecommendations,
  'inSeason': instance.inSeason,
};
