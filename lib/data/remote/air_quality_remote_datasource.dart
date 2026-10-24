import 'package:gunluk_goldaw_mobile/core/constants/api_endpoints.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/air_quality_model.dart';
import 'package:dio/dio.dart';

/// The Air Quality API. A POST with a JSON body, unlike the Weather API.
class AirQualityRemoteDatasource {
  const AirQualityRemoteDatasource(this._dio);

  final Dio _dio;

  /// What to compute beyond the bare index: advice per group, and each
  /// pollutant's concentration so the card can list them.
  static const _extraComputations = [
    'HEALTH_RECOMMENDATIONS',
    'DOMINANT_POLLUTANT_CONCENTRATION',
    'POLLUTANT_CONCENTRATION',
  ];

  Future<AirQualityModel> getCurrentConditions({
    required double lat,
    required double lng,
    String? languageCode,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.postUri<Map<String, dynamic>>(
      ApiEndpoints.airQualityCurrent(),
      data: {
        'location': {'latitude': lat, 'longitude': lng},
        'extraComputations': _extraComputations,
        'universalAqi': true,
        'languageCode': ?languageCode,
      },
      options: Options(headers: ApiEndpoints.jsonHeaders),
      cancelToken: cancelToken,
    );

    return AirQualityModel.fromJson(response.data ?? const {});
  }
}
