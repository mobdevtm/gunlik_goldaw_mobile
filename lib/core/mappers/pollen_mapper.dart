import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The Universal Pollen Index's six levels (0–5).
enum PollenLevel {
  none(
    labelKey: 'pollen_level_none',
    light: Color(0xFF8A938B),
    dark: Color(0xFF9BA69C),
  ),
  veryLow(
    labelKey: 'pollen_level_very_low',
    light: Color(0xFF2E9E5B),
    dark: Color(0xFF5FD08C),
  ),
  low(
    labelKey: 'pollen_level_low',
    light: Color(0xFF7FA31E),
    dark: Color(0xFFB4D45A),
  ),
  moderate(
    labelKey: 'pollen_level_moderate',
    light: Color(0xFFC9A11B),
    dark: Color(0xFFF0CC4E),
  ),
  high(
    labelKey: 'pollen_level_high',
    light: Color(0xFFDB7A1F),
    dark: Color(0xFFF5A05A),
  ),
  veryHigh(
    labelKey: 'pollen_level_very_high',
    light: Color(0xFFD0453F),
    dark: Color(0xFFF0807A),
  );

  const PollenLevel({
    required this.labelKey,
    required this.light,
    required this.dark,
  });

  final String labelKey;
  final Color light;
  final Color dark;

  Color color(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}

class PollenMapper {
  PollenMapper._();

  static PollenLevel? level(int? value) {
    if (value == null) return null;
    return PollenLevel.values[value.clamp(0, PollenLevel.values.length - 1)];
  }

  /// For a pollen type code: `GRASS`, `TREE` or `WEED`.
  static PhosphorIconData typeIcon(
    String? code, [
    PhosphorIconsStyle style = PhosphorIconsStyle.duotone,
  ]) => switch (code) {
    'GRASS' => PhosphorIcons.grains(style),
    'TREE' => PhosphorIcons.tree(style),
    'WEED' => PhosphorIcons.flower(style),
    _ => PhosphorIcons.plant(style),
  };

  static String typeLabelKey(String? code) => switch (code) {
    'GRASS' => 'pollen_type_grass',
    'TREE' => 'pollen_type_tree',
    'WEED' => 'pollen_type_weed',
    _ => 'pollen_type_unknown',
  };

  static const _plants = {
    'ALDER',
    'ASH',
    'BIRCH',
    'COTTONWOOD',
    'ELM',
    'MAPLE',
    'OLIVE',
    'JUNIPER',
    'OAK',
    'PINE',
    'CYPRESS_PINE',
    'HAZEL',
    'GRAMINALES',
    'RAGWEED',
    'MUGWORT',
  };

  /// A key such as `plant_birch`, or null for a plant this app does not
  /// know yet — the caller then falls back to the API's `displayName`.
  static String? plantLabelKey(String? code) =>
      _plants.contains(code) ? 'plant_${code!.toLowerCase()}' : null;
}
