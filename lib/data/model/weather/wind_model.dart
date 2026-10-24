import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wind_model.g.dart';

/// Where the wind comes from, how fast it blows and how hard it gusts.
@JsonSerializable(explicitToJson: true)
class WindModel extends Equatable {
  const WindModel({this.direction, this.speed, this.gust});

  final WindDirectionModel? direction;
  final WindSpeedModel? speed;
  final WindSpeedModel? gust;

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindModelToJson(this);

  @override
  List<Object?> get props => [direction, speed, gust];
}

/// The direction the wind blows **from**.
@JsonSerializable(explicitToJson: true)
class WindDirectionModel extends Equatable {
  const WindDirectionModel({this.degrees, this.cardinal});

  /// 0 to 360, clockwise from north.
  final int? degrees;

  /// One of the 16 compass points, e.g. `NORTH_NORTHWEST`.
  final String? cardinal;

  factory WindDirectionModel.fromJson(Map<String, dynamic> json) =>
      _$WindDirectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindDirectionModelToJson(this);

  @override
  List<Object?> get props => [degrees, cardinal];
}

@JsonSerializable(explicitToJson: true)
class WindSpeedModel extends Equatable {
  const WindSpeedModel({this.value, this.unit});

  final double? value;

  /// `KILOMETERS_PER_HOUR` or `MILES_PER_HOUR`.
  final String? unit;

  factory WindSpeedModel.fromJson(Map<String, dynamic> json) =>
      _$WindSpeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindSpeedModelToJson(this);

  @override
  List<Object?> get props => [value, unit];
}
