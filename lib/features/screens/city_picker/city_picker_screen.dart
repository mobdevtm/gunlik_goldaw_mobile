import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:go_router/go_router.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/location/device_location_service.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/city_mapper.dart';
import 'package:gunluk_goldaw_mobile/features/providers/location_provider.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/content_width.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/nav_back_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

/// The cities of [TmCities] to choose from, as an inset grouped list, under
/// a "my location" row.
///
/// Picking one is all it takes: the coordinator hears the change and
/// reloads every section for the new place. The tick marks what is shown
/// now — the device, or one city.
class CityPickerScreen extends StatelessWidget {
  const CityPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationProvider>();
    final tint = AppPalette.tint(context);

    return Scaffold(
      backgroundColor: AppPalette.background(context),
      appBar: CupertinoNavigationBar(
        leading: const NavBackButton(),
        middle: Text('select_city'.tr()),
      ),
      body: SafeArea(
        child: ContentWidth(
          child: ListView(
            children: [
              CupertinoListSection.insetGrouped(
                children: const [_MyLocationTile()],
              ),
              CupertinoListSection.insetGrouped(
                children: [
                  for (final city in location.cities)
                    CupertinoListTile(
                      leading: PhosphorIcon(
                        PhosphorIcons.mapPin(PhosphorIconsStyle.duotone),
                        size: Dimens.iconNormal,
                        color: tint,
                      ),
                      title: Text(CityMapper.labelKey(city).tr()),
                      trailing:
                          !location.usesDevice && identical(city, location.city)
                          ? PhosphorIcon(
                              PhosphorIcons.check(PhosphorIconsStyle.bold),
                              size: Dimens.iconSmall,
                              color: tint,
                            )
                          : null,
                      onTap: () {
                        location.selectCity(city);
                        context.pop();
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Asks for the device location. When it was refused for good, or location
/// services are off, the tap opens the settings where that can be changed.
class _MyLocationTile extends StatelessWidget {
  const _MyLocationTile();

  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationProvider>();
    final hint = switch (location.access) {
      LocationAccess.deniedForever => 'location_denied',
      LocationAccess.serviceDisabled => 'location_service_off',
      LocationAccess.unknown ||
      LocationAccess.granted ||
      LocationAccess.denied => 'location_hint',
    };

    return CupertinoListTile(
      leading: PhosphorIcon(
        PhosphorIcons.navigationArrow(PhosphorIconsStyle.fill),
        size: Dimens.iconNormal,
        color: AppPalette.tint(context),
      ),
      title: Text('my_location'.tr()),
      subtitle: Text(hint.tr()),
      trailing: location.isLocating
          ? const CupertinoActivityIndicator()
          : location.usesDevice
          ? PhosphorIcon(
              PhosphorIcons.check(PhosphorIconsStyle.bold),
              size: Dimens.iconSmall,
              color: AppPalette.tint(context),
            )
          : null,
      onTap: location.isLocating
          ? null
          : () async {
              await location.useDeviceLocation();
              if (context.mounted && location.usesDevice) context.pop();
            },
    );
  }
}
