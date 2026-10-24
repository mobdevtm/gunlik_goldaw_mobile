import 'package:gunluk_goldaw_mobile/core/constants/api_endpoints.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/current_conditions_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/daily_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/hourly_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_history_model.dart';
import 'package:dio/dio.dart';

/// The Weather API calls, one method per page of one endpoint.
///
/// Paging is the repository's job: each method here fetches exactly the page
/// it is given a token for, so a caller can always see what went over the
/// wire.
///
/// `publicAlerts` and `forecast/minutes` have no coverage in Turkmenistan
/// and are not called. Both sit in [ApiEndpoints] already; adding one is a
/// method here returning its own model, beside these.
class WeatherRemoteDatasource {
  const WeatherRemoteDatasource(this._dio);

  final Dio _dio;

  /// The page sizes the API allows at most. Asking for the maximum keeps a
  /// 10-day or 48-hour lookup to as few round trips as possible.
  static const maxDaysPerPage = 10;
  static const maxHoursPerPage = 24;

  Future<CurrentConditionsModel> getCurrentConditions({
    required double lat,
    required double lng,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.getUri<Map<String, dynamic>>(
      ApiEndpoints.currentConditions(lat: lat, lng: lng),
      cancelToken: cancelToken,
    );

    return CurrentConditionsModel.fromJson(response.data ?? const {});
  }

  Future<DailyForecastModel> getDailyForecastPage({
    required double lat,
    required double lng,
    required int days,
    String? pageToken,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.getUri<Map<String, dynamic>>(
      ApiEndpoints.forecastDays(
        lat: lat,
        lng: lng,
        days: days,
        pageSize: maxDaysPerPage,
        pageToken: pageToken,
      ),
      cancelToken: cancelToken,
    );

    return DailyForecastModel.fromJson(response.data ?? const {});
  }

  Future<HourlyForecastModel> getHourlyForecastPage({
    required double lat,
    required double lng,
    required int hours,
    String? pageToken,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.getUri<Map<String, dynamic>>(
      ApiEndpoints.forecastHours(
        lat: lat,
        lng: lng,
        hours: hours,
        pageSize: maxHoursPerPage,
        pageToken: pageToken,
      ),
      cancelToken: cancelToken,
    );

    return HourlyForecastModel.fromJson(response.data ?? const {});
  }

  Future<WeatherHistoryModel> getHistoryPage({
    required double lat,
    required double lng,
    required int hours,
    String? pageToken,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.getUri<Map<String, dynamic>>(
      ApiEndpoints.historyHours(
        lat: lat,
        lng: lng,
        hours: hours,
        pageSize: maxHoursPerPage,
        pageToken: pageToken,
      ),
      cancelToken: cancelToken,
    );

    return WeatherHistoryModel.fromJson(response.data ?? const {});
  }
}
