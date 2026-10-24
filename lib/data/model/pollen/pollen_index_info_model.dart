import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/color_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pollen_index_info_model.g.dart';

/// A reading on the Universal Pollen Index (UPI).
@JsonSerializable(explicitToJson: true)
class PollenIndexInfoModel extends Equatable {
  const PollenIndexInfoModel({
    this.code,
    this.displayName,
    this.category,
    this.indexDescription,
    this.color,
    this.value,
  });

  /// `UPI`.
  final String? code;
  final String? displayName;

  /// Google's wording. Not shown — the app words it from [value].
  final String? category;
  final String? indexDescription;
  final ColorModel? color;

  /// 0 (none) to 5 (very high).
  final int? value;

  factory PollenIndexInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PollenIndexInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollenIndexInfoModelToJson(this);

  @override
  List<Object?> get props => [
    code,
    displayName,
    category,
    indexDescription,
    color,
    value,
  ];
}
