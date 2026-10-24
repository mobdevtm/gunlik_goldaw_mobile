import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'precipitation_model.g.dart';

/// The chance, kind and amount of precipitation.
@JsonSerializable(explicitToJson: true)
class PrecipitationModel extends Equatable {
  const PrecipitationModel({this.probability, this.snowQpf, this.qpf});

  final PrecipitationProbabilityModel? probability;

  /// Snowfall, as liquid water equivalent.
  final QpfModel? snowQpf;

  /// All precipitation, as liquid water equivalent.
  final QpfModel? qpf;

  factory PrecipitationModel.fromJson(Map<String, dynamic> json) =>
      _$PrecipitationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrecipitationModelToJson(this);

  @override
  List<Object?> get props => [probability, snowQpf, qpf];
}

@JsonSerializable(explicitToJson: true)
class PrecipitationProbabilityModel extends Equatable {
  const PrecipitationProbabilityModel({this.type, this.percent});

  /// `NONE`, `RAIN`, `LIGHT_RAIN`, `HEAVY_RAIN`, `SNOW`, `RAIN_AND_SNOW`,
  /// `SLEET` or `FREEZING_RAIN`.
  final String? type;

  /// 0 to 100.
  final int? percent;

  factory PrecipitationProbabilityModel.fromJson(Map<String, dynamic> json) =>
      _$PrecipitationProbabilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrecipitationProbabilityModelToJson(this);

  @override
  List<Object?> get props => [type, percent];
}

/// A quantitative precipitation forecast: an accumulated amount.
@JsonSerializable(explicitToJson: true)
class QpfModel extends Equatable {
  const QpfModel({this.quantity, this.unit});

  final double? quantity;

  /// `MILLIMETERS` or `INCHES`.
  final String? unit;

  factory QpfModel.fromJson(Map<String, dynamic> json) =>
      _$QpfModelFromJson(json);

  Map<String, dynamic> toJson() => _$QpfModelToJson(this);

  @override
  List<Object?> get props => [quantity, unit];
}
