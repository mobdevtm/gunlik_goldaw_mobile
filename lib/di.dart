import 'package:gunluk_goldaw_mobile/core/constants/constants.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/core/location/device_location_service.dart';
import 'package:gunluk_goldaw_mobile/core/network/connectivity_service.dart';
import 'package:gunluk_goldaw_mobile/core/network/google_api_interceptor.dart';
import 'package:gunluk_goldaw_mobile/data/local/settings_manager.dart';
import 'package:gunluk_goldaw_mobile/data/remote/air_quality_remote_datasource.dart';
import 'package:gunluk_goldaw_mobile/data/remote/pollen_remote_datasource.dart';
import 'package:gunluk_goldaw_mobile/data/remote/weather_remote_datasource.dart';
import 'package:gunluk_goldaw_mobile/data/repository/air_quality_repository.dart';
import 'package:gunluk_goldaw_mobile/data/repository/pollen_repository.dart';
import 'package:gunluk_goldaw_mobile/data/repository/weather_repository.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/air_quality_bloc/air_quality_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/daily_forecast_bloc/daily_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/pollen_bloc/pollen_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_history_bloc/weather_history_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/providers/connectivity_provider.dart';
import 'package:gunluk_goldaw_mobile/features/providers/location_provider.dart';
import 'package:gunluk_goldaw_mobile/features/providers/weather_selection_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final settingsManagerBox = await Hive.openBox('settings');
  getIt.registerLazySingleton(() => SettingsManager(box: settingsManagerBox));

  // Every request goes to Google Maps Platform (Weather, Air Quality,
  // Pollen), with the key in the query string — see [GoogleApiInterceptor].
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(
          milliseconds: Constants.connectionTimeout,
        ),
        receiveTimeout: const Duration(milliseconds: Constants.receiveTimeout),
      ),
    )..interceptors.add(GoogleApiInterceptor()),
  );

  // ── Data sources ────────────────────────────────────────────────
  getIt.registerLazySingleton(() => WeatherRemoteDatasource(getIt<Dio>()));
  getIt.registerLazySingleton(() => AirQualityRemoteDatasource(getIt<Dio>()));
  getIt.registerLazySingleton(() => PollenRemoteDatasource(getIt<Dio>()));

  // ── Repositories ────────────────────────────────────────────────
  getIt.registerLazySingleton(
    () => WeatherRepository(remoteDatasource: getIt<WeatherRemoteDatasource>()),
  );
  getIt.registerLazySingleton(
    () => AirQualityRepository(
      remoteDatasource: getIt<AirQualityRemoteDatasource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => PollenRepository(remoteDatasource: getIt<PollenRemoteDatasource>()),
  );

  // ── Blocs ───────────────────────────────────────────────────────
  //
  // Singletons: each section's cache is the only copy of its data (nothing
  // is written to disk), and the main screen, the day detail screen and the
  // refresh coordinator all read the same one.
  getIt.registerLazySingleton(
    () => CurrentWeatherBloc(repository: getIt<WeatherRepository>()),
  );
  getIt.registerLazySingleton(
    () => HourlyForecastBloc(repository: getIt<WeatherRepository>()),
  );
  getIt.registerLazySingleton(
    () => DailyForecastBloc(repository: getIt<WeatherRepository>()),
  );
  getIt.registerLazySingleton(
    () => WeatherHistoryBloc(repository: getIt<WeatherRepository>()),
  );
  getIt.registerLazySingleton(
    () => AirQualityBloc(repository: getIt<AirQualityRepository>()),
  );
  getIt.registerLazySingleton(
    () => PollenBloc(repository: getIt<PollenRepository>()),
  );

  // ── Providers ───────────────────────────────────────────────────
  getIt.registerLazySingleton(ConnectivityService.new);
  getIt.registerLazySingleton(
    () => ConnectivityProvider(service: getIt<ConnectivityService>()),
  );
  getIt.registerLazySingleton(DeviceLocationService.new);
  getIt.registerLazySingleton(
    () => LocationProvider(
      settings: getIt<SettingsManager>(),
      device: getIt<DeviceLocationService>(),
    ),
  );
  getIt.registerLazySingleton(WeatherSelectionProvider.new);

  getIt.registerLazySingleton(
    () => WeatherRefreshCoordinator(
      location: getIt<LocationProvider>(),
      selection: getIt<WeatherSelectionProvider>(),
      settings: getIt<SettingsManager>(),
      connectivity: getIt<ConnectivityService>(),
      currentWeather: getIt<CurrentWeatherBloc>(),
      hourlyForecast: getIt<HourlyForecastBloc>(),
      dailyForecast: getIt<DailyForecastBloc>(),
      weatherHistory: getIt<WeatherHistoryBloc>(),
      airQuality: getIt<AirQualityBloc>(),
      pollen: getIt<PollenBloc>(),
    ),
  );
}
