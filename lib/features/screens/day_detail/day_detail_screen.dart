import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/daily_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/daily_forecast_bloc/daily_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/providers/weather_selection_provider.dart';
import 'package:gunluk_goldaw_mobile/features/screens/day_detail/widgets/day_selector.dart';
import 'package:gunluk_goldaw_mobile/features/screens/day_detail/widgets/day_summary_card.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/location_utc_offset.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/day_part_card.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/sun_moon_card.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/content_width.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/offline_banner.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_state_view.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_skeletons.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/nav_back_button.dart';

/// One forecast day in full: both halves, and the sun and moon.
/// Reads the daily section's cache, so opening a day costs no request. The
/// day shown is the one picked in [WeatherSelectionProvider], and the chips
/// at the top step through the others.
class DayDetailScreen extends StatelessWidget {
  const DayDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<DailyForecastBloc>()),
        BlocProvider.value(value: getIt<HourlyForecastBloc>()),
      ],
      child: Scaffold(
        backgroundColor: AppPalette.background(context),
        appBar: CupertinoNavigationBar(
          leading: const NavBackButton(),
          middle: Text('day_detail'.tr()),
        ),
        body: SafeArea(
          child: ContentWidth(
            child: BlocBuilder<DailyForecastBloc, DailyForecastState>(
              builder: (context, state) => ListView(
                padding: EdgeInsets.fromLTRB(
                  Dimens.screenPadding,
                  Dimens.spacingSmall,
                  Dimens.screenPadding,
                  Dimens.spacingLarge,
                ),
                children: [
                  const OfflineBanner(),
                  SectionStateView(
                    state: state,
                    skeleton: const CardSkeleton(lines: 4),
                    onRetry: () => getIt<WeatherRefreshCoordinator>().reload(
                      context.read<DailyForecastBloc>(),
                    ),
                    builder: (context, data) => _DayDetail(data: data),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DayDetail extends StatelessWidget {
  const _DayDetail({required this.data});

  final DailyForecastModel data;

  @override
  Widget build(BuildContext context) {
    final days = data.forecastDays ?? const [];
    final picked = context.select<WeatherSelectionProvider, int>(
      (provider) => provider.selectedDayIndex,
    );
    final selected = picked.clamp(0, days.length - 1);
    final day = days[selected];
    final utcOffset = context.locationUtcOffset;
    final daytime = day.daytimeForecast;
    final nighttime = day.nighttimeForecast;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DaySelector(
          days: days,
          selectedIndex: selected,
          utcOffset: utcOffset,
          onSelected: context.read<WeatherSelectionProvider>().selectDay,
        ),
        SizedBox(height: Dimens.spacingMedium),
        DaySummaryCard(day: day),
        if (daytime != null) ...[
          SizedBox(height: Dimens.spacing),
          DayPartCard(part: daytime, isDaytime: true),
        ],
        if (nighttime != null) ...[
          SizedBox(height: Dimens.spacing),
          DayPartCard(part: nighttime, isDaytime: false),
        ],
        SizedBox(height: Dimens.spacing),
        SunCard(day: day, utcOffset: utcOffset),
        SizedBox(height: Dimens.spacing),
        MoonCard(day: day, utcOffset: utcOffset),
      ],
    );
  }
}
