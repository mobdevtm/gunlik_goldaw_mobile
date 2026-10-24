import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/precipitation_mapper.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/wind_direction_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/current_conditions_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/weather_detail_grid.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/weather_detail_tile.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/wind_direction_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Every reading of the current conditions beyond the headline ones.
class CurrentDetailsGrid extends StatelessWidget {
  const CurrentDetailsGrid({super.key, required this.data});

  final CurrentConditionsModel data;

  @override
  Widget build(BuildContext context) {
    const style = PhosphorIconsStyle.duotone;
    final precipitation = data.precipitation;
    final precipVisual = PrecipitationMapper.map(
      precipitation?.probability?.type,
    );
    final wind = data.wind;
    final history = data.currentConditionsHistory;

    return WeatherDetailGrid(
      children: [
        WeatherDetailTile(
          leading: WindDirectionIndicator(degrees: wind?.direction?.degrees),
          label: 'wind'.tr(),
          value: WeatherFormatters.speed(wind?.speed),
          caption: WindDirectionMapper.labelKey(
            wind?.direction?.cardinal,
            degrees: wind?.direction?.degrees,
          ).tr(),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.wind(style),
          label: 'wind_gust'.tr(),
          value: WeatherFormatters.speed(wind?.gust),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.dropHalf(style),
          label: 'humidity'.tr(),
          value: WeatherFormatters.percent(data.relativeHumidity),
        ),
        WeatherDetailTile(
          icon: precipVisual.icon,
          label: 'precipitation_chance'.tr(),
          value: WeatherFormatters.percent(precipitation?.probability?.percent),
          caption: precipVisual.labelKey.tr(),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.drop(style),
          label: 'precipitation_amount'.tr(),
          value: WeatherFormatters.amount(precipitation?.qpf),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.gauge(style),
          label: 'pressure'.tr(),
          value: WeatherFormatters.pressure(data.airPressure),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.eye(style),
          label: 'visibility'.tr(),
          value: WeatherFormatters.distance(data.visibility),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.cloud(style),
          label: 'cloud_cover'.tr(),
          value: WeatherFormatters.percent(data.cloudCover),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.arrowUp(style),
          label: 'max_24h'.tr(),
          value: WeatherFormatters.temperature(history?.maxTemperature),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.arrowDown(style),
          label: 'min_24h'.tr(),
          value: WeatherFormatters.temperature(history?.minTemperature),
        ),
        WeatherDetailTile(
          icon: PhosphorIcons.thermometer(style),
          label: 'temp_change_24h'.tr(),
          value: WeatherFormatters.temperatureChange(
            history?.temperatureChange,
          ),
        ),
      ],
    );
  }
}
