import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ice_thickness_model.g.dart';

/// Expected ice build-up from freezing rain.
@JsonSerializable(explicitToJson: true)
class IceThicknessModel extends Equatable {
  const IceThicknessModel({this.thickness, this.unit});

  final double? thickness;

  /// `MILLIMETERS` or `INCHES`.
  final String? unit;

  factory IceThicknessModel.fromJson(Map<String, dynamic> json) =>
      _$IceThicknessModelFromJson(json);

  Map<String, dynamic> toJson() => _$IceThicknessModelToJson(this);

  @override
  List<Object?> get props => [thickness, unit];
}
