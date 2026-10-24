// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'precipitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrecipitationModel _$PrecipitationModelFromJson(Map<String, dynamic> json) =>
    PrecipitationModel(
      probability: json['probability'] == null
          ? null
          : PrecipitationProbabilityModel.fromJson(
              json['probability'] as Map<String, dynamic>,
            ),
      snowQpf: json['snowQpf'] == null
          ? null
          : QpfModel.fromJson(json['snowQpf'] as Map<String, dynamic>),
      qpf: json['qpf'] == null
          ? null
          : QpfModel.fromJson(json['qpf'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrecipitationModelToJson(PrecipitationModel instance) =>
    <String, dynamic>{
      'probability': instance.probability?.toJson(),
      'snowQpf': instance.snowQpf?.toJson(),
      'qpf': instance.qpf?.toJson(),
    };

PrecipitationProbabilityModel _$PrecipitationProbabilityModelFromJson(
  Map<String, dynamic> json,
) => PrecipitationProbabilityModel(
  type: json['type'] as String?,
  percent: (json['percent'] as num?)?.toInt(),
);

Map<String, dynamic> _$PrecipitationProbabilityModelToJson(
  PrecipitationProbabilityModel instance,
) => <String, dynamic>{'type': instance.type, 'percent': instance.percent};

QpfModel _$QpfModelFromJson(Map<String, dynamic> json) => QpfModel(
  quantity: (json['quantity'] as num?)?.toDouble(),
  unit: json['unit'] as String?,
);

Map<String, dynamic> _$QpfModelToJson(QpfModel instance) => <String, dynamic>{
  'quantity': instance.quantity,
  'unit': instance.unit,
};
