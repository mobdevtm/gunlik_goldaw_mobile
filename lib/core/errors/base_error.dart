import 'package:gunluk_goldaw_mobile/core/errors/api_error_handler.dart';

class BaseError {
  final String errorMessage;
  final int? statusCode;

  /// Whether the server actually refused the credentials.
  ///
  /// Set only when the token was rejected — HTTP 401, or this API's own 200
  /// body carrying `status: 'auth error'`. It is **not** set when the request
  /// never reached a verdict: a dropped connection, a timeout or a 500 says
  /// nothing about whether the token is still good.
  ///
  /// The distinction matters because signing the seller out is destructive —
  /// this backend has no refresh, so the only way back is a fresh OTP. A
  /// seller on a weak connection must not be logged out for being offline.
  final bool isUnauthorized;

  /// Whether the request failed before any answer came back.
  ///
  /// A connection error or a timeout. Worth keeping apart from a server-side
  /// failure, because this is the one the seller can fix by moving somewhere
  /// with signal.
  final bool isNetworkFailure;

  /// What kind of failure this was, so a screen can pick the matching
  /// picture and wording — and tell "offline" apart from "refused".
  final ErrorType type;

  const BaseError(
    this.errorMessage, {
    this.statusCode,
    this.isUnauthorized = false,
    this.isNetworkFailure = false,
    this.type = ErrorType.unknown,
  });

  String get message => errorMessage;

  @override
  String toString() => errorMessage;
}
