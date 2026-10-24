import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/core/routes/routes.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/daily_forecast_bloc/daily_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/providers/weather_selection_provider.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/location_utc_offset.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/daily_forecast_list.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_state_view.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_skeletons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The 10-day list. A row opens that day's detail screen.
class DailyForecastSection extends StatelessWidget {
  const DailyForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    final utcOffset = context.locationUtcOffset;

    return BlocBuilder<DailyForecastBloc, DailyForecastState>(
      builder: (context, state) => SectionStateView(
        state: state,
        skeleton: const CardSkeleton(lines: 5),
        onRetry: () => getIt<WeatherRefreshCoordinator>().reload(
          context.read<DailyForecastBloc>(),
        ),
        builder: (context, data) => WeatherSectionCard(
          title: 'daily_forecast'.tr(),
          icon: PhosphorIcons.calendarDots(PhosphorIconsStyle.duotone),
          child: DailyForecastList(
            days: data.forecastDays ?? const [],
            utcOffset: utcOffset,
            onDayTap: (index) {
              context.read<WeatherSelectionProvider>().selectDay(index);
              context.push(Routes.dayDetail);
            },
          ),
        ),
      ),
    );
  }
}
