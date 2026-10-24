import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Whether the app may read the device position, as far as it matters here.
enum LocationAccess { unknown, granted, denied, deniedForever, serviceDisabled }

/// The device's position and the name of the place it is in.
///
/// A thin wrapper over geolocator and geocoding so [LocationProvider] holds
/// only the decisions. Nothing here throws: a failure is a null.
class DeviceLocationService {
  DeviceLocationService({Geocoding? geocoding})
    : _geocoding = geocoding ?? Geocoding();

  final Geocoding _geocoding;

  /// District-level accuracy is all a forecast needs, and it comes from the
  /// network in a second or two instead of waiting on a GPS lock.
  static const _settings = LocationSettings(
    accuracy: LocationAccuracy.low,
    timeLimit: Duration(seconds: 15),
  );

  /// The geocoder wants a region with the language. Turkmen is not offered
  /// by every platform; it then answers in its default.
  static const _locales = {
    'tk': Locale('tk', 'TM'),
    'ru': Locale('ru', 'RU'),
    'en': Locale('en', 'US'),
  };

  Future<LocationAccess> access() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationAccess.serviceDisabled;
    }
    return _accessOf(await Geolocator.checkPermission());
  }

  /// Shows the system prompt. Answers at once, without a prompt, when the
  /// user already said "never".
  Future<LocationAccess> requestAccess() async =>
      _accessOf(await Geolocator.requestPermission());

  Future<Position?> currentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(locationSettings: _settings);
    } catch (_) {
      return Geolocator.getLastKnownPosition();
    }
  }

  double distanceMeters(double lat, double lng, Position to) =>
      Geolocator.distanceBetween(lat, lng, to.latitude, to.longitude);

  /// Village, city, district and region, most specific first and without
  /// repeats — never the street or the house.
  Future<String?> placeLabel(
    double lat,
    double lng,
    String languageCode,
  ) async {
    try {
      final places = await _geocoding.placemarkFromCoordinates(
        lat,
        lng,
        locale: _locales[languageCode],
      );
      if (places.isEmpty) return null;
      final place = places.first;
      final parts = <String>[];
      for (final part in [
        place.subLocality,
        place.locality,
        place.subAdministrativeArea,
        place.administrativeArea,
      ]) {
        final value = part?.trim();
        if (value == null || value.isEmpty || parts.contains(value)) continue;
        parts.add(value);
      }
      return parts.isEmpty ? null : parts.join(', ');
    } catch (_) {
      return null;
    }
  }

  Future<void> openAppSettings() => Geolocator.openAppSettings();

  Future<void> openLocationSettings() => Geolocator.openLocationSettings();

  LocationAccess _accessOf(LocationPermission permission) =>
      switch (permission) {
        LocationPermission.always ||
        LocationPermission.whileInUse => LocationAccess.granted,
        LocationPermission.deniedForever => LocationAccess.deniedForever,
        LocationPermission.denied => LocationAccess.denied,
        LocationPermission.unableToDetermine => LocationAccess.unknown,
      };
}
