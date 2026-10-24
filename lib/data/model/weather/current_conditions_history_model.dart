import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/precipitation_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/temperature_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_conditions_history_model.g.dart';

/// How the last 24 hours went, sent alongside the current conditions.
@JsonSerializable(explicitToJson: true)
class CurrentConditionsHistoryModel extends Equatable {
  const CurrentConditionsHistoryModel({
    this.temperatureChange,
    this.maxTemperature,
    this.minTemperature,
    this.snowQpf,
    this.qpf,
  });

  /// Now compared with 24 hours ago.
  final TemperatureModel? temperatureChange;
  final TemperatureModel? maxTemperature;
  final TemperatureModel? minTemperature;
  final QpfModel? snowQpf;
  final QpfModel? qpf;

  factory CurrentConditionsHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionsHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentConditionsHistoryModelToJson(this);

  @override
  List<Object?> get props => [
    temperatureChange,
    maxTemperature,
    minTemperature,
    snowQpf,
    qpf,
  ];
}
