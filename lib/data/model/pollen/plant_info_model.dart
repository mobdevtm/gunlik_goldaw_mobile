import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_index_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plant_info_model.g.dart';

/// One plant species' pollen on one day.
@JsonSerializable(explicitToJson: true)
class PlantInfoModel extends Equatable {
  const PlantInfoModel({
    this.code,
    this.displayName,
    this.indexInfo,
    this.plantDescription,
    this.inSeason,
  });

  /// e.g. `BIRCH`, `OLIVE`, `GRAMINALES`, `RAGWEED`.
  final String? code;
  final String? displayName;
  final PollenIndexInfoModel? indexInfo;

  /// Only present when `plantsDescription=true` was asked for.
  final PlantDescriptionModel? plantDescription;
  final bool? inSeason;

  factory PlantInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PlantInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlantInfoModelToJson(this);

  @override
  List<Object?> get props => [
    code,
    displayName,
    indexInfo,
    plantDescription,
    inSeason,
  ];
}

@JsonSerializable(explicitToJson: true)
class PlantDescriptionModel extends Equatable {
  const PlantDescriptionModel({
    this.type,
    this.family,
    this.season,
    this.specialColors,
    this.specialShapes,
    this.crossReaction,
    this.picture,
    this.pictureCloseup,
  });

  /// `GRASS`, `TREE` or `WEED`.
  final String? type;
  final String? family;
  final String? season;
  final String? specialColors;
  final String? specialShapes;
  final String? crossReaction;
  final String? picture;
  final String? pictureCloseup;

  factory PlantDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PlantDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlantDescriptionModelToJson(this);

  @override
  List<Object?> get props => [
    type,
    family,
    season,
    specialColors,
    specialShapes,
    crossReaction,
    picture,
    pictureCloseup,
  ];
}
