import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_index_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pollen_type_info_model.g.dart';

/// One pollen type — grass, tree or weed — on one day.
@JsonSerializable(explicitToJson: true)
class PollenTypeInfoModel extends Equatable {
  const PollenTypeInfoModel({
    this.code,
    this.displayName,
    this.indexInfo,
    this.healthRecommendations,
    this.inSeason,
  });

  /// `GRASS`, `TREE` or `WEED`.
  final String? code;
  final String? displayName;

  /// Absent when the type is out of season.
  final PollenIndexInfoModel? indexInfo;
  final List<String>? healthRecommendations;
  final bool? inSeason;

  factory PollenTypeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PollenTypeInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollenTypeInfoModelToJson(this);

  @override
  List<Object?> get props => [
    code,
    displayName,
    indexInfo,
    healthRecommendations,
    inSeason,
  ];
}
