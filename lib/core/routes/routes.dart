import 'package:gunluk_goldaw_mobile/features/screens/city_picker/city_picker_screen.dart';
import 'package:gunluk_goldaw_mobile/features/screens/day_detail/day_detail_screen.dart';
import 'package:gunluk_goldaw_mobile/features/screens/settings/settings_screen.dart';
import 'package:gunluk_goldaw_mobile/features/screens/splash/splash_screen.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/weather_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

class Routes {
  static const splash = '/';

  /// The main screen, and where the splash screen hands over.
  static const weather = '/weather';

  /// The day picked in `WeatherSelectionProvider`, in full. No index in the
  /// path: the day lives in the selection, so the chips on the screen can
  /// step through the others without a navigation per tap.
  static const dayDetail = '/weather/day';

  static const cityPicker = '/weather/cities';
  static const settings = '/settings';
}

/// iOS page: slides in from the side and can be swiped back.
CupertinoPage<void> _page(GoRouterState state, Widget child) =>
    CupertinoPage<void>(key: state.pageKey, child: child);

class AppRouterConfig {
  static final goRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.weather,
        name: Routes.weather,
        pageBuilder: (context, state) => _page(state, const WeatherScreen()),
        routes: [
          GoRoute(
            path: 'day',
            name: Routes.dayDetail,
            pageBuilder: (context, state) =>
                _page(state, const DayDetailScreen()),
          ),
          GoRoute(
            path: 'cities',
            name: Routes.cityPicker,
            pageBuilder: (context, state) =>
                _page(state, const CityPickerScreen()),
          ),
        ],
      ),
      GoRoute(
        path: Routes.settings,
        name: Routes.settings,
        pageBuilder: (context, state) => _page(state, const SettingsScreen()),
      ),
    ],
  );

  static void refreshRouter() => goRouter.refresh();

  static void restartApp(BuildContext context) {
    context.go(Routes.splash, extra: {'restart': true});
  }
}
