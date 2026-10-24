// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pollen_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollenForecastModel _$PollenForecastModelFromJson(Map<String, dynamic> json) =>
    PollenForecastModel(
      regionCode: json['regionCode'] as String?,
      dailyInfo: (json['dailyInfo'] as List<dynamic>?)
          ?.map((e) => PollenDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageToken: json['nextPageToken'] as String?,
    );

Map<String, dynamic> _$PollenForecastModelToJson(
  PollenForecastModel instance,
) => <String, dynamic>{
  'regionCode': instance.regionCode,
  'dailyInfo': instance.dailyInfo?.map((e) => e.toJson()).toList(),
  'nextPageToken': instance.nextPageToken,
};
