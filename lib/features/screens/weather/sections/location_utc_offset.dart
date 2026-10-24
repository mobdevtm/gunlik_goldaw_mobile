import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';

/// The selected place's offset from UTC, read off the hourly forecast.
///
/// Only the hours carry it, so every clock on the screen — current time,
/// sunrise, "today" — waits on that section for its zone, and falls back to
/// the device's until it lands.
extension LocationUtcOffset on BuildContext {
  Duration? get locationUtcOffset => select<HourlyForecastBloc, Duration?>(
    (bloc) =>
        WeatherFormatters.utcOffsetOf(bloc.state.cachedData?.forecastHours),
  );
}
