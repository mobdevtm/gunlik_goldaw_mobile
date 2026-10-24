import 'dart:io';

import 'package:hive_ce/hive.dart';

import '../../core/constants/constants.dart';
import '../model/location/device_location_model.dart';

class SettingsManager {
  SettingsManager({required this.box});

  final Box box;

  Future<void> init() async {
    final lang = box.get('lang');
    if (lang == null) {
      update(SettingsType.lang, Platform.localeName.split("_")[0]);
    }
  }

  String getLang() {
    final lang = box.get(
      'lang',
      defaultValue: Platform.localeName.split("_")[0],
    );

    return lang;
  }

  bool isDark() {
    return box.get('isDark', defaultValue: false) as bool;
  }

  /// The name of the last city picked, or null when none was.
  String? getCityName() => box.get(SettingsType.city.name) as String?;

  /// The last device fix, or null when location is not in use.
  DeviceLocationModel? getDeviceLocation() {
    final raw = box.get(SettingsType.deviceLocation.name);
    if (raw is! Map) return null;
    return DeviceLocationModel.fromJson(Map<String, dynamic>.from(raw));
  }

  void saveDeviceLocation(DeviceLocationModel? location) {
    if (location == null) {
      box.delete(SettingsType.deviceLocation.name);
    } else {
      update(SettingsType.deviceLocation, location.toJson());
    }
  }

  /// Whether the system location prompt has been shown on its own once.
  bool isLocationPrompted() =>
      box.get(SettingsType.locationPrompted.name, defaultValue: false) as bool;

  /// Whether the weather follows the device rather than the picked city.
  /// True until the user picks a city.
  bool isFollowingDevice() =>
      box.get(SettingsType.followDevice.name, defaultValue: true) as bool;

  void update(SettingsType type, dynamic value) {
    box.put(type.name, value);
  }
}
