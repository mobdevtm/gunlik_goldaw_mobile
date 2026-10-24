import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/current_conditions_model.dart';
import 'package:gunluk_goldaw_mobile/data/repository/weather_repository.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef CurrentWeatherState = WeatherSectionState<CurrentConditionsModel>;

/// The weather right now, with the last 24 hours' summary.
class CurrentWeatherBloc extends WeatherSectionBloc<CurrentConditionsModel> {
  CurrentWeatherBloc({required WeatherRepository repository})
    : _repository = repository;

  final WeatherRepository _repository;

  @override
  Future<Either<BaseError, CurrentConditionsModel>> load(
    WeatherQuery query,
    CancelToken cancelToken,
  ) => _repository.getCurrentConditions(
    lat: query.lat,
    lng: query.lng,
    cancelToken: cancelToken,
  );

  /// A body with neither a temperature nor a condition has nothing to draw.
  @override
  bool isEmpty(CurrentConditionsModel data) =>
      data.temperature?.degrees == null && data.weatherCondition?.type == null;
}
