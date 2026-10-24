/// The `languageCode` to send Google for the app's language.
///
/// Google has no Turkmen. Sending `tk` risks a 400 on some services, so the
/// parameter is left out and Google falls back to English. Only the free-text
/// fields (health advice, plant names) are affected — conditions, categories
/// and levels are worded by the app itself from the enums.
class GoogleLanguage {
  GoogleLanguage._();

  static const _supported = {'en', 'ru'};

  static String? fromAppLanguage(String? appLanguage) =>
      _supported.contains(appLanguage) ? appLanguage : null;
}
