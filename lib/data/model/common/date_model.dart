import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_model.g.dart';

/// A calendar date with no time or zone (`google.type.Date`).
///
/// Used by the daily forecast's `displayDate` and the pollen forecast's
/// `date`. A part that is 0 means "not given".
@JsonSerializable(explicitToJson: true)
class DateModel extends Equatable {
  const DateModel({this.year, this.month, this.day});

  final int? year;
  final int? month;
  final int? day;

  factory DateModel.fromJson(Map<String, dynamic> json) =>
      _$DateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateModelToJson(this);

  /// The date as a local midnight, or null when any part is missing.
  DateTime? toDateTime() {
    final y = year, m = month, d = day;
    if (y == null || m == null || d == null) return null;
    if (y == 0 || m == 0 || d == 0) return null;
    return DateTime(y, m, d);
  }

  @override
  List<Object?> get props => [year, month, day];
}
