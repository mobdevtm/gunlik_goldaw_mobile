import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visibility_model.g.dart';

/// How far one can see.
@JsonSerializable(explicitToJson: true)
class VisibilityModel extends Equatable {
  const VisibilityModel({this.distance, this.unit});

  final double? distance;

  /// `KILOMETERS` or `MILES`.
  final String? unit;

  factory VisibilityModel.fromJson(Map<String, dynamic> json) =>
      _$VisibilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisibilityModelToJson(this);

  @override
  List<Object?> get props => [distance, unit];
}
