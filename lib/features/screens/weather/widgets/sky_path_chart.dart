import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/data/model/common/date_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/sky_path_painter.dart';

/// The arc of the sun or the moon for one day, with its rise and set under
/// the two ends.
///
/// The body itself is drawn where it is now only when [date] is today at the
/// location. A day can lack one event — the moon skips a rise or a set about
/// once a month — and the arc then runs off that edge of the day; with
/// neither, nothing is drawn.
class SkyPathChart extends StatelessWidget {
  const SkyPathChart({
    super.key,
    required this.rise,
    required this.set,
    required this.date,
    required this.color,
    required this.riseIcon,
    required this.setIcon,
    required this.riseLabel,
    required this.setLabel,
    this.utcOffset,
  });

  final DateTime? rise;
  final DateTime? set;
  final DateModel? date;
  final Color color;
  final Widget riseIcon;
  final Widget setIcon;
  final String riseLabel;
  final String setLabel;
  final Duration? utcOffset;

  /// How long the moon stays up on average, as a fraction of a day — used
  /// to place the event a day lacks, which falls on the day before or after.
  static const _averageUpTime = 12.4 / 24;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final riseClock = WeatherFormatters.wallClock(rise, utcOffset);
    final setClock = WeatherFormatters.wallClock(set, utcOffset);
    if (riseClock == null && setClock == null) return const SizedBox.shrink();

    final riseAt = riseClock == null
        ? _dayFraction(setClock!) - _averageUpTime
        : _dayFraction(riseClock);
    final setAt = setClock == null
        ? riseAt + _averageUpTime
        : _dayFraction(setClock);

    final now = WeatherFormatters.wallClock(DateTime.now(), utcOffset)!;
    final isToday =
        now.year == date?.year &&
        now.month == date?.month &&
        now.day == date?.day;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: Dimens.r(130),
          child: CustomPaint(
            size: Size.infinite,
            painter: SkyPathPainter(
              rise: riseAt,
              set: setAt,
              now: isToday ? _dayFraction(now) : null,
              color: color,
              belowColor: AppPalette.secondaryLabel(
                context,
              ).withValues(alpha: 0.35),
              horizonColor: AppPalette.separator(context),
              strokeWidth: Dimens.r(2.5),
              dotRadius: Dimens.r(5),
              // Below the smallest text size: nine clock times share one
              // phone width.
              labelStyle: TextStyle(
                fontSize: Dimens.sp(9),
                letterSpacing: -0.2,
                color: AppPalette.secondaryLabel(context),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimens.spacingSmall),
        Row(
          children: [
            Expanded(
              child: _EventTime(
                icon: riseIcon,
                label: riseLabel,
                time: WeatherFormatters.time(rise, utcOffset, locale),
              ),
            ),
            Expanded(
              child: _EventTime(
                icon: setIcon,
                label: setLabel,
                time: WeatherFormatters.time(set, utcOffset, locale),
                alignEnd: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// [clock] as a fraction of its day, from 0 at midnight to 1 at the next.
  static double _dayFraction(DateTime clock) =>
      (clock.hour + clock.minute / 60 + clock.second / 3600) / 24;
}

/// An event's icon, its name and its time.
class _EventTime extends StatelessWidget {
  const _EventTime({
    required this.icon,
    required this.label,
    required this.time,
    this.alignEnd = false,
  });

  final Widget icon;
  final String label;
  final String time;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: Dimens.spacingTiny),
            Text(
              label,
              style: TextStyle(
                fontSize: Dimens.fontTiny,
                color: AppPalette.secondaryLabel(context),
              ),
            ),
          ],
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: Dimens.fontMedium,
            fontWeight: FontWeight.w700,
            color: AppPalette.label(context),
          ),
        ),
      ],
    );
  }
}
