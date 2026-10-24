import 'dart:convert';
import 'dart:developer';

import 'package:gunluk_goldaw_mobile/core/errors/missing_api_key_exception.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

class ApiErrorHandler {
  static bool isCancellation(dynamic error) {
    return error is DioException && error.type == DioExceptionType.cancel;
  }

  static String getMessage(dynamic error) {
    if (isCancellation(error)) return '';

    String errorDescription = "";

    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return ''; // Empty string = silent, no toast shown

          case DioExceptionType.connectionTimeout:
            errorDescription = 'connection_timed_out'.tr();
            break;

          case DioExceptionType.sendTimeout:
            errorDescription = 'send_time_out'.tr();
            break;

          case DioExceptionType.receiveTimeout:
            errorDescription = 'receive_time_out'.tr();
            break;

          case DioExceptionType.badCertificate:
            errorDescription = 'bad_certificate'.tr();
            break;

          case DioExceptionType.connectionError:
            errorDescription = 'no_internet_connection'.tr();
            break;

          case DioExceptionType.badResponse:
            errorDescription = _handleBadResponse(error);
            break;

          case DioExceptionType.unknown:
            errorDescription = _handleUnknown(error);
            break;
          case DioExceptionType.transformTimeout:
            throw UnimplementedError();
        }
      } else if (error is FormatException) {
        errorDescription = "format_error".tr(args: [error.toString()]);
      } else if (error.toString().contains('TTS failed [') ||
          error.toString().contains('429')) {
        final message = error.toString();

        // Status code extraction for "TTS failed [XXX]"
        int? statusCode;
        if (message.contains('TTS failed [')) {
          final start = message.indexOf('[') + 1;
          final end = message.indexOf(']');
          if (start > 0 && end > start) {
            statusCode = int.tryParse(message.substring(start, end));
          }
        }

        if (statusCode == 504) {
          errorDescription = "gateway_timeout".tr();
        } else if (statusCode == 500) {
          errorDescription = "internal_server_error".tr();
        } else if (statusCode == 429 || message.contains('429')) {
          return ''; // Silent, handled by global dialog
        } else if (message.contains('{')) {
          try {
            final jsonStr = message.substring(message.indexOf('{'));
            final data = json.decode(jsonStr);
            if (data is Map && data.containsKey('detail')) {
              errorDescription = data['detail'].toString();
            } else if (data is Map && data.containsKey('message')) {
              errorDescription = data['message'].toString();
            } else {
              errorDescription = "unavailable_to_process_data".tr();
            }
          } catch (_) {
            errorDescription = "unavailable_to_process_data".tr();
          }
        } else {
          errorDescription = "unavailable_to_process_data".tr();
        }
      } else {
        errorDescription = error.toString();
      }
    } catch (e, stack) {
      errorDescription = "unavailable_to_process_data".tr();
      if (kDebugMode) {
        log('ApiErrorHandler Crash: $e\n$stack');
      }
    }

    return _cleanErrorMessage(errorDescription);
  }

  static String _cleanErrorMessage(String message) {
    if (message.isEmpty) return "unavailable_to_process_data".tr();
    // Technical Dio messages or server debug output should not be shown to the user
    final technicalTerms = [
      'DioException',
      'status code',
      'RequestOptions',
      'validateStatus',
      'http://',
      'https://',
      'Instance of',
      'ResponseBody',
      // A model that disagrees with the payload throws a cast error. Showing
      // it verbatim tells the user nothing and looks broken.
      'is not a subtype of',
      'type \'',
      '_Map<',
      '_TypeError',
    ];

    bool isTechnical = technicalTerms.any((term) => message.contains(term));

    if (isTechnical && !message.contains('429')) {
      return "unavailable_to_process_data".tr();
    }

    return message;
  }

  static String _handleBadResponse(DioException error) {
    try {
      final statusCode = error.response?.statusCode ?? 0;
      final data = error.response?.data;

      final googleMessage = _googleErrorMessage(statusCode, data);
      if (googleMessage != null) return googleMessage;

      // Status code'a göre spesifik mesajlar
      switch (statusCode) {
        case 200:
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "success".tr();

        case 204:
          return "no_content".tr();

        case 400:
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "bad_request".tr();

        case 401:
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "unauthorized_access".tr();

        case 403:
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "permission_denied".tr();

        case 409:
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "request_conflict".tr();

        case 422:
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "unprocessable_entity".tr();

        case 429:
          // DRF throttling replies with {"detail": "Request was throttled.
          // Expected available in N seconds."} — show it, otherwise the user
          // taps the button and nothing appears to happen.
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "too_many_requests".tr();

        case 500:
          final msg = _extractErrorMessage(data);
          return (msg != null && !_isTechnicalMessage(msg))
              ? msg
              : "internal_server_error".tr();

        case 502:
          return "bad_gateway".tr();

        case 503:
          // Service Unavailable
          return "service_unavailable".tr();

        case 504:
          // Gateway Timeout
          return "gateway_timeout".tr();

        default:
          // Diğer durumlar için genel mesaj
          final message = _extractErrorMessage(data);
          if (message != null && !_isTechnicalMessage(message)) return message;

          return statusCode >= 500 ? "server_error".tr() : "client_error".tr();
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error in _handleBadResponse: $e');
      }
      return 'unavailable_to_process_data'.tr();
    }
  }

  /// Whether [data] is the body every `*.googleapis.com` service fails with:
  /// `{"error": {"code": 400, "message": "...", "status": "INVALID_ARGUMENT"}}`.
  static bool _isGoogleError(dynamic data) =>
      data is Map && data['error'] is Map;

  /// A translated message for a Google API failure, or null for any other
  /// body.
  ///
  /// The server's own `message` is English and written for developers
  /// ("Information is not supported for this location."), so it is never
  /// shown; the status code alone decides what the user reads.
  static String? _googleErrorMessage(int statusCode, dynamic data) {
    if (!_isGoogleError(data)) return null;

    return switch (statusCode) {
      // An unsupported location arrives as 400 or 404 depending on the
      // service, and to the user both mean the same thing.
      400 || 404 => 'error_bad_request_message'.tr(),
      401 || 403 => 'error_api_access_denied'.tr(),
      429 => 'error_quota_message'.tr(),
      >= 500 => 'server_error'.tr(),
      _ => 'client_error'.tr(),
    };
  }

  static bool _isTechnicalMessage(String message) {
    final technicalTerms = [
      'DioException',
      'status code',
      'RequestOptions',
      'validateStatus',
      '<html>',
      '<!DOCTYPE',
      'Instance of',
    ];
    return technicalTerms.any(
      (term) => message.toLowerCase().contains(term.toLowerCase()),
    );
  }

  static String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    try {
      if (data is List<int>) {
        try {
          final decoded = utf8.decode(data);
          if (decoded.startsWith('{')) {
            data = json.decode(decoded);
          } else {
            return decoded.isNotEmpty ? decoded : null;
          }
        } catch (_) {
          return null;
        }
      }
      if (data is String) {
        return data.isNotEmpty ? data : null;
      }

      if (data is Map<String, dynamic>) {
        if (data.containsKey('message') && data['message'] != null) {
          return data['message'].toString();
        }

        if (data.containsKey('error') && data['error'] != null) {
          return data['error'].toString();
        }

        if (data.containsKey('detail') && data['detail'] != null) {
          return data['detail'].toString();
        }

        // DRF serializer errors arrive keyed by field name, with the messages
        // in a list: {"password": ["This password is too common."]}. None of
        // the shapes above match, so pull the messages out here.
        final fieldMessage = _extractFieldErrors(data);
        if (fieldMessage != null) return fieldMessage;
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error parsing error message: $e');
        log('Data: $data');
      }
    }

    return null;
  }

  /// Envelope bookkeeping that is never a message for the user.
  ///
  /// `status` is the one that matters: this API sends `{"status": "error"}`
  /// alongside the real errors, and treating its value as text put the bare
  /// word "error" on screen instead of what actually went wrong.
  static const Set<String> _envelopeKeys = {'status', 'code', 'success'};

  /// Flattens DRF field errors into one readable message.
  ///
  /// `{"password": ["Too common.", "Too short."], "email": ["Required."]}`
  /// becomes "Too common.\nToo short.\nRequired." — every problem the user
  /// has to fix, not just the first one.
  ///
  /// Recurses into nested maps, because this backend wraps them: the real
  /// errors arrive as `{"status": "error", "data": {"number": [...]}}`, one
  /// level below where DRF alone would put them.
  static String? _extractFieldErrors(Map<dynamic, dynamic> data) {
    final messages = <String>[];
    _collectFieldErrors(data, messages);

    if (messages.isEmpty) return null;
    return messages.join('\n');
  }

  /// Machine tokens this API answers with instead of a sentence.
  ///
  /// `{"status":"error","data":"code_exists","code":"AYK1"}` would otherwise
  /// put the literal word `code_exists` in front of the seller. The offending
  /// value travels in a sibling key, so the message can name it.
  static const Map<String, String> _serverCodes = {
    'code_exists': 'error_code_exists',
  };

  /// Turns a known token into a sentence, or returns null if it is not one.
  static String? _translateServerCode(
    String token,
    Map<dynamic, dynamic> data,
  ) {
    final key = _serverCodes[token.trim()];
    if (key == null) return null;

    final offending = data['code']?.toString().trim();
    return offending == null || offending.isEmpty
        ? key.tr()
        : key.tr(args: [offending]);
  }

  static void _collectFieldErrors(
    Map<dynamic, dynamic> data,
    List<String> messages, {
    int depth = 0,
  }) {
    // Deep enough for `{status, data: {field: [...]}}` and a little more,
    // while a payload that nests further cannot spin this into a long walk.
    if (depth > 3) return;

    for (final entry in data.entries) {
      if (_envelopeKeys.contains(entry.key)) continue;

      final value = entry.value;
      if (value is List) {
        for (final item in value) {
          if (item is Map) {
            _collectFieldErrors(item, messages, depth: depth + 1);
            continue;
          }
          final text = item?.toString().trim();
          if (text != null && text.isNotEmpty) messages.add(text);
        }
      } else if (value is Map) {
        _collectFieldErrors(value, messages, depth: depth + 1);
      } else if (value is String && value.trim().isNotEmpty) {
        // A known token becomes a sentence; anything else is already one.
        messages.add(_translateServerCode(value, data) ?? value.trim());
      }
    }
  }

  static String _handleUnknown(DioException error) {
    if (error.error is MissingApiKeyException) {
      return 'error_api_key_missing'.tr();
    }
    if (kDebugMode) {
      log(
        'Unknown error => Path: ${error.requestOptions.path}, '
        'Status: ${error.response?.statusCode}, '
        'Data: ${error.response?.data}',
      );
    }
    return "unavailable_to_process_data".tr();
  }

  static ErrorType getErrorType(dynamic error) {
    if (error is! DioException) return ErrorType.unknown;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ErrorType.timeout;

      case DioExceptionType.connectionError:
        return ErrorType.network;

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final isGoogle = _isGoogleError(error.response?.data);
        // Google answers 401 for a malformed key, which is an access
        // problem with the build, not an expired user session.
        if (statusCode == 401) {
          return isGoogle ? ErrorType.forbidden : ErrorType.unauthorized;
        }
        if (statusCode == 403) return ErrorType.forbidden;
        if (statusCode == 429) return ErrorType.quotaExceeded;
        if (isGoogle && (statusCode == 400 || statusCode == 404)) {
          return ErrorType.badRequest;
        }
        if (statusCode >= 500) return ErrorType.server;
        if (statusCode >= 400) return ErrorType.client;
        return ErrorType.unknown;

      case DioExceptionType.unknown:
        if (error.error is MissingApiKeyException) return ErrorType.forbidden;
        return ErrorType.unknown;

      default:
        return ErrorType.unknown;
    }
  }
}

enum ErrorType {
  network,
  timeout,
  server,
  client,

  /// The request was understood and refused: an unsupported location or an
  /// invalid parameter (HTTP 400, or 404 from Google).
  badRequest,
  unauthorized,
  forbidden,

  /// The API key's quota is spent for now (HTTP 429).
  quotaExceeded,
  unknown,
}
