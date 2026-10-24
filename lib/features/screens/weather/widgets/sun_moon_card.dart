import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/moon_phase_mapper.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/sun_events_mapper.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_tone.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/sky_path_chart.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/weather_detail_tile.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The sun's path with sunrise and sunset, and the length of daylight, for
/// one forecast day.
class SunCard extends StatelessWidget {
  const SunCard({super.key, required this.day, this.utcOffset});

  final ForecastDayModel day;
  final Duration? utcOffset;

  @override
  Widget build(BuildContext context) {
    final sun = day.sunEvents;
    final color = WeatherTone.clearDay.accent(context);

    return WeatherSectionCard(
      title: 'sun'.tr(),
      icon: SunEventsMapper.icon(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SkyPathChart(
            rise: sun?.sunriseTime,
            set: sun?.sunsetTime,
            date: day.displayDate,
            color: color,
            riseIcon: _EventIcon(
              icon: SunEventsMapper.icon(),
              kind: SunEventKind.sunrise,
              color: color,
            ),
            setIcon: _EventIcon(
              icon: SunEventsMapper.icon(),
              kind: SunEventKind.sunset,
              color: color,
            ),
            riseLabel: SunEventsMapper.labelKey(SunEventKind.sunrise).tr(),
            setLabel: SunEventsMapper.labelKey(SunEventKind.sunset).tr(),
            utcOffset: utcOffset,
          ),
          SizedBox(height: Dimens.spacing),
          WeatherDetailTile(
            icon: PhosphorIcons.sun(PhosphorIconsStyle.duotone),
            label: 'daylight'.tr(),
            value: WeatherFormatters.duration(SunEventsMapper.daylight(sun)),
            accent: color,
          ),
        ],
      ),
    );
  }
}

/// The moon's path with moonrise and moonset, and its phase, for one
/// forecast day.
class MoonCard extends StatelessWidget {
  const MoonCard({super.key, required this.day, this.utcOffset});

  final ForecastDayModel day;
  final Duration? utcOffset;

  @override
  Widget build(BuildContext context) {
    final moon = day.moonEvents;
    final visual = MoonPhaseMapper.map(moon?.moonPhase);
    final color = WeatherTone.clearNight.accent(context);

    return WeatherSectionCard(
      title: 'moon'.tr(),
      icon: PhosphorIcons.moon(PhosphorIconsStyle.duotone),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SkyPathChart(
            rise: moon?.firstMoonrise,
            set: moon?.firstMoonset,
            date: day.displayDate,
            color: color,
            riseIcon: _EventIcon(
              icon: PhosphorIcons.moonStars(PhosphorIconsStyle.duotone),
              kind: SunEventKind.sunrise,
              color: color,
            ),
            setIcon: _EventIcon(
              icon: PhosphorIcons.moon(PhosphorIconsStyle.duotone),
              kind: SunEventKind.sunset,
              color: color,
            ),
            riseLabel: 'moonrise'.tr(),
            setLabel: 'moonset'.tr(),
            utcOffset: utcOffset,
          ),
          SizedBox(height: Dimens.spacing),
          WeatherDetailTile(
            leading: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(visual.mirrored ? math.pi : 0),
              child: PhosphorIcon(
                visual.icon,
                size: Dimens.iconSmall,
                color: color,
              ),
            ),
            label: 'moon_phase'.tr(),
            value: visual.labelKey.tr(),
            accent: color,
          ),
        ],
      ),
    );
  }
}

/// An icon with the up or down arrow beside it that tells a rise from a set.
class _EventIcon extends StatelessWidget {
  const _EventIcon({
    required this.icon,
    required this.kind,
    required this.color,
  });

  final IconData icon;
  final SunEventKind kind;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PhosphorIcon(icon, size: Dimens.iconSmall, color: color),
        PhosphorIcon(
          SunEventsMapper.arrow(kind),
          size: Dimens.r(10),
          color: color,
        ),
      ],
    );
  }
}
