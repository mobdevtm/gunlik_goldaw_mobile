/// Raised before a Google request leaves the device without a key.
///
/// The key arrives through `--dart-define=GOOGLE_MAPS_API_KEY=...`. A build
/// made without it would otherwise send every call off to be refused with a
/// 403, and the screen would blame access rights instead of the build.
class MissingApiKeyException implements Exception {
  const MissingApiKeyException();

  @override
  String toString() => 'MissingApiKeyException: GOOGLE_MAPS_API_KEY is empty';
}
