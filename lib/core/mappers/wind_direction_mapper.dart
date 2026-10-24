import 'dart:math' as math;

import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Words and draws where the wind comes from.
///
/// The arrow is drawn pointing where the wind **goes** — the way a weather
/// map shows it — so it is the reported "from" direction turned by 180°.
class WindDirectionMapper {
  WindDirectionMapper._();

  /// Compass points in clockwise order from north, 22.5° apart.
  static const _cardinals = [
    'NORTH',
    'NORTH_NORTHEAST',
    'NORTHEAST',
    'EAST_NORTHEAST',
    'EAST',
    'EAST_SOUTHEAST',
    'SOUTHEAST',
    'SOUTH_SOUTHEAST',
    'SOUTH',
    'SOUTH_SOUTHWEST',
    'SOUTHWEST',
    'WEST_SOUTHWEST',
    'WEST',
    'WEST_NORTHWEST',
    'NORTHWEST',
    'NORTH_NORTHWEST',
  ];

  /// Rotated by [rotationRadians] to point downwind.
  static PhosphorIconData icon([
    PhosphorIconsStyle style = PhosphorIconsStyle.bold,
  ]) => PhosphorIcons.arrowUp(style);

  /// A translation key such as `wind_dir_north_northwest`.
  ///
  /// Falls back to [degrees] when [cardinal] is missing or unknown, and to
  /// `wind_dir_unknown` when both are.
  static String labelKey(String? cardinal, {int? degrees}) {
    final resolved = _cardinals.contains(cardinal)
        ? cardinal!
        : cardinalFromDegrees(degrees);
    return resolved == null
        ? 'wind_dir_unknown'
        : 'wind_dir_${resolved.toLowerCase()}';
  }

  /// The nearest of the 16 compass points to [degrees].
  static String? cardinalFromDegrees(int? degrees) {
    if (degrees == null) return null;
    final index = ((degrees % 360) / 22.5).round() % _cardinals.length;
    return _cardinals[index];
  }

  /// The arrow's rotation for a "from" bearing of [degrees], or null when
  /// there is no bearing to draw.
  static double? rotationRadians(int? degrees) {
    if (degrees == null) return null;
    return ((degrees + 180) % 360) * math.pi / 180;
  }
}
