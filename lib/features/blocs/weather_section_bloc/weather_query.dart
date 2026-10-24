import 'package:equatable/equatable.dart';

/// Everything a weather section needs to ask for its data.
///
/// One value for all sections, built in one place, so the current
/// conditions and the forecast can never end up describing different
/// places. Units are always metric — the API's default — so they are not
/// part of it.
class WeatherQuery extends Equatable {
  const WeatherQuery({required this.lat, required this.lng, this.languageCode});

  final double lat;
  final double lng;

  /// The app's language. Only the Air Quality and Pollen sections pass it
  /// on, and only where Google supports it.
  final String? languageCode;

  /// Whether [other] asks about the same place.
  ///
  /// The cached answer is kept across a change of language — it is
  /// still the right place, only worded differently — but never across a
  /// change of place, where showing it would be showing the wrong city.
  bool sameLocation(WeatherQuery other) => lat == other.lat && lng == other.lng;

  @override
  List<Object?> get props => [lat, lng, languageCode];
}
