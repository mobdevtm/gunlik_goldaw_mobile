import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_zone_model.g.dart';

/// An IANA time zone, such as `Asia/Ashgabat`.
@JsonSerializable(explicitToJson: true)
class TimeZoneModel extends Equatable {
  const TimeZoneModel({this.id, this.version});

  final String? id;
  final String? version;

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) =>
      _$TimeZoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeZoneModelToJson(this);

  @override
  List<Object?> get props => [id, version];
}
