import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_tone.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';

/// A day's low-to-high span, placed on the scale of the whole forecast.
///
/// Every row shares [scaleMin] and [scaleMax], so a glance down the list
/// shows which days run warm and which run cold.
class TemperatureRangeBar extends StatelessWidget {
  const TemperatureRangeBar({
    super.key,
    required this.min,
    required this.max,
    required this.scaleMin,
    required this.scaleMax,
  });

  final double min;
  final double max;
  final double scaleMin;
  final double scaleMax;

  @override
  Widget build(BuildContext context) {
    final span = scaleMax - scaleMin;
    final start = span <= 0 ? 0.0 : ((min - scaleMin) / span).clamp(0.0, 1.0);
    final end = span <= 0 ? 1.0 : ((max - scaleMin) / span).clamp(0.0, 1.0);
    final height = Dimens.r(6);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: AppPalette.fill(context),
            borderRadius: BorderRadius.circular(height),
          ),
          child: Stack(
            children: [
              Positioned(
                left: width * start,
                width: (width * (end - start)).clamp(height, width),
                top: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height),
                    gradient: LinearGradient(
                      colors: [
                        WeatherTone.snow.accent(context),
                        WeatherTone.clearDay.accent(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
