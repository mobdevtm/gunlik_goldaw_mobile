import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_condition_mapper.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A condition's icon on the soft wash of its tone.
class ConditionIcon extends StatelessWidget {
  const ConditionIcon({
    super.key,
    required this.visual,
    required this.size,
    this.withBackdrop = false,
  });

  final WeatherConditionVisual visual;
  final double size;

  /// Draws the tone's radial wash behind the icon — for the hero card.
  final bool withBackdrop;

  @override
  Widget build(BuildContext context) {
    final icon = PhosphorIcon(
      visual.icon,
      size: size,
      color: visual.tone.accent(context),
    );
    if (!withBackdrop) return icon;

    return Container(
      width: size * 1.6,
      height: size * 1.6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: visual.tone.gradient(context)),
      ),
      child: Center(child: icon),
    );
  }
}
