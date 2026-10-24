// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantInfoModel _$PlantInfoModelFromJson(Map<String, dynamic> json) =>
    PlantInfoModel(
      code: json['code'] as String?,
      displayName: json['displayName'] as String?,
      indexInfo: json['indexInfo'] == null
          ? null
          : PollenIndexInfoModel.fromJson(
              json['indexInfo'] as Map<String, dynamic>,
            ),
      plantDescription: json['plantDescription'] == null
          ? null
          : PlantDescriptionModel.fromJson(
              json['plantDescription'] as Map<String, dynamic>,
            ),
      inSeason: json['inSeason'] as bool?,
    );

Map<String, dynamic> _$PlantInfoModelToJson(PlantInfoModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'displayName': instance.displayName,
      'indexInfo': instance.indexInfo?.toJson(),
      'plantDescription': instance.plantDescription?.toJson(),
      'inSeason': instance.inSeason,
    };

PlantDescriptionModel _$PlantDescriptionModelFromJson(
  Map<String, dynamic> json,
) => PlantDescriptionModel(
  type: json['type'] as String?,
  family: json['family'] as String?,
  season: json['season'] as String?,
  specialColors: json['specialColors'] as String?,
  specialShapes: json['specialShapes'] as String?,
  crossReaction: json['crossReaction'] as String?,
  picture: json['picture'] as String?,
  pictureCloseup: json['pictureCloseup'] as String?,
);

Map<String, dynamic> _$PlantDescriptionModelToJson(
  PlantDescriptionModel instance,
) => <String, dynamic>{
  'type': instance.type,
  'family': instance.family,
  'season': instance.season,
  'specialColors': instance.specialColors,
  'specialShapes': instance.specialShapes,
  'crossReaction': instance.crossReaction,
  'picture': instance.picture,
  'pictureCloseup': instance.pictureCloseup,
};
