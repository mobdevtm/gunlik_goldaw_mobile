import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_history_bloc/weather_history_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/history_chart.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_state_view.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_skeletons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The past 24 hours, charted.
class WeatherHistorySection extends StatelessWidget {
  const WeatherHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherHistoryBloc, WeatherHistoryState>(
      builder: (context, state) => SectionStateView(
        state: state,
        skeleton: const CardSkeleton(lines: 2),
        onRetry: () => getIt<WeatherRefreshCoordinator>().reload(
          context.read<WeatherHistoryBloc>(),
        ),
        builder: (context, data) => WeatherSectionCard(
          title: 'history_24h'.tr(),
          icon: PhosphorIcons.chartLine(PhosphorIconsStyle.duotone),
          child: HistoryChart(hours: data.historyHours ?? const []),
        ),
      ),
    );
  }
}
