import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_condition_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_hour_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/condition_icon.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/wind_direction_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// One hour in the hourly strip: time, condition, temperature, chance of
/// rain and wind. Read-only — nothing to tap.
class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem({
    super.key,
    required this.hour,
    required this.isFirst,
  });

  final WeatherHourModel hour;

  /// The first hour is labelled "now" instead of with its time.
  final bool isFirst;

  static double get width => Dimens.r(56);
  static double get _iconSize => Dimens.r(28);
  static double get _windSize => Dimens.r(18);

  /// The height the content needs at [scaler], so the strip can be a lazy
  /// list with a fixed extent. Each text line is counted generously, so a
  /// font with tall line metrics still fits; the column centres whatever
  /// is left over.
  static double height(TextScaler scaler) {
    double line(double fontSize) => scaler.scale(fontSize) * 1.4;
    return Dimens.spacingSmall * 2 +
        line(Dimens.fontTiny) +
        _iconSize +
        line(Dimens.fontNormal) +
        line(Dimens.fontTiny) +
        _windSize +
        line(Dimens.fontTiny) +
        Dimens.spacingTiny * 4 +
        Dimens.r(2);
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final visual = WeatherConditionMapper.map(
      hour.weatherCondition?.type,
      isDaytime: hour.isDaytime,
    );
    final muted = AppPalette.secondaryLabel(context);
    final tint = AppPalette.tint(context);

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isFirst ? 'now'.tr() : WeatherFormatters.hour(hour, locale),
            maxLines: 1,
            style: TextStyle(
              fontSize: Dimens.fontTiny,
              fontWeight: isFirst ? FontWeight.w700 : FontWeight.w500,
              color: isFirst ? tint : muted,
            ),
          ),
          SizedBox(height: Dimens.spacingTiny),
          ConditionIcon(visual: visual, size: _iconSize),
          SizedBox(height: Dimens.spacingTiny),
          Text(
            WeatherFormatters.temperature(hour.temperature),
            maxLines: 1,
            style: TextStyle(
              fontSize: Dimens.fontNormal,
              fontWeight: FontWeight.w700,
              color: AppPalette.label(context),
            ),
          ),
          SizedBox(height: Dimens.spacingTiny),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PhosphorIcon(
                PhosphorIcons.drop(PhosphorIconsStyle.fill),
                size: Dimens.r(10),
                color: tint,
              ),
              SizedBox(width: Dimens.r(2)),
              Text(
                WeatherFormatters.percent(
                  hour.precipitation?.probability?.percent,
                ),
                maxLines: 1,
                style: TextStyle(fontSize: Dimens.fontTiny, color: muted),
              ),
            ],
          ),
          SizedBox(height: Dimens.spacingTiny),
          WindDirectionIndicator(
            degrees: hour.wind?.direction?.degrees,
            size: _windSize,
          ),
          SizedBox(height: Dimens.r(2)),
          Text(
            '${hour.wind?.speed?.value?.round() ?? WeatherFormatters.placeholder}',
            maxLines: 1,
            style: TextStyle(fontSize: Dimens.fontTiny, color: muted),
          ),
        ],
      ),
    );
  }
}
