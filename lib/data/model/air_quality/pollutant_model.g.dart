// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pollutant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollutantModel _$PollutantModelFromJson(Map<String, dynamic> json) =>
    PollutantModel(
      code: json['code'] as String?,
      displayName: json['displayName'] as String?,
      fullName: json['fullName'] as String?,
      concentration: json['concentration'] == null
          ? null
          : PollutantConcentrationModel.fromJson(
              json['concentration'] as Map<String, dynamic>,
            ),
      additionalInfo: json['additionalInfo'] == null
          ? null
          : PollutantAdditionalInfoModel.fromJson(
              json['additionalInfo'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PollutantModelToJson(PollutantModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'displayName': instance.displayName,
      'fullName': instance.fullName,
      'concentration': instance.concentration?.toJson(),
      'additionalInfo': instance.additionalInfo?.toJson(),
    };

PollutantConcentrationModel _$PollutantConcentrationModelFromJson(
  Map<String, dynamic> json,
) => PollutantConcentrationModel(
  value: (json['value'] as num?)?.toDouble(),
  units: json['units'] as String?,
);

Map<String, dynamic> _$PollutantConcentrationModelToJson(
  PollutantConcentrationModel instance,
) => <String, dynamic>{'value': instance.value, 'units': instance.units};

PollutantAdditionalInfoModel _$PollutantAdditionalInfoModelFromJson(
  Map<String, dynamic> json,
) => PollutantAdditionalInfoModel(
  sources: json['sources'] as String?,
  effects: json['effects'] as String?,
);

Map<String, dynamic> _$PollutantAdditionalInfoModelToJson(
  PollutantAdditionalInfoModel instance,
) => <String, dynamic>{
  'sources': instance.sources,
  'effects': instance.effects,
};
