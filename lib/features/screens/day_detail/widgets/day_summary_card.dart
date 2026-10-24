import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_condition_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/condition_icon.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/app_card.dart';

/// The day at a glance: its date, its weather, and its range.
class DaySummaryCard extends StatelessWidget {
  const DaySummaryCard({super.key, required this.day});

  final ForecastDayModel day;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final visual = WeatherConditionMapper.map(
      day.daytimeForecast?.weatherCondition?.type,
    );
    final muted = AppPalette.secondaryLabel(context);

    return AppCard(
      padding: EdgeInsets.all(Dimens.cardPaddingLarge),
      child: Row(
        children: [
          ConditionIcon(visual: visual, size: Dimens.r(56), withBackdrop: true),
          SizedBox(width: Dimens.spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  WeatherFormatters.dayMonth(day.displayDate, locale),
                  style: TextStyle(fontSize: Dimens.fontSmall, color: muted),
                ),
                Text(
                  visual.labelKey.tr(),
                  style: TextStyle(
                    fontSize: Dimens.fontMedium,
                    fontWeight: FontWeight.w700,
                    color: visual.tone.accent(context),
                  ),
                ),
                SizedBox(height: Dimens.spacingTiny),
                Text(
                  '${'temp_high'.tr()} '
                  '${WeatherFormatters.temperature(day.maxTemperature)} · '
                  '${'temp_low'.tr()} '
                  '${WeatherFormatters.temperature(day.minTemperature)}',
                  style: TextStyle(
                    fontSize: Dimens.fontNormal,
                    fontWeight: FontWeight.w700,
                    color: AppPalette.label(context),
                  ),
                ),
                Text(
                  '${'feels_like'.tr()} '
                  '${WeatherFormatters.temperature(day.feelsLikeMaxTemperature)}'
                  ' / '
                  '${WeatherFormatters.temperature(day.feelsLikeMinTemperature)}',
                  style: TextStyle(fontSize: Dimens.fontSmall, color: muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
