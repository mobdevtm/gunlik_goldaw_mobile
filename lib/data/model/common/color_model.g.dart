// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorModel _$ColorModelFromJson(Map<String, dynamic> json) => ColorModel(
  red: (json['red'] as num?)?.toDouble(),
  green: (json['green'] as num?)?.toDouble(),
  blue: (json['blue'] as num?)?.toDouble(),
  alpha: (json['alpha'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ColorModelToJson(ColorModel instance) =>
    <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'alpha': instance.alpha,
    };
