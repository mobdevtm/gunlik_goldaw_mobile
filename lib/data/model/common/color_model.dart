import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'color_model.g.dart';

/// An RGBA colour with channels from 0 to 1 (`google.type.Color`).
///
/// The Air Quality and Pollen APIs colour their indexes with it. Protobuf
/// leaves a zero channel out of the JSON, so a missing channel is 0 and a
/// missing alpha is fully opaque.
@JsonSerializable(explicitToJson: true)
class ColorModel extends Equatable {
  const ColorModel({this.red, this.green, this.blue, this.alpha});

  final double? red;
  final double? green;
  final double? blue;
  final double? alpha;

  factory ColorModel.fromJson(Map<String, dynamic> json) =>
      _$ColorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ColorModelToJson(this);

  Color toColor() => Color.from(
    alpha: (alpha ?? 1).clamp(0, 1),
    red: (red ?? 0).clamp(0, 1),
    green: (green ?? 0).clamp(0, 1),
    blue: (blue ?? 0).clamp(0, 1),
  );

  @override
  List<Object?> get props => [red, green, blue, alpha];
}
