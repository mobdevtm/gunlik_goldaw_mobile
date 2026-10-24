import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pollutant_model.g.dart';

/// One pollutant and how much of it is in the air.
@JsonSerializable(explicitToJson: true)
class PollutantModel extends Equatable {
  const PollutantModel({
    this.code,
    this.displayName,
    this.fullName,
    this.concentration,
    this.additionalInfo,
  });

  /// e.g. `pm25`, `pm10`, `o3`, `no2`, `so2`, `co`.
  final String? code;

  /// Chemical shorthand such as `PM2.5` — the same in every language.
  final String? displayName;
  final String? fullName;
  final PollutantConcentrationModel? concentration;
  final PollutantAdditionalInfoModel? additionalInfo;

  factory PollutantModel.fromJson(Map<String, dynamic> json) =>
      _$PollutantModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollutantModelToJson(this);

  @override
  List<Object?> get props => [
    code,
    displayName,
    fullName,
    concentration,
    additionalInfo,
  ];
}

@JsonSerializable(explicitToJson: true)
class PollutantConcentrationModel extends Equatable {
  const PollutantConcentrationModel({this.value, this.units});

  final double? value;

  /// `PARTS_PER_BILLION` or `MICROGRAMS_PER_CUBIC_METER`.
  final String? units;

  factory PollutantConcentrationModel.fromJson(Map<String, dynamic> json) =>
      _$PollutantConcentrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollutantConcentrationModelToJson(this);

  @override
  List<Object?> get props => [value, units];
}

@JsonSerializable(explicitToJson: true)
class PollutantAdditionalInfoModel extends Equatable {
  const PollutantAdditionalInfoModel({this.sources, this.effects});

  final String? sources;
  final String? effects;

  factory PollutantAdditionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PollutantAdditionalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollutantAdditionalInfoModelToJson(this);

  @override
  List<Object?> get props => [sources, effects];
}
