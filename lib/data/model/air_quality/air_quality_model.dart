import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/air_quality_index_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/health_recommendations_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/pollutant_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'air_quality_model.g.dart';

/// The answer of the Air Quality API's `currentConditions:lookup`.
@JsonSerializable(explicitToJson: true)
class AirQualityModel extends Equatable {
  const AirQualityModel({
    this.dateTime,
    this.regionCode,
    this.indexes,
    this.pollutants,
    this.healthRecommendations,
  });

  /// The hour these readings belong to, in UTC.
  @TimestampConverter()
  final DateTime? dateTime;

  /// ISO 3166-1 alpha-2, e.g. `tm`.
  final String? regionCode;
  final List<AirQualityIndexModel>? indexes;

  /// Only present when pollutant concentrations were asked for.
  final List<PollutantModel>? pollutants;
  final HealthRecommendationsModel? healthRecommendations;

  factory AirQualityModel.fromJson(Map<String, dynamic> json) =>
      _$AirQualityModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirQualityModelToJson(this);

  /// Whether there is anything to show. An area outside coverage can answer
  /// 200 with no indexes at all, and that is treated as "no section".
  bool get hasData => (indexes?.isNotEmpty ?? false);

  @override
  List<Object?> get props => [
    dateTime,
    regionCode,
    indexes,
    pollutants,
    healthRecommendations,
  ];
}
