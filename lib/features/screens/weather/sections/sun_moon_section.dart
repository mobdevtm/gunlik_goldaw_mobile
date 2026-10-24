import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_model.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/daily_forecast_bloc/daily_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/location_utc_offset.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/sun_moon_card.dart';

/// Today's sun and moon cards, from the first day of the daily forecast.
///
/// The daily section above already shows that bloc's loading and errors, so
/// this one stays out of sight until there is a day to draw.
class SunMoonSection extends StatelessWidget {
  const SunMoonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final today = context.select<DailyForecastBloc, ForecastDayModel?>(
      (bloc) => bloc.state.cachedData?.forecastDays?.firstOrNull,
    );
    if (today == null) return const SizedBox.shrink();
    final utcOffset = context.locationUtcOffset;

    return Padding(
      padding: EdgeInsets.only(top: Dimens.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SunCard(day: today, utcOffset: utcOffset),
          SizedBox(height: Dimens.spacingMedium),
          MoonCard(day: today, utcOffset: utcOffset),
        ],
      ),
    );
  }
}
