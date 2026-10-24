import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_location_model.g.dart';

/// The last fix of the device, and the place name read off it.
///
/// Kept in the settings box so a relaunch shows the place at once instead of
/// waiting on GPS. It is the user's own position, not Google data, so the
/// rule against storing weather on disk does not apply to it.
@JsonSerializable(explicitToJson: true)
class DeviceLocationModel extends Equatable {
  const DeviceLocationModel({
    this.lat,
    this.lng,
    this.label,
    this.languageCode,
    this.fetchedAt,
  });

  final double? lat;
  final double? lng;

  /// Village, city, district and region, most specific first. Null when
  /// the geocoder could not name the place.
  final String? label;

  /// The language [label] is written in.
  final String? languageCode;

  /// When the position was last confirmed, moved or not.
  final DateTime? fetchedAt;

  factory DeviceLocationModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceLocationModelToJson(this);

  bool get hasPosition => lat != null && lng != null;

  /// True when there is no [fetchedAt] or it is older than [maxAge].
  bool isOlderThan(Duration maxAge) {
    final at = fetchedAt;
    return at == null || DateTime.now().difference(at) > maxAge;
  }

  DeviceLocationModel copyWith({
    String? label,
    String? languageCode,
    DateTime? fetchedAt,
  }) => DeviceLocationModel(
    lat: lat,
    lng: lng,
    label: label ?? this.label,
    languageCode: languageCode ?? this.languageCode,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );

  @override
  List<Object?> get props => [lat, lng, label, languageCode, fetchedAt];
}
