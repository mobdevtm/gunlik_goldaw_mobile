import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/wind_direction_mapper.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// An arrow turned to point downwind, in a small inset dial.
///
/// Turning is animated, so a refreshed reading swings the arrow round
/// instead of jumping it.
class WindDirectionIndicator extends StatelessWidget {
  const WindDirectionIndicator({super.key, required this.degrees, this.size});

  final int? degrees;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final dial = size ?? Dimens.iconNormal;
    final angle = WindDirectionMapper.rotationRadians(degrees);
    final color = AppPalette.tint(context);

    return Container(
      width: dial,
      height: dial,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.fill(context),
      ),
      child: angle == null
          ? null
          : TweenAnimationBuilder<double>(
              tween: Tween(end: angle),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) =>
                  Transform.rotate(angle: value, child: child),
              child: PhosphorIcon(
                WindDirectionMapper.icon(),
                size: dial * 0.6,
                color: color,
              ),
            ),
    );
  }
}
