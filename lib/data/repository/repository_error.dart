import 'package:gunluk_goldaw_mobile/core/errors/api_error_handler.dart';
import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:dio/dio.dart';

/// Maps a thrown error onto the [BaseError] the blocs surface, keeping the
/// status code so callers can tell a permission failure from a network one.
BaseError toBaseError(Object error) {
  final type = ApiErrorHandler.getErrorType(error);

  return BaseError(
    ApiErrorHandler.getMessage(error),
    statusCode: error is DioException ? error.response?.statusCode : null,
    // Only a real 401. A dropped connection or a timeout never reached a
    // verdict on the token, and must not be read as one — see [BaseError].
    isUnauthorized: type == ErrorType.unauthorized,
    isNetworkFailure: type == ErrorType.network || type == ErrorType.timeout,
    type: type,
  );
}
