import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/core/routes/routes.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/air_quality_bloc/air_quality_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/daily_forecast_bloc/daily_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/pollen_bloc/pollen_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_history_bloc/weather_history_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/air_quality_section.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/current_weather_section.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/daily_forecast_section.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/hourly_forecast_section.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/pollen_section.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/sun_moon_section.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/sections/weather_history_section.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/content_width.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/offline_banner.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The main screen: every section for the selected city, top to bottom,
/// under an iOS large-title bar.
///
/// It only renders. What loads and when is the coordinator's business — the
/// first load starts on the splash screen, and pulling down asks the
/// coordinator to reload everything in place.
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<CurrentWeatherBloc>()),
        BlocProvider.value(value: getIt<HourlyForecastBloc>()),
        BlocProvider.value(value: getIt<DailyForecastBloc>()),
        BlocProvider.value(value: getIt<WeatherHistoryBloc>()),
        BlocProvider.value(value: getIt<AirQualityBloc>()),
        BlocProvider.value(value: getIt<PollenBloc>()),
      ],
      child: Scaffold(
        backgroundColor: AppPalette.background(context),
        body: CustomScrollView(
          // Bouncing on every platform: the pull-to-refresh control is driven
          // by overscroll, which Android's clamping physics never produces.
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text('app_name'.tr()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _BarButton(
                    icon: PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
                    onPressed: () => context.push(Routes.cityPicker),
                  ),
                  _BarButton(
                    icon: PhosphorIcons.gear(PhosphorIconsStyle.regular),
                    onPressed: () => context.push(Routes.settings),
                  ),
                ],
              ),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: getIt<WeatherRefreshCoordinator>().refreshAll,
            ),
            SliverContentWidth(
              top: Dimens.spacingSmall,
              bottom: Dimens.spacingLarge,
              sliver: SliverList.list(
                children: [
                  const OfflineBanner(),
                  const CurrentWeatherSection(),
                  SizedBox(height: Dimens.spacingMedium),
                  const HourlyForecastSection(),
                  SizedBox(height: Dimens.spacingMedium),
                  const DailyForecastSection(),
                  SizedBox(height: Dimens.spacingMedium),
                  const WeatherHistorySection(),
                  const AirQualitySection(),
                  const PollenSection(),
                  const SunMoonSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// An icon-only button in the navigation bar.
class _BarButton extends StatelessWidget {
  const _BarButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: Dimens.spacingSmall),
      minimumSize: Size.square(Dimens.r(44)),
      onPressed: onPressed,
      child: PhosphorIcon(
        icon,
        size: Dimens.iconNormal,
        color: AppPalette.tint(context),
      ),
    );
  }
}
