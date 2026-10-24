class Constants {
  Constants._();
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 30000;
}

/// Keys of the settings box, by `name`.
enum SettingsType {
  lang,
  isDark,
  city,
  deviceLocation,
  locationPrompted,
  followDevice,
}
