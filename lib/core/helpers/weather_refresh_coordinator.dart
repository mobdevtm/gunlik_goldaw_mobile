import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gunluk_goldaw_mobile/core/network/connectivity_service.dart';
import 'package:gunluk_goldaw_mobile/data/local/settings_manager.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/air_quality_bloc/air_quality_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/daily_forecast_bloc/daily_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/pollen_bloc/pollen_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_history_bloc/weather_history_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_query.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/providers/location_provider.dart';
import 'package:gunluk_goldaw_mobile/features/providers/weather_selection_provider.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

/// Decides when the weather sections reload, so no screen has to.
///
/// - A new place — another city, or the device moving — reloads every
///   section from scratch.
/// - Coming back to the app or switching language also lets the device
///   location refresh itself when it is due.
/// - A new language reloads the two sections whose text Google words.
/// - The connection coming back reloads whatever was already shown.
/// - Coming back to the app reloads whatever is older than [staleAfter].
///
/// Only sections that have been loaded once are ever reloaded here: a
/// section nobody has opened is left for its screen to ask for.
class WeatherRefreshCoordinator with WidgetsBindingObserver {
  WeatherRefreshCoordinator({
    required LocationProvider location,
    required WeatherSelectionProvider selection,
    required SettingsManager settings,
    required ConnectivityService connectivity,
    required CurrentWeatherBloc currentWeather,
    required HourlyForecastBloc hourlyForecast,
    required DailyForecastBloc dailyForecast,
    required WeatherHistoryBloc weatherHistory,
    required AirQualityBloc airQuality,
    required PollenBloc pollen,
  }) : _location = location,
       _selection = selection,
       _settings = settings,
       _connectivity = connectivity,
       _weatherBlocs = [
         currentWeather,
         hourlyForecast,
         dailyForecast,
         weatherHistory,
       ],
       _environmentBlocs = [airQuality, pollen];

  /// How old data may get before a resumed app reloads it.
  static const staleAfter = Duration(minutes: 15);

  /// How long a pull-to-refresh waits before letting go of its spinner.
  static const _refreshTimeout = Duration(seconds: 30);

  final LocationProvider _location;
  final WeatherSelectionProvider _selection;
  final SettingsManager _settings;
  final ConnectivityService _connectivity;

  /// Sections served by the Weather API.
  final List<WeatherSectionBloc<Object>> _weatherBlocs;

  /// Sections that depend on the language instead.
  final List<WeatherSectionBloc<Object>> _environmentBlocs;

  List<WeatherSectionBloc<Object>> get _allBlocs => [
    ..._weatherBlocs,
    ..._environmentBlocs,
  ];

  StreamSubscription<bool>? _connectivitySubscription;

  /// The coordinates last asked for, so a [LocationProvider] change that
  /// leaves them alone — a label, a spinner — reloads nothing.
  (double, double)? _place;
  ValueListenable<Box<dynamic>>? _languageListenable;
  bool _started = false;

  /// The query every section is asked with, built from the current choices.
  WeatherQuery get query => WeatherQuery(
    lat: _location.lat,
    lng: _location.lng,
    languageCode: _settings.getLang(),
  );

  void start() {
    if (_started) return;
    _started = true;

    WidgetsBinding.instance.addObserver(this);
    _place = (_location.lat, _location.lng);
    _location.addListener(_onPlaceChanged);

    _connectivity.start();
    _connectivitySubscription = _connectivity.onChange.listen(
      _onConnectivityChanged,
    );

    _languageListenable = _settings.box.listenable(keys: ['lang'])
      ..addListener(_onLanguageChanged);
  }

  void dispose() {
    if (!_started) return;
    _started = false;

    WidgetsBinding.instance.removeObserver(this);
    _location.removeListener(_onPlaceChanged);
    _connectivitySubscription?.cancel();
    _languageListenable?.removeListener(_onLanguageChanged);
  }

  /// Loads every section. Each serves its cache when it already holds an
  /// answer for the same query and [refresh] is false.
  void loadAll({bool refresh = false}) => _fetch(_allBlocs, refresh: refresh);

  /// Reloads one section in place — a section's own retry.
  void reload(WeatherSectionBloc<Object> bloc) => _fetch([bloc], refresh: true);

  /// Reloads every section in place and completes once all have settled —
  /// for `RefreshIndicator.onRefresh`.
  Future<void> refreshAll() async {
    final settled = _allBlocs.map(_settled).toList();
    _fetch(_allBlocs, refresh: true);
    await Future.wait(settled);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    _location.refreshDeviceLocation();

    final stale = _loaded(
      _allBlocs,
    ).where((bloc) => bloc.state.isStale(staleAfter)).toList();
    _fetch(stale, refresh: true);
  }

  void _onPlaceChanged() {
    final place = (_location.lat, _location.lng);
    if (place == _place) return;
    _place = place;

    // The old hour and day slots mean nothing for another place.
    _selection.reset();
    // Not a refresh: the cache belongs to the old city and is dropped by
    // each bloc, so the skeleton shows rather than the wrong numbers.
    _fetch(_loaded(_allBlocs));
  }

  void _onLanguageChanged() {
    _fetch(_loaded(_environmentBlocs), refresh: true);
    // The place name is in the old language until it is asked again.
    _location.refreshDeviceLocation();
  }

  void _onConnectivityChanged(bool online) {
    if (!online) return;
    _fetch(_loaded(_allBlocs), refresh: true);
  }

  void _fetch(
    Iterable<WeatherSectionBloc<Object>> blocs, {
    bool refresh = false,
  }) {
    final current = query;
    for (final bloc in blocs) {
      bloc.add(WeatherSectionFetched(query: current, refresh: refresh));
    }
  }

  /// Sections that have been asked for at least once.
  Iterable<WeatherSectionBloc<Object>> _loaded(
    Iterable<WeatherSectionBloc<Object>> blocs,
  ) => blocs.where((bloc) => bloc.state.query != null);

  /// Completes when [bloc] next comes to rest after a fetch. Subscribed
  /// before the fetch is sent, so the busy state it passes through is seen.
  ///
  /// Waits on a `bool` rather than on the state itself: the stream is really
  /// typed by the bloc's own data, e.g. `WeatherSectionState<CurrentConditionsModel>`,
  /// so a timeout fallback typed by `Object` fails the runtime type check.
  Future<void> _settled(WeatherSectionBloc<Object> bloc) => bloc.stream
      .any((state) => !state.isBusy)
      .timeout(_refreshTimeout, onTimeout: () => false);
}
