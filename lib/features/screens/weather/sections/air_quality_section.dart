import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/air_quality_bloc/air_quality_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/air_quality_card.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_state_view.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_skeletons.dart';

/// Air quality — present only where Google has coverage.
///
/// Carries its own top spacing, so a hidden section leaves no gap behind.
class AirQualitySection extends StatelessWidget {
  const AirQualitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AirQualityBloc, AirQualityState>(
      builder: (context, state) => SectionStateView(
        state: state,
        hideWhenUnavailable: true,
        skeleton: Padding(
          padding: EdgeInsets.only(top: Dimens.spacingMedium),
          child: const CardSkeleton(lines: 2),
        ),
        builder: (context, data) => Padding(
          padding: EdgeInsets.only(top: Dimens.spacingMedium),
          child: AirQualityCard(data: data),
        ),
      ),
    );
  }
}
