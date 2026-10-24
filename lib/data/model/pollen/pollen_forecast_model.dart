import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_day_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pollen_forecast_model.g.dart';

/// One page of the Pollen API's `forecast:lookup` (up to 5 days).
@JsonSerializable(explicitToJson: true)
class PollenForecastModel extends Equatable {
  const PollenForecastModel({
    this.regionCode,
    this.dailyInfo,
    this.nextPageToken,
  });

  final String? regionCode;
  final List<PollenDayModel>? dailyInfo;
  final String? nextPageToken;

  factory PollenForecastModel.fromJson(Map<String, dynamic> json) =>
      _$PollenForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$PollenForecastModelToJson(this);

  /// Whether any day carries a pollen type with a reading. Outside coverage
  /// the API can answer with days that hold nothing, which reads as "no
  /// section" rather than as an empty card.
  bool get hasData =>
      dailyInfo?.any(
        (day) =>
            day.pollenTypeInfo?.any((type) => type.indexInfo != null) ?? false,
      ) ??
      false;

  @override
  List<Object?> get props => [regionCode, dailyInfo, nextPageToken];
}
