import 'package:flutter/foundation.dart';
import 'package:gunluk_goldaw_mobile/core/constants/api_endpoints.dart';
import 'package:gunluk_goldaw_mobile/core/constants/constants.dart';
import 'package:gunluk_goldaw_mobile/core/location/device_location_service.dart';
import 'package:gunluk_goldaw_mobile/data/local/settings_manager.dart';
import 'package:gunluk_goldaw_mobile/data/model/location/device_location_model.dart';

/// Where the weather is shown for: the device's position or a picked city.
///
/// The device is followed from the start, once access is given. Picking a
/// city switches to it and stops locating; the "my location" row switches
/// back. The choice and the city are remembered across launches — Ashgabat
/// until one is picked — and the city also takes over the moment access is
/// taken away.
///
/// To keep from asking and locating over and over:
/// - The system prompt is shown on its own once, ever. After that only the
///   "my location" row of the city picker asks again.
/// - The last fix and its place name are kept, so a launch shows them at
///   once. A new fix is taken only when the kept one is older than
///   [_maxAge], and the place is named again only when the device moved
///   more than [_moveThresholdMeters] or the language changed.
class LocationProvider extends ChangeNotifier {
  LocationProvider({
    required SettingsManager settings,
    required DeviceLocationService device,
  }) : _settings = settings,
       _service = device,
       _city = _cityNamed(settings.getCityName()) ?? TmCities.ashgabat,
       _device = settings.getDeviceLocation(),
       _followDevice = settings.isFollowingDevice();

  static const _maxAge = Duration(minutes: 30);
  static const _moveThresholdMeters = 1000.0;

  final SettingsManager _settings;
  final DeviceLocationService _service;
  TmCity _city;
  DeviceLocationModel? _device;
  LocationAccess _access = LocationAccess.unknown;
  bool _isLocating = false;
  bool _followDevice;

  TmCity get city => _city;

  List<TmCity> get cities => TmCities.all;

  LocationAccess get access => _access;

  bool get isLocating => _isLocating;

  /// True while the weather follows the device. A kept fix counts from the
  /// first frame; it is dropped as soon as access turns out to be gone.
  bool get usesDevice => _followDevice && (_device?.hasPosition ?? false);

  double get lat => usesDevice ? _device!.lat! : _city.lat;
  double get lng => usesDevice ? _device!.lng! : _city.lng;

  /// The device's place name, or null when following a city or when the
  /// place could not be named.
  String? get placeLabel => usesDevice ? _device?.label : null;

  /// Shows [city] and stops following the device.
  void selectCity(TmCity city) {
    if (identical(city, _city) && !_followDevice) return;
    _city = city;
    _setFollowDevice(false);
    _settings.update(SettingsType.city, city.name);
    notifyListeners();
  }

  /// Checks access and, when allowed, refreshes the fix if it is due.
  ///
  /// Prompts only the first time ever; [ask] prompts regardless, for a tap
  /// on "my location". Does nothing while a city is picked instead.
  Future<void> refreshDeviceLocation({bool ask = false}) async {
    if (_isLocating || !_followDevice) return;
    _isLocating = true;
    notifyListeners();
    try {
      var access = await _service.access();
      if (access == LocationAccess.denied &&
          (ask || !_settings.isLocationPrompted())) {
        _settings.update(SettingsType.locationPrompted, true);
        access = await _service.requestAccess();
      }
      _access = access;
      if (access == LocationAccess.granted) {
        await _updateFix();
      } else {
        _forgetDevice();
      }
    } finally {
      _isLocating = false;
      notifyListeners();
    }
  }

  /// A tap on "my location": follows the device again — at once, from the
  /// kept fix, when there is one — then asks if needed, and when the answer
  /// can only be changed outside the app, opens the place where it can.
  Future<void> useDeviceLocation() async {
    _setFollowDevice(true);
    notifyListeners();
    await refreshDeviceLocation(ask: true);
    switch (_access) {
      case LocationAccess.deniedForever:
        await _service.openAppSettings();
      case LocationAccess.serviceDisabled:
        await _service.openLocationSettings();
      case LocationAccess.unknown ||
          LocationAccess.granted ||
          LocationAccess.denied:
        break;
    }
  }

  Future<void> _updateFix() async {
    var fix = _device;
    if (fix == null || !fix.hasPosition || fix.isOlderThan(_maxAge)) {
      final position = await _service.currentPosition();
      if (position != null) {
        final moved =
            fix == null ||
            !fix.hasPosition ||
            _service.distanceMeters(fix.lat!, fix.lng!, position) >
                _moveThresholdMeters;
        fix = moved
            ? DeviceLocationModel(
                lat: position.latitude,
                lng: position.longitude,
                fetchedAt: DateTime.now(),
              )
            : fix.copyWith(fetchedAt: DateTime.now());
      }
    }
    if (fix == null || !fix.hasPosition) return;

    final languageCode = _settings.getLang();
    if (fix.label == null || fix.languageCode != languageCode) {
      final label = await _service.placeLabel(fix.lat!, fix.lng!, languageCode);
      if (label != null) {
        fix = fix.copyWith(label: label, languageCode: languageCode);
      }
    }

    _device = fix;
    _settings.saveDeviceLocation(fix);
  }

  void _setFollowDevice(bool follow) {
    if (follow == _followDevice) return;
    _followDevice = follow;
    _settings.update(SettingsType.followDevice, follow);
  }

  void _forgetDevice() {
    if (_device == null) return;
    _device = null;
    _settings.saveDeviceLocation(null);
  }

  static TmCity? _cityNamed(String? name) {
    for (final city in TmCities.all) {
      if (city.name == name) return city;
    }
    return null;
  }
}
