import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/precipitation_mapper.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_condition_mapper.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/wind_direction_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_part_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/condition_icon.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/weather_detail_grid.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/weather_detail_tile.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/wind_direction_indicator.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The daytime or nighttime half of a forecast day.
class DayPartCard extends StatelessWidget {
  const DayPartCard({super.key, required this.part, required this.isDaytime});

  final ForecastDayPartModel part;
  final bool isDaytime;

  @override
  Widget build(BuildContext context) {
    const style = PhosphorIconsStyle.duotone;
    final visual = WeatherConditionMapper.map(
      part.weatherCondition?.type,
      isDaytime: isDaytime,
    );
    final precipitation = part.precipitation;
    final precipVisual = PrecipitationMapper.map(
      precipitation?.probability?.type,
    );
    final wind = part.wind;

    return WeatherSectionCard(
      title: (isDaytime ? 'daytime' : 'nighttime').tr(),
      icon: isDaytime ? PhosphorIcons.sun(style) : PhosphorIcons.moon(style),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ConditionIcon(visual: visual, size: Dimens.iconLarge),
              SizedBox(width: Dimens.spacingMedium),
              Expanded(
                child: Text(
                  visual.labelKey.tr(),
                  style: TextStyle(
                    fontSize: Dimens.fontNormal,
                    fontWeight: FontWeight.w700,
                    color: AppPalette.label(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimens.spacingMedium),
          WeatherDetailGrid(
            children: [
              WeatherDetailTile(
                icon: precipVisual.icon,
                label: 'precipitation_chance'.tr(),
                value: WeatherFormatters.percent(
                  precipitation?.probability?.percent,
                ),
                caption: precipVisual.labelKey.tr(),
              ),
              WeatherDetailTile(
                icon: PhosphorIcons.drop(style),
                label: 'precipitation_amount'.tr(),
                value: WeatherFormatters.amount(precipitation?.qpf),
              ),
              WeatherDetailTile(
                leading: WindDirectionIndicator(
                  degrees: wind?.direction?.degrees,
                ),
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
                value: WeatherFormatters.percent(part.relativeHumidity),
              ),
              WeatherDetailTile(
                icon: PhosphorIcons.cloud(style),
                label: 'cloud_cover'.tr(),
                value: WeatherFormatters.percent(part.cloudCover),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
