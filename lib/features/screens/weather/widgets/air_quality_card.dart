import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/google_language.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/air_quality_mapper.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/air_quality_index_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/air_quality_model.dart';
import 'package:gunluk_goldaw_mobile/data/model/air_quality/pollutant_model.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/level_badge.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/weather_section_card.dart';

/// The Universal AQI, its main pollutant, and each pollutant's level.
class AirQualityCard extends StatelessWidget {
  const AirQualityCard({super.key, required this.data});

  final AirQualityModel data;

  /// Units are symbols, the same in every language.
  static const _concentrationUnits = {
    'PARTS_PER_BILLION': 'ppb',
    'MICROGRAMS_PER_CUBIC_METER': 'µg/m³',
  };

  @override
  Widget build(BuildContext context) {
    final index = _universalIndex(data.indexes);
    final level = AirQualityMapper.level(index?.aqi);
    final color = level?.color(context) ?? AppPalette.tint(context);
    final pollutants = data.pollutants ?? const <PollutantModel>[];
    final dominant = _pollutantNamed(pollutants, index?.dominantPollutant);
    final muted = AppPalette.secondaryLabel(context);

    // Google writes this advice itself and has no Turkmen, so it is only
    // shown in the languages it actually comes in.
    final advice =
        GoogleLanguage.fromAppLanguage(context.locale.languageCode) == null
        ? null
        : data.healthRecommendations?.generalPopulation;

    return WeatherSectionCard(
      title: 'air_quality'.tr(),
      icon: AirQualityMapper.icon(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: Dimens.r(64),
                height: Dimens.r(64),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.fill(context),
                  border: Border.all(color: color, width: Dimens.r(3)),
                ),
                child: Center(
                  child: Text(
                    index?.aqiDisplay ??
                        index?.aqi?.toString() ??
                        WeatherFormatters.placeholder,
                    style: TextStyle(
                      fontSize: Dimens.fontLarge,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimens.spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (level != null)
                      LevelBadge(label: level.labelKey.tr(), color: color),
                    if (dominant?.displayName != null) ...[
                      SizedBox(height: Dimens.spacingTiny),
                      Text(
                        '${'dominant_pollutant'.tr()}: ${dominant!.displayName}',
                        style: TextStyle(
                          fontSize: Dimens.fontSmall,
                          color: muted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (pollutants.isNotEmpty) ...[
            SizedBox(height: Dimens.spacing),
            Wrap(
              spacing: Dimens.spacingSmall,
              runSpacing: Dimens.spacingSmall,
              children: [
                for (final pollutant in pollutants)
                  _PollutantChip(
                    pollutant: pollutant,
                    unit: _concentrationUnits[pollutant.concentration?.units],
                  ),
              ],
            ),
          ],
          if (advice != null && advice.isNotEmpty) ...[
            SizedBox(height: Dimens.spacing),
            Text(
              'health_recommendations'.tr(),
              style: TextStyle(
                fontSize: Dimens.fontSmall,
                fontWeight: FontWeight.w700,
                color: AppPalette.label(context),
              ),
            ),
            SizedBox(height: Dimens.spacingTiny),
            Text(
              advice,
              style: TextStyle(fontSize: Dimens.fontSmall, color: muted),
            ),
          ],
        ],
      ),
    );
  }

  static AirQualityIndexModel? _universalIndex(
    List<AirQualityIndexModel>? indexes,
  ) {
    if (indexes == null || indexes.isEmpty) return null;
    for (final index in indexes) {
      if (index.code == AirQualityMapper.universalAqiCode) return index;
    }
    return indexes.first;
  }

  static PollutantModel? _pollutantNamed(
    List<PollutantModel> pollutants,
    String? code,
  ) {
    for (final pollutant in pollutants) {
      if (pollutant.code == code) return pollutant;
    }
    return null;
  }
}

class _PollutantChip extends StatelessWidget {
  const _PollutantChip({required this.pollutant, this.unit});

  final PollutantModel pollutant;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final value = pollutant.concentration?.value;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.spacingMedium,
        vertical: Dimens.spacingSmall,
      ),
      decoration: BoxDecoration(
        color: AppPalette.fill(context),
        borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${pollutant.displayName ?? pollutant.code ?? ''} ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppPalette.label(context),
              ),
            ),
            TextSpan(
              text: value == null
                  ? WeatherFormatters.placeholder
                  : '${value.toStringAsFixed(1)} ${unit ?? ''}'.trim(),
              style: TextStyle(color: AppPalette.secondaryLabel(context)),
            ),
          ],
        ),
        style: TextStyle(fontSize: Dimens.fontTiny),
      ),
    );
  }
}
