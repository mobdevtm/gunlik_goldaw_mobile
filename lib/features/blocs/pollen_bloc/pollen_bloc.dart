import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/repository/pollen_repository.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef PollenState = WeatherSectionState<PollenForecastModel>;

/// The pollen forecast.
///
/// Like air quality, hidden quietly on [SectionStatus.empty] or on a failure
/// with nothing cached, since coverage here is uncertain.
class PollenBloc extends WeatherSectionBloc<PollenForecastModel> {
  PollenBloc({required PollenRepository repository}) : _repository = repository;

  final PollenRepository _repository;

  @override
  Future<Either<BaseError, PollenForecastModel>> load(
    WeatherQuery query,
    CancelToken cancelToken,
  ) => _repository.getForecast(
    lat: query.lat,
    lng: query.lng,
    appLanguage: query.languageCode,
    cancelToken: cancelToken,
  );

  @override
  bool isEmpty(PollenForecastModel data) => !data.hasData;
}
