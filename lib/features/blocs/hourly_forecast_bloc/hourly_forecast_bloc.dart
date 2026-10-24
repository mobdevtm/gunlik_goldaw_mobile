import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/hourly_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/repository/weather_repository.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef HourlyForecastState = WeatherSectionState<HourlyForecastModel>;

/// The next [WeatherRepository.forecastHours] hours, every page gathered.
class HourlyForecastBloc extends WeatherSectionBloc<HourlyForecastModel> {
  HourlyForecastBloc({required WeatherRepository repository})
    : _repository = repository;

  final WeatherRepository _repository;

  @override
  Future<Either<BaseError, HourlyForecastModel>> load(
    WeatherQuery query,
    CancelToken cancelToken,
  ) => _repository.getHourlyForecast(
    lat: query.lat,
    lng: query.lng,
    cancelToken: cancelToken,
  );

  @override
  bool isEmpty(HourlyForecastModel data) => data.forecastHours?.isEmpty ?? true;
}
