import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/pollen_bloc/pollen_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/pollen_card.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_state_view.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_skeletons.dart';

/// The pollen forecast — present only where Google has coverage.
class PollenSection extends StatelessWidget {
  const PollenSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PollenBloc, PollenState>(
      builder: (context, state) => SectionStateView(
        state: state,
        hideWhenUnavailable: true,
        skeleton: Padding(
          padding: EdgeInsets.only(top: Dimens.spacingMedium),
          child: const CardSkeleton(lines: 3),
        ),
        builder: (context, data) => Padding(
          padding: EdgeInsets.only(top: Dimens.spacingMedium),
          child: PollenCard(data: data),
        ),
      ),
    );
  }
}
