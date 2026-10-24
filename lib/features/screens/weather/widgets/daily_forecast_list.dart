import 'package:flutter/widgets.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/daily_forecast_row.dart';

/// The forecast days, one row each, on a shared temperature scale.
class DailyForecastList extends StatelessWidget {
  const DailyForecastList({
    super.key,
    required this.days,
    required this.onDayTap,
    this.utcOffset,
  });

  final List<ForecastDayModel> days;
  final ValueChanged<int> onDayTap;
  final Duration? utcOffset;

  @override
  Widget build(BuildContext context) {
    final lows = days.map((d) => d.minTemperature?.degrees).nonNulls;
    final highs = days.map((d) => d.maxTemperature?.degrees).nonNulls;
    final scaleMin = lows.isEmpty ? 0.0 : lows.reduce((a, b) => a < b ? a : b);
    final scaleMax = highs.isEmpty
        ? 0.0
        : highs.reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        for (var i = 0; i < days.length; i++) ...[
          if (i != 0)
            Container(height: 0.5, color: AppPalette.separator(context)),
          DailyForecastRow(
            day: days[i],
            scaleMin: scaleMin,
            scaleMax: scaleMax,
            utcOffset: utcOffset,
            onTap: () => onDayTap(i),
          ),
        ],
      ],
    );
  }
}
