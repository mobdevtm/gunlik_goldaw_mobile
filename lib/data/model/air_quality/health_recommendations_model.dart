import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'health_recommendations_model.g.dart';

/// Advice per group of people, as free text in the requested language.
@JsonSerializable(explicitToJson: true)
class HealthRecommendationsModel extends Equatable {
  const HealthRecommendationsModel({
    this.generalPopulation,
    this.elderly,
    this.lungDiseasePopulation,
    this.heartDiseasePopulation,
    this.athletes,
    this.pregnantWomen,
    this.children,
  });

  final String? generalPopulation;
  final String? elderly;
  final String? lungDiseasePopulation;
  final String? heartDiseasePopulation;
  final String? athletes;
  final String? pregnantWomen;
  final String? children;

  factory HealthRecommendationsModel.fromJson(Map<String, dynamic> json) =>
      _$HealthRecommendationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthRecommendationsModelToJson(this);

  @override
  List<Object?> get props => [
    generalPopulation,
    elderly,
    lungDiseasePopulation,
    heartDiseasePopulation,
    athletes,
    pregnantWomen,
    children,
  ];
}
