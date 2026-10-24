import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/google_language.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/remote/pollen_remote_datasource.dart';
import 'package:gunluk_goldaw_mobile/data/repository/repository_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// The pollen forecast.
///
/// As with air quality, coverage here is uncertain, and an empty or refused
/// answer is the bloc's cue to hide the section.
class PollenRepository {
  const PollenRepository({required PollenRemoteDatasource remoteDatasource})
    : _remote = remoteDatasource;

  final PollenRemoteDatasource _remote;

  Future<Either<BaseError, PollenForecastModel>> getForecast({
    required double lat,
    required double lng,
    String? appLanguage,
    CancelToken? cancelToken,
  }) async {
    try {
      final forecast = await _remote.getForecast(
        lat: lat,
        lng: lng,
        languageCode: GoogleLanguage.fromAppLanguage(appLanguage),
        cancelToken: cancelToken,
      );
      return Right(forecast);
    } catch (e) {
      return Left(toBaseError(e));
    }
  }
}
