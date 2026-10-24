import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'temperature_model.g.dart';

/// A temperature reading.
@JsonSerializable(explicitToJson: true)
class TemperatureModel extends Equatable {
  const TemperatureModel({this.degrees, this.unit});

  final double? degrees;

  /// `CELSIUS` or `FAHRENHEIT`, following the request's `unitsSystem`.
  final String? unit;

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);

  @override
  List<Object?> get props => [degrees, unit];
}
