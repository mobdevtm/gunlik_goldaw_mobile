import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interval_model.g.dart';

/// A span of time: [startTime] inclusive, [endTime] exclusive, both UTC.
@JsonSerializable(explicitToJson: true)
class IntervalModel extends Equatable {
  const IntervalModel({this.startTime, this.endTime});

  @TimestampConverter()
  final DateTime? startTime;

  @TimestampConverter()
  final DateTime? endTime;

  factory IntervalModel.fromJson(Map<String, dynamic> json) =>
      _$IntervalModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntervalModelToJson(this);

  @override
  List<Object?> get props => [startTime, endTime];
}
