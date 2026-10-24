import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'air_pressure_model.g.dart';

/// Air pressure reduced to sea level. Always millibars, whatever the units
/// system.
@JsonSerializable(explicitToJson: true)
class AirPressureModel extends Equatable {
  const AirPressureModel({this.meanSeaLevelMillibars});

  final double? meanSeaLevelMillibars;

  factory AirPressureModel.fromJson(Map<String, dynamic> json) =>
      _$AirPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirPressureModelToJson(this);

  @override
  List<Object?> get props => [meanSeaLevelMillibars];
}
