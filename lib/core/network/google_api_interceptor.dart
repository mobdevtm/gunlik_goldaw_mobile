import 'dart:developer';

import 'package:gunluk_goldaw_mobile/core/constants/api_endpoints.dart';
import 'package:gunluk_goldaw_mobile/core/errors/missing_api_key_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Guards and logs every request to the Google Maps Platform hosts.
///
/// The key travels in the query string, so Dio's own [LogInterceptor] would
/// print it in full on every line. This one logs the same request with the
/// key masked instead.
class GoogleApiInterceptor extends Interceptor {
  static const _keyParam = 'key';

  /// The app's identity, as the native projects declare it. A key restricted
  /// to "Android apps" or "iOS apps" in the Cloud Console only accepts a REST
  /// call that names the app it is allowed for — the SDKs send this on their
  /// own, a plain HTTP client has to send it itself.
  static const _androidPackage = String.fromEnvironment(
    'GOOGLE_ANDROID_PACKAGE',
    defaultValue: 'com.sanlydere.gunluk_goldaw_mobile',
  );
  static const _iosBundleId = String.fromEnvironment(
    'GOOGLE_IOS_BUNDLE_ID',
    defaultValue: 'com.sanlydere.gunlukGoldawMobile',
  );

  /// SHA-1 of the signing certificate, hex without colons. Differs between
  /// the debug and the release keystore, so it comes from the env file.
  static const _androidCertSha1 = String.fromEnvironment(
    'GOOGLE_ANDROID_CERT_SHA1',
  );

  static Map<String, String> get _appIdentityHeaders =>
      switch (defaultTargetPlatform) {
        TargetPlatform.android => {
          'X-Android-Package': _androidPackage,
          if (_androidCertSha1.isNotEmpty) 'X-Android-Cert': _androidCertSha1,
        },
        TargetPlatform.iOS => {'X-Ios-Bundle-Identifier': _iosBundleId},
        _ => const {},
      };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Refused here rather than sent: Google would answer 403 for an empty
    // key, which reads as a permission problem instead of a build problem.
    if (ApiEndpoints.apiKey.isEmpty) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: const MissingApiKeyException(),
        ),
      );
      return;
    }

    options.headers.addAll(_appIdentityHeaders);

    if (kDebugMode) {
      log('${options.method} ${_redact(options.uri)}', name: 'GoogleApi');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      log(
        '${response.statusCode} ${_redact(response.requestOptions.uri)}',
        name: 'GoogleApi',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log(
        '${err.response?.statusCode ?? err.type.name} '
        '${_redact(err.requestOptions.uri)} ${err.response?.data ?? ''}',
        name: 'GoogleApi',
      );
    }
    handler.next(err);
  }

  static String _redact(Uri uri) {
    if (!uri.queryParameters.containsKey(_keyParam)) return uri.toString();
    return uri
        .replace(queryParameters: {...uri.queryParameters, _keyParam: '***'})
        .toString();
  }
}
