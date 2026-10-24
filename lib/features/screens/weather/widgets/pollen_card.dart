import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/pollen_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/plant_info_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_forecast_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/pollen/pollen_type_info_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/level_badge.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Today's pollen by type, and the plants that are in season.
class PollenCard extends StatelessWidget {
  const PollenCard({super.key, required this.data});

  final PollenForecastModel data;

  @override
  Widget build(BuildContext context) {
    final today = data.dailyInfo?.firstOrNull;
    final types = today?.pollenTypeInfo ?? const <PollenTypeInfoModel>[];
    final plants = (today?.plantInfo ?? const <PlantInfoModel>[])
        .where((plant) => (plant.inSeason ?? false) && plant.indexInfo != null)
        .toList();

    return WeatherSectionCard(
      title: 'pollen'.tr(),
      icon: PollenMapper.typeIcon(null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final type in types) _PollenTypeRow(type: type),
          if (plants.isNotEmpty) ...[
            SizedBox(height: Dimens.spacingMedium),
            Text(
              'plants'.tr(),
              style: TextStyle(
                fontSize: Dimens.fontSmall,
                fontWeight: FontWeight.w700,
                color: AppPalette.label(context),
              ),
            ),
            SizedBox(height: Dimens.spacingSmall),
            Wrap(
              spacing: Dimens.spacingSmall,
              runSpacing: Dimens.spacingSmall,
              children: [
                for (final plant in plants)
                  LevelBadge(
                    label:
                        PollenMapper.plantLabelKey(plant.code)?.tr() ??
                        plant.displayName ??
                        '',
                    color:
                        PollenMapper.level(
                          plant.indexInfo?.value,
                        )?.color(context) ??
                        AppPalette.secondaryLabel(context),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// One pollen type with its level as five segments.
class _PollenTypeRow extends StatelessWidget {
  const _PollenTypeRow({required this.type});

  final PollenTypeInfoModel type;

  static const _segments = 5;

  @override
  Widget build(BuildContext context) {
    final value = type.indexInfo?.value;
    final level = PollenMapper.level(value);
    final color = level?.color(context) ?? AppPalette.secondaryLabel(context);
    final inSeason = type.inSeason ?? false;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.spacingSmall),
      child: Row(
        children: [
          PhosphorIcon(
            PollenMapper.typeIcon(type.code),
            size: Dimens.iconNormal,
            color: color,
          ),
          SizedBox(width: Dimens.spacingMedium),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PollenMapper.typeLabelKey(type.code).tr(),
                  style: TextStyle(
                    fontSize: Dimens.fontSmall,
                    fontWeight: FontWeight.w700,
                    color: AppPalette.label(context),
                  ),
                ),
                Text(
                  inSeason
                      ? (level?.labelKey ?? 'pollen_level_none').tr()
                      : 'out_of_season'.tr(),
                  style: TextStyle(fontSize: Dimens.fontTiny, color: color),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                for (var i = 1; i <= _segments; i++) ...[
                  if (i != 1) SizedBox(width: Dimens.spacingTiny),
                  Expanded(
                    child: Container(
                      height: Dimens.r(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimens.r(3)),
                        color: (value ?? 0) >= i
                            ? color
                            : AppPalette.fill(context),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
