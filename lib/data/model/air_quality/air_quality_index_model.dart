import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/color_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'air_quality_index_model.g.dart';

/// One air quality index: the Universal AQI (`uaqi`) or a local one.
@JsonSerializable(explicitToJson: true)
class AirQualityIndexModel extends Equatable {
  const AirQualityIndexModel({
    this.code,
    this.displayName,
    this.aqi,
    this.aqiDisplay,
    this.color,
    this.category,
    this.dominantPollutant,
  });

  /// `uaqi` for the Universal AQI, otherwise the local index's code.
  final String? code;
  final String? displayName;

  /// 0 to 100 on the Universal AQI, where higher is cleaner air.
  final int? aqi;
  final String? aqiDisplay;
  final ColorModel? color;

  /// Google's own wording. Not shown — the app words it from [aqi].
  final String? category;

  /// The pollutant code driving the index, e.g. `pm10`.
  final String? dominantPollutant;

  factory AirQualityIndexModel.fromJson(Map<String, dynamic> json) =>
      _$AirQualityIndexModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirQualityIndexModelToJson(this);

  @override
  List<Object?> get props => [
    code,
    displayName,
    aqi,
    aqiDisplay,
    color,
    category,
    dominantPollutant,
  ];
}
