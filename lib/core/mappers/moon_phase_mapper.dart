import 'package:phosphor_flutter/phosphor_flutter.dart';

/// How a `moonEvents.moonPhase` is drawn and worded.
///
/// Phosphor has no moon-phase set, so the phases are built from its
/// circles and crescent: [mirrored] flips the shape horizontally for the
/// waning half, where the lit side is on the left.
class MoonPhaseVisual {
  const MoonPhaseVisual({
    required this.icon,
    required this.labelKey,
    this.mirrored = false,
  });

  final PhosphorIconData icon;
  final String labelKey;
  final bool mirrored;
}

class MoonPhaseMapper {
  MoonPhaseMapper._();

  static MoonPhaseVisual map(String? phase) => switch (phase) {
    'NEW_MOON' => MoonPhaseVisual(
      icon: PhosphorIcons.circle(PhosphorIconsStyle.regular),
      labelKey: 'moon_phase_new_moon',
    ),
    'WAXING_CRESCENT' => MoonPhaseVisual(
      icon: PhosphorIcons.moon(PhosphorIconsStyle.fill),
      labelKey: 'moon_phase_waxing_crescent',
      mirrored: true,
    ),
    'FIRST_QUARTER' => MoonPhaseVisual(
      icon: PhosphorIcons.circleHalf(PhosphorIconsStyle.fill),
      labelKey: 'moon_phase_first_quarter',
      mirrored: true,
    ),
    'WAXING_GIBBOUS' => MoonPhaseVisual(
      icon: PhosphorIcons.circleHalfTilt(PhosphorIconsStyle.fill),
      labelKey: 'moon_phase_waxing_gibbous',
      mirrored: true,
    ),
    'FULL_MOON' => MoonPhaseVisual(
      icon: PhosphorIcons.circle(PhosphorIconsStyle.fill),
      labelKey: 'moon_phase_full_moon',
    ),
    'WANING_GIBBOUS' => MoonPhaseVisual(
      icon: PhosphorIcons.circleHalfTilt(PhosphorIconsStyle.fill),
      labelKey: 'moon_phase_waning_gibbous',
    ),
    'LAST_QUARTER' => MoonPhaseVisual(
      icon: PhosphorIcons.circleHalf(PhosphorIconsStyle.fill),
      labelKey: 'moon_phase_last_quarter',
    ),
    'WANING_CRESCENT' => MoonPhaseVisual(
      icon: PhosphorIcons.moon(PhosphorIconsStyle.fill),
      labelKey: 'moon_phase_waning_crescent',
    ),
    _ => MoonPhaseVisual(
      icon: PhosphorIcons.moon(PhosphorIconsStyle.duotone),
      labelKey: 'moon_phase_unknown',
    ),
  };
}
