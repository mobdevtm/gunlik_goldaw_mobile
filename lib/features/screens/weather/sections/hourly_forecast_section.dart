import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/hourly_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/hourly_forecast_strip.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_state_view.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_skeletons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The next hours as a sideways strip.
class HourlyForecastSection extends StatelessWidget {
  const HourlyForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
      builder: (context, state) => SectionStateView(
        state: state,
        skeleton: const StripSkeleton(),
        onRetry: () => getIt<WeatherRefreshCoordinator>().reload(
          context.read<HourlyForecastBloc>(),
        ),
        builder: (context, data) => _HourlyCard(data: data),
      ),
    );
  }
}

class _HourlyCard extends StatelessWidget {
  const _HourlyCard({required this.data});

  final HourlyForecastModel data;

  @override
  Widget build(BuildContext context) {
    return WeatherSectionCard(
      title: 'hourly_forecast'.tr(),
      icon: PhosphorIcons.clock(PhosphorIconsStyle.duotone),
      child: HourlyForecastStrip(hours: data.forecastHours ?? const []),
    );
  }
}
