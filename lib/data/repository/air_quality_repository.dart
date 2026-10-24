import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/google_language.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/air_quality_model.dart';
import 'package:gunluk_goldaw_mobile/data/remote/air_quality_remote_datasource.dart';
import 'package:gunluk_goldaw_mobile/data/repository/repository_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// Current air quality.
///
/// Coverage in Turkmenistan is not guaranteed. A refusal or an answer with no
/// index is returned as it is; the bloc turns either into a hidden section,
/// never into a failed screen.
class AirQualityRepository {
  const AirQualityRepository({
    required AirQualityRemoteDatasource remoteDatasource,
  }) : _remote = remoteDatasource;

  final AirQualityRemoteDatasource _remote;

  /// [appLanguage] is the app's own language code; Google is only told it
  /// when it supports it — see [GoogleLanguage].
  Future<Either<BaseError, AirQualityModel>> getCurrentConditions({
    required double lat,
    required double lng,
    String? appLanguage,
    CancelToken? cancelToken,
  }) async {
    try {
      final airQuality = await _remote.getCurrentConditions(
        lat: lat,
        lng: lng,
        languageCode: GoogleLanguage.fromAppLanguage(appLanguage),
        cancelToken: cancelToken,
      );
      return Right(airQuality);
    } catch (e) {
      return Left(toBaseError(e));
    }
  }
}
