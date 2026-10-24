import 'package:gunluk_goldaw_mobile/core/constants/api_endpoints.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_forecast_model.dart';
import 'package:dio/dio.dart';

/// The Pollen API.
///
/// Not paged: the forecast reaches at most 5 days and the API's default page
/// holds 5, so one call always returns the whole forecast.
class PollenRemoteDatasource {
  const PollenRemoteDatasource(this._dio);

  final Dio _dio;

  /// The furthest ahead the Pollen API forecasts.
  static const maxDays = 5;

  Future<PollenForecastModel> getForecast({
    required double lat,
    required double lng,
    int days = maxDays,
    String? languageCode,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.getUri<Map<String, dynamic>>(
      ApiEndpoints.pollenForecast(
        lat: lat,
        lng: lng,
        days: days,
        languageCode: languageCode,
      ),
      cancelToken: cancelToken,
    );

    return PollenForecastModel.fromJson(response.data ?? const {});
  }
}
