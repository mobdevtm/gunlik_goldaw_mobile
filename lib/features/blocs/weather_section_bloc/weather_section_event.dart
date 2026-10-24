part of 'weather_section_bloc.dart';

sealed class WeatherSectionEvent extends Equatable {
  const WeatherSectionEvent();

  @override
  List<Object?> get props => [];
}

/// Loads the section for [query].
///
/// Served from the cache when the same query has already been answered,
/// unless [refresh] is true. A refresh keeps what is on screen and only
/// shows the indicator above it — the pull-to-refresh path.
final class WeatherSectionFetched extends WeatherSectionEvent {
  const WeatherSectionFetched({required this.query, this.refresh = false});

  final WeatherQuery query;
  final bool refresh;

  @override
  List<Object?> get props => [query, refresh];
}
