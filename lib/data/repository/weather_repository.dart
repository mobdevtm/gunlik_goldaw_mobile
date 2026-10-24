import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/current_conditions_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/daily_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/hourly_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_history_model.dart';
import 'package:gunluk_goldaw_mobile/data/remote/weather_remote_datasource.dart';
import 'package:gunluk_goldaw_mobile/data/repository/page_collector.dart';
import 'package:gunluk_goldaw_mobile/data/repository/repository_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// Current conditions, forecasts and recent history from the Weather API.
///
/// Nothing is kept here: Google's terms do not allow storing its weather for
/// long, so each bloc holds its own last answer in memory and that is all the
/// caching there is.
///
/// Every list endpoint is paged. The pages are gathered here and handed on as
/// one model holding every item, with `nextPageToken` cleared.
class WeatherRepository {
  const WeatherRepository({required WeatherRemoteDatasource remoteDatasource})
    : _remote = remoteDatasource;

  final WeatherRemoteDatasource _remote;

  /// The longest daily forecast the API offers.
  static const forecastDays = 10;

  /// One day ahead, which is one page: every load costs a single request
  /// against the daily "Forecast Hours" quota instead of two.
  static const forecastHours = 24;

  /// The furthest back the API reaches.
  static const historyHours = 24;

  Future<Either<BaseError, CurrentConditionsModel>> getCurrentConditions({
    required double lat,
    required double lng,
    CancelToken? cancelToken,
  }) async {
    try {
      final conditions = await _remote.getCurrentConditions(
        lat: lat,
        lng: lng,
        cancelToken: cancelToken,
      );
      return Right(conditions);
    } catch (e) {
      return Left(toBaseError(e));
    }
  }

  Future<Either<BaseError, DailyForecastModel>> getDailyForecast({
    required double lat,
    required double lng,
    int days = forecastDays,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await collectPages(
        fetchPage: (token) => _remote.getDailyForecastPage(
          lat: lat,
          lng: lng,
          days: days,
          pageToken: token,
          cancelToken: cancelToken,
        ),
        itemsOf: (page) => page.forecastDays,
        nextTokenOf: (page) => page.nextPageToken,
      );
      return Right(
        DailyForecastModel(
          forecastDays: result.items,
          timeZone: result.first.timeZone,
        ),
      );
    } catch (e) {
      return Left(toBaseError(e));
    }
  }

  Future<Either<BaseError, HourlyForecastModel>> getHourlyForecast({
    required double lat,
    required double lng,
    int hours = forecastHours,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await collectPages(
        fetchPage: (token) => _remote.getHourlyForecastPage(
          lat: lat,
          lng: lng,
          hours: hours,
          pageToken: token,
          cancelToken: cancelToken,
        ),
        itemsOf: (page) => page.forecastHours,
        nextTokenOf: (page) => page.nextPageToken,
      );
      return Right(
        HourlyForecastModel(
          forecastHours: result.items,
          timeZone: result.first.timeZone,
        ),
      );
    } catch (e) {
      return Left(toBaseError(e));
    }
  }

  Future<Either<BaseError, WeatherHistoryModel>> getHistory({
    required double lat,
    required double lng,
    int hours = historyHours,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await collectPages(
        fetchPage: (token) => _remote.getHistoryPage(
          lat: lat,
          lng: lng,
          hours: hours,
          pageToken: token,
          cancelToken: cancelToken,
        ),
        itemsOf: (page) => page.historyHours,
        nextTokenOf: (page) => page.nextPageToken,
      );
      return Right(
        WeatherHistoryModel(
          historyHours: result.items,
          timeZone: result.first.timeZone,
        ),
      );
    } catch (e) {
      return Left(toBaseError(e));
    }
  }
}
