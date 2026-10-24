import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';

/// A small pill naming a level in its colour — "Good", "High".
class LevelBadge extends StatelessWidget {
  const LevelBadge({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.spacingSmall,
        vertical: Dimens.r(2),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(Dimens.radiusSmall),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: Dimens.fontTiny,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
