part of 'weather_section_bloc.dart';

enum SectionStatus {
  /// Nothing has been asked yet.
  initial,

  /// First load: nothing cached, so the skeleton is shown.
  loading,

  /// [WeatherSectionState.cachedData] is current.
  loaded,

  /// A reload is in flight over the cached data, which stays on screen.
  refreshing,

  /// The API answered with nothing to show.
  empty,

  /// The request failed. Cached data, if any, stays on screen.
  error,

  /// The request failed for want of a connection. Cached data, if any,
  /// stays on screen under the offline banner.
  offline,
}

class WeatherSectionState<T extends Object> extends Equatable {
  const WeatherSectionState({
    this.status = SectionStatus.initial,
    this.cachedData,
    this.query,
    this.error,
    this.updatedAt,
  });

  final SectionStatus status;

  /// The last good answer for [query]'s place. Survives loading, refreshing,
  /// error and offline, so the screen is never blanked by a reload.
  final T? cachedData;

  /// What the last fetch asked for. Null until the section is first loaded.
  final WeatherQuery? query;

  /// Set on [SectionStatus.error] and [SectionStatus.offline].
  final BaseError? error;

  /// When [cachedData] arrived — what decides whether a resumed app needs a
  /// reload.
  final DateTime? updatedAt;

  bool get hasData => cachedData != null;

  bool get isBusy =>
      status == SectionStatus.loading || status == SectionStatus.refreshing;

  bool get hasFailed =>
      status == SectionStatus.error || status == SectionStatus.offline;

  /// Whether the data is older than [maxAge], or there is none yet.
  bool isStale(Duration maxAge, {DateTime? now}) {
    final at = updatedAt;
    if (at == null) return true;
    return (now ?? DateTime.now()).difference(at) > maxAge;
  }

  @override
  List<Object?> get props => [status, cachedData, query, error, updatedAt];
}
