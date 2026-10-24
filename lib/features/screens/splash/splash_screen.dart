import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/device_utils.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/core/routes/routes.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/providers/location_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routePath = Routes.splash;
  static const routeName = Routes.splash;
  static Widget builder(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: .30,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    _navigateOnStartup();
  }

  /// Starts the first load, then hands over to the weather screen.
  ///
  /// The requests go out while the logo animates, so by the time the weather
  /// screen opens they are under way — often done — and it shows data rather
  /// than a skeleton.
  Future<void> _navigateOnStartup() async {
    getIt<WeatherRefreshCoordinator>().loadAll();

    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    context.go(Routes.weather);
    // After the hand-over, so the one-time location prompt shows over the
    // weather screen rather than the logo.
    getIt<LocationProvider>().refreshDeviceLocation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: DeviceUtils.getScaledHeight(context, 1),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 150.dr,
                      height: 150.dr,
                    ),
                    SizedBox(height: 4.dr),

                    CupertinoActivityIndicator(radius: 14.dr),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
