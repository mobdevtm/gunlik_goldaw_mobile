import 'dart:developer';
import 'package:gunluk_goldaw_mobile/core/constants/app_theme.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/system_ui_helper.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_refresh_coordinator.dart';
import 'package:gunluk_goldaw_mobile/core/routes/routes.dart';
import 'package:gunluk_goldaw_mobile/core/tk_intl.dart';
import 'package:gunluk_goldaw_mobile/data/local/settings_manager.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/providers/connectivity_provider.dart';
import 'package:gunluk_goldaw_mobile/features/providers/location_provider.dart';
import 'package:gunluk_goldaw_mobile/features/providers/weather_selection_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SystemUiHelper.applyForTheme(false);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Future.wait([
      initializeDateFormatting(),
      EasyLocalization.ensureInitialized(),
      _initHiveAndSettings(),
    ]);
    runApp(
      ValueListenableBuilder(
        valueListenable: getIt<SettingsManager>().box.listenable(
          keys: ['lang'],
        ),
        builder: (context, box, child) {
          final savedLang = box.get('lang') as String?;
          final startLang = const ['en', 'ru', 'tk'].contains(savedLang)
              ? savedLang!
              : 'tk';
          return EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ru'), Locale('tk')],
            path: 'assets/translations',
            fallbackLocale: const Locale('tk'),
            startLocale: Locale(startLang),
            useOnlyLangCode: true,
            // `.value`: the instances live in getIt, which also hands them to
            // the refresh coordinator, so the tree must not dispose them.
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: getIt<ConnectivityProvider>(),
                ),
                ChangeNotifierProvider.value(value: getIt<LocationProvider>()),
                ChangeNotifierProvider.value(
                  value: getIt<WeatherSelectionProvider>(),
                ),
              ],
              child: const MyApp(),
            ),
          );
        },
      ),
    );
  } catch (e, stack) {
    log("CRITICAL STARTUP ERROR: $e", stackTrace: stack, name: "MAIN");
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Programmada düýpli näsazlyk döredi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      e.toString(),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
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

Future<void> _initHiveAndSettings() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await setup(); // Includes opening 'settings' box
  await getIt<SettingsManager>().init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Watches the connection, the app lifecycle, the city and the units for
    // the whole run, and reloads the weather sections when one changes.
    getIt<WeatherRefreshCoordinator>().start();
    // Apply correct system UI on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isDark = getIt<SettingsManager>().isDark();
      SystemUiHelper.applyForTheme(isDark);
    });
    super.initState();
  }

  @override
  void dispose() {
    getIt<WeatherRefreshCoordinator>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Dimens.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: getIt<SettingsManager>().box.listenable(
            keys: ['isDark'],
          ),
          builder: (context, box, _) {
            final isDark = box.get('isDark', defaultValue: false) as bool;
            SystemUiHelper.applyForTheme(isDark);
            return MaterialApp.router(
              // Keying by locale forces a full rebuild on a language switch.
              // Without it, `const` subtrees are reused as-is and keep the
              // previous language until the app restarts.
              key: ValueKey('app-${context.locale.languageCode}'),
              title: 'Günlük Goldaw',
              theme: isDark ? AppTheme.dark : AppTheme.light,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouterConfig.goRouter,
              localizationsDelegates: [
                ...context.localizationDelegates,
                TkMaterialLocalizations.delegate,
                CupertinoLocalizationsTk.delegate,
              ],
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            );
          },
        );
      },
    );
  }
}
