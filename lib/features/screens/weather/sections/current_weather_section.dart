import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/city_mapper.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/providers/location_provider.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/location_utc_offset.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/current_conditions_card.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/current_details_grid.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_state_view.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_skeletons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The hero card and the details grid under it.
class CurrentWeatherSection extends StatelessWidget {
  const CurrentWeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    final place = context.select<LocationProvider, String>(
      (provider) => provider.usesDevice
          ? provider.placeLabel ?? 'my_location'.tr()
          : CityMapper.labelKey(provider.city).tr(),
    );
    final utcOffset = context.locationUtcOffset;

    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) => SectionStateView(
        state: state,
        skeleton: const HeroSkeleton(),
        onRetry: () => getIt<WeatherRefreshCoordinator>().reload(
          context.read<CurrentWeatherBloc>(),
        ),
        builder: (context, data) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurrentConditionsCard(
              data: data,
              cityName: place,
              utcOffset: utcOffset,
            ),
            SizedBox(height: Dimens.spacingLarge),
            WeatherSectionCard(
              title: 'weather_details'.tr(),
              icon: PhosphorIcons.listBullets(PhosphorIconsStyle.duotone),
              child: CurrentDetailsGrid(data: data),
            ),
          ],
        ),
      ),
    );
  }
}
