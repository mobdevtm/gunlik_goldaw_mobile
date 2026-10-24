import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_history_model.dart';
import 'package:gunluk_goldaw_mobile/data/repository/weather_repository.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef WeatherHistoryState = WeatherSectionState<WeatherHistoryModel>;

/// The past [WeatherRepository.historyHours] hours, for the chart.
class WeatherHistoryBloc extends WeatherSectionBloc<WeatherHistoryModel> {
  WeatherHistoryBloc({required WeatherRepository repository})
    : _repository = repository;

  final WeatherRepository _repository;

  @override
  Future<Either<BaseError, WeatherHistoryModel>> load(
    WeatherQuery query,
    CancelToken cancelToken,
  ) => _repository.getHistory(
    lat: query.lat,
    lng: query.lng,
    cancelToken: cancelToken,
  );

  @override
  bool isEmpty(WeatherHistoryModel data) => data.historyHours?.isEmpty ?? true;
}
