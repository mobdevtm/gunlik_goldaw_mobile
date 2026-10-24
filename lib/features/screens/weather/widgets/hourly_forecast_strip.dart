import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_hour_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/hourly_forecast_item.dart';

/// One slot of the strip: an hour, or the mark of a new day before it.
typedef _Entry = ({WeatherHourModel? hour, DateTime? day});

/// The hours side by side, scrolling sideways.
///
/// A lazy list with a fixed height — worked out from the text scale by
/// [HourlyForecastItem.height] — so only the tiles on screen are built and
/// laid out. Where the hours cross midnight, a mark with the short weekday
/// and the date of the new day sits between 23:00 and 00:00.
class HourlyForecastStrip extends StatelessWidget {
  const HourlyForecastStrip({super.key, required this.hours});

  final List<WeatherHourModel> hours;

  @override
  Widget build(BuildContext context) {
    final entries = _entries(hours);
    final first = hours.isEmpty ? null : hours.first;

    return SizedBox(
      height: HourlyForecastItem.height(MediaQuery.textScalerOf(context)),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: Dimens.spacingSmall),
        itemBuilder: (context, index) {
          final entry = entries[index];
          final hour = entry.hour;
          return hour == null
              ? _DayMark(day: entry.day!)
              : HourlyForecastItem(hour: hour, isFirst: identical(hour, first));
        },
      ),
    );
  }

  /// The hours, with a day mark wherever the location's date changes.
  static List<_Entry> _entries(List<WeatherHourModel> hours) {
    final entries = <_Entry>[];
    DateTime? previous;
    for (final hour in hours) {
      final clock = hour.displayDateTime?.toWallClock();
      if (clock != null && previous != null && clock.day != previous.day) {
        entries.add((
          hour: null,
          day: DateTime(clock.year, clock.month, clock.day),
        ));
      }
      previous = clock ?? previous;
      entries.add((hour: hour, day: null));
    }
    return entries;
  }
}

/// The short weekday and the date of the day that starts next.
class _DayMark extends StatelessWidget {
  const _DayMark({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final tint = AppPalette.tint(context);

    return Container(
      width: HourlyForecastItem.width,
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimens.spacingTiny),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat.E(locale).format(day),
              style: TextStyle(
                fontSize: Dimens.fontSmall,
                fontWeight: FontWeight.w700,
                color: tint,
              ),
            ),
            Text(
              DateFormat.MMMd(locale).format(day),
              style: TextStyle(
                fontSize: Dimens.fontTiny,
                color: AppPalette.secondaryLabel(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
