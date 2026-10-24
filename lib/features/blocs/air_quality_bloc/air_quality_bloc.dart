import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/air_quality_model.dart';
import 'package:gunluk_goldaw_mobile/data/repository/air_quality_repository.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef AirQualityState = WeatherSectionState<AirQualityModel>;

/// Current air quality.
///
/// Coverage here is uncertain, so the screen hides this section quietly on
/// [SectionStatus.empty], or on a failure with nothing cached — it never
/// shows an error card for it.
class AirQualityBloc extends WeatherSectionBloc<AirQualityModel> {
  AirQualityBloc({required AirQualityRepository repository})
    : _repository = repository;

  final AirQualityRepository _repository;

  @override
  Future<Either<BaseError, AirQualityModel>> load(
    WeatherQuery query,
    CancelToken cancelToken,
  ) => _repository.getCurrentConditions(
    lat: query.lat,
    lng: query.lng,
    appLanguage: query.languageCode,
    cancelToken: cancelToken,
  );

  @override
  bool isEmpty(AirQualityModel data) => !data.hasData;
}
