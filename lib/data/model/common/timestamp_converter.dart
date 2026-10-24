import 'package:json_annotation/json_annotation.dart';

/// Reads an RFC 3339 timestamp (`2025-01-28T22:04:12.025273178Z`) without
/// throwing.
///
/// Google sends nanosecond precision and may leave a timestamp out entirely.
/// `DateTime.parse` would throw on anything malformed and take the whole
/// response down with it; a timestamp that cannot be read is null instead.
class TimestampConverter implements JsonConverter<DateTime?, String?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(String? json) =>
      json == null ? null : DateTime.tryParse(json);

  @override
  String? toJson(DateTime? object) => object?.toUtc().toIso8601String();
}
