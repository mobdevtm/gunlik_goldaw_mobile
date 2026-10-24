import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_condition_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/current_conditions_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/condition_icon.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/app_card.dart';

/// The hero of the weather screen: the city, its clock, and the weather now.
class CurrentConditionsCard extends StatelessWidget {
  const CurrentConditionsCard({
    super.key,
    required this.data,
    required this.cityName,
    this.utcOffset,
  });

  final CurrentConditionsModel data;
  final String cityName;
  final Duration? utcOffset;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final visual = WeatherConditionMapper.map(
      data.weatherCondition?.type,
      isDaytime: data.isDaytime,
    );
    final history = data.currentConditionsHistory;
    final muted = AppPalette.secondaryLabel(context);
    final strong = AppPalette.label(context);

    return AppCard(
      padding: EdgeInsets.all(Dimens.cardPaddingLarge),
      child: Column(
        children: [
          Text(
            cityName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimens.fontLarge,
              fontWeight: FontWeight.w700,
              color: AppPalette.label(context),
            ),
          ),
          SizedBox(height: Dimens.spacingTiny),
          Text(
            '${'local_time'.tr()} · '
            '${WeatherFormatters.time(data.currentTime, utcOffset, locale)}',
            style: TextStyle(fontSize: Dimens.fontSmall, color: muted),
          ),
          SizedBox(height: Dimens.spacing),
          ConditionIcon(visual: visual, size: Dimens.r(72), withBackdrop: true),
          Text(
            WeatherFormatters.temperature(data.temperature),
            style: TextStyle(
              fontSize: Dimens.sp(56),
              fontWeight: FontWeight.w800,
              height: 1.1,
              color: strong,
            ),
          ),
          Text(
            visual.labelKey.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimens.fontMedium,
              fontWeight: FontWeight.w600,
              color: visual.tone.accent(context),
            ),
          ),
          SizedBox(height: Dimens.spacingMedium),
          Text(
            '${'feels_like'.tr()} '
            '${WeatherFormatters.temperature(data.feelsLikeTemperature)}',
            style: TextStyle(
              fontSize: Dimens.fontSmall,
              fontWeight: FontWeight.w600,
              color: muted,
            ),
          ),
          SizedBox(height: Dimens.spacingTiny),
          Text(
            '${'temp_high'.tr()} '
            '${WeatherFormatters.temperature(history?.maxTemperature)} · '
            '${'temp_low'.tr()} '
            '${WeatherFormatters.temperature(history?.minTemperature)}',
            style: TextStyle(fontSize: Dimens.fontSmall, color: muted),
          ),
        ],
      ),
    );
  }
}
