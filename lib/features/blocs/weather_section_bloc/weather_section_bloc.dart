import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:gunluk_goldaw_mobile/core/errors/api_error_handler.dart';
import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_section_event.dart';
part 'weather_section_state.dart';

/// One section of the weather screen and its last answer.
///
/// Every section — current conditions, hourly, daily, history, air quality,
/// pollen — loads the same way, so the way lives here once and each section
/// only says what to call and what counts as empty. Each is its own bloc, so
/// one section failing leaves the others exactly as they were.
abstract class WeatherSectionBloc<T extends Object>
    extends Bloc<WeatherSectionEvent, WeatherSectionState<T>> {
  WeatherSectionBloc() : super(WeatherSectionState<T>()) {
    // Restartable: a new city or a second pull supersedes the request in
    // flight rather than queueing behind it.
    on<WeatherSectionFetched>(_onFetched, transformer: restartable());
  }

  CancelToken? _inFlight;

  /// The repository call for this section.
  @protected
  Future<Either<BaseError, T>> load(
    WeatherQuery query,
    CancelToken cancelToken,
  );

  /// Whether [data] holds nothing worth a card.
  @protected
  bool isEmpty(T data);

  @override
  Future<void> close() {
    _inFlight?.cancel();
    return super.close();
  }

  Future<void> _onFetched(
    WeatherSectionFetched event,
    Emitter<WeatherSectionState<T>> emit,
  ) async {
    final query = event.query;
    final previous = state;
    final samePlace = previous.query?.sameLocation(query) ?? false;

    final alreadyAnswered =
        previous.query == query &&
        (previous.status == SectionStatus.loaded ||
            previous.status == SectionStatus.empty);
    if (alreadyAnswered && !event.refresh) return;

    // Another city's numbers must not be shown under this city's name, so
    // the cache only carries over when the place is the same.
    final cached = samePlace ? previous.cachedData : null;

    emit(
      WeatherSectionState<T>(
        status: cached == null
            ? SectionStatus.loading
            : SectionStatus.refreshing,
        cachedData: cached,
        query: query,
        updatedAt: cached == null ? null : previous.updatedAt,
      ),
    );

    _inFlight?.cancel();
    final cancelToken = CancelToken();
    _inFlight = cancelToken;

    final result = await load(query, cancelToken);

    if (cancelToken.isCancelled) return;

    result.fold(
      (error) => emit(
        WeatherSectionState<T>(
          status: error.type == ErrorType.network
              ? SectionStatus.offline
              : SectionStatus.error,
          cachedData: cached,
          query: query,
          error: error,
          updatedAt: cached == null ? null : previous.updatedAt,
        ),
      ),
      (data) => emit(
        WeatherSectionState<T>(
          status: isEmpty(data) ? SectionStatus.empty : SectionStatus.loaded,
          cachedData: isEmpty(data) ? null : data,
          query: query,
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }
}
