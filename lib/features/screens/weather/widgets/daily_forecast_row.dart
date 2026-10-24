import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_condition_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/condition_icon.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/temperature_range_bar.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// One day of the daily list: when, what, how wet, how warm.
class DailyForecastRow extends StatelessWidget {
  const DailyForecastRow({
    super.key,
    required this.day,
    required this.scaleMin,
    required this.scaleMax,
    required this.onTap,
    this.utcOffset,
  });

  final ForecastDayModel day;
  final double scaleMin;
  final double scaleMax;
  final VoidCallback onTap;
  final Duration? utcOffset;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final daytime = day.daytimeForecast;
    final visual = WeatherConditionMapper.map(daytime?.weatherCondition?.type);
    final muted = AppPalette.secondaryLabel(context);
    final strong = AppPalette.label(context);
    final min = day.minTemperature?.degrees;
    final max = day.maxTemperature?.degrees;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.spacingSmall),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    WeatherFormatters.dayLabel(
                      day.displayDate,
                      utcOffset,
                      locale,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Dimens.fontSmall,
                      fontWeight: FontWeight.w700,
                      color: strong,
                    ),
                  ),
                  Text(
                    WeatherFormatters.dayMonth(day.displayDate, locale),
                    style: TextStyle(fontSize: Dimens.fontTiny, color: muted),
                  ),
                ],
              ),
            ),
            ConditionIcon(visual: visual, size: Dimens.iconNormal),
            SizedBox(width: Dimens.spacingSmall),
            SizedBox(
              width: Dimens.r(44),
              child: Text(
                WeatherFormatters.percent(
                  daytime?.precipitation?.probability?.percent,
                ),
                style: TextStyle(
                  fontSize: Dimens.fontTiny,
                  fontWeight: FontWeight.w600,
                  color: AppPalette.tint(context),
                ),
              ),
            ),
            SizedBox(
              width: Dimens.r(36),
              child: Text(
                WeatherFormatters.temperature(day.minTemperature),
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: Dimens.fontSmall, color: muted),
              ),
            ),
            SizedBox(width: Dimens.spacingSmall),
            Expanded(
              flex: 3,
              child: min == null || max == null
                  ? const SizedBox.shrink()
                  : TemperatureRangeBar(
                      min: min,
                      max: max,
                      scaleMin: scaleMin,
                      scaleMax: scaleMax,
                    ),
            ),
            SizedBox(width: Dimens.spacingSmall),
            SizedBox(
              width: Dimens.r(36),
              child: Text(
                WeatherFormatters.temperature(day.maxTemperature),
                style: TextStyle(
                  fontSize: Dimens.fontSmall,
                  fontWeight: FontWeight.w700,
                  color: strong,
                ),
              ),
            ),
            PhosphorIcon(
              PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
              size: Dimens.iconSmall,
              color: muted,
            ),
          ],
        ),
      ),
    );
  }
}
