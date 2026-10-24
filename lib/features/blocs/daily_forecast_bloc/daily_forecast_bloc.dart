import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/daily_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/repository/weather_repository.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef DailyForecastState = WeatherSectionState<DailyForecastModel>;

/// The next [WeatherRepository.forecastDays] days, every page gathered.
///
/// Also what the day detail screen reads, so opening a day costs no request.
class DailyForecastBloc extends WeatherSectionBloc<DailyForecastModel> {
  DailyForecastBloc({required WeatherRepository repository})
    : _repository = repository;

  final WeatherRepository _repository;

  @override
  Future<Either<BaseError, DailyForecastModel>> load(
    WeatherQuery query,
    CancelToken cancelToken,
  ) => _repository.getDailyForecast(
    lat: query.lat,
    lng: query.lng,
    cancelToken: cancelToken,
  );

  @override
  bool isEmpty(DailyForecastModel data) => data.forecastDays?.isEmpty ?? true;
}
