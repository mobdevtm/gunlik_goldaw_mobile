import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/date_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/plant_info_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_type_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pollen_day_model.g.dart';

/// One day of the pollen forecast.
@JsonSerializable(explicitToJson: true)
class PollenDayModel extends Equatable {
  const PollenDayModel({this.date, this.pollenTypeInfo, this.plantInfo});

  final DateModel? date;

  /// Up to three entries: grass, tree, weed.
  final List<PollenTypeInfoModel>? pollenTypeInfo;

  /// Up to fifteen species.
  final List<PlantInfoModel>? plantInfo;

  factory PollenDayModel.fromJson(Map<String, dynamic> json) =>
      _$PollenDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollenDayModelToJson(this);

  @override
  List<Object?> get props => [date, pollenTypeInfo, plantInfo];
}
