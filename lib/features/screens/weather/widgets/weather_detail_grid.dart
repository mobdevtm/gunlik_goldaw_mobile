import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';

/// Lays tiles out in equal columns: two on a phone, more on a tablet.
///
/// Every tile in a row takes the height of the tallest one, so a tile with
/// a caption or a two-line label grows its whole row instead of standing
/// out — the boxes read as one even grid. A short last row keeps the same
/// column width rather than stretching.
class WeatherDetailGrid extends StatelessWidget {
  const WeatherDetailGrid({super.key, required this.children});

  final List<Widget> children;

  static int get _columns =>
      Dimens.gridColumnsLarge + (Dimens.isTablet ? 1 : 0);

  @override
  Widget build(BuildContext context) {
    final columns = _columns;
    final spacing = Dimens.gridSpacing;

    return Column(
      children: [
        for (var start = 0; start < children.length; start += columns) ...[
          if (start > 0) SizedBox(height: spacing),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var column = 0; column < columns; column++) ...[
                  if (column > 0) SizedBox(width: spacing),
                  Expanded(
                    child: start + column < children.length
                        ? children[start + column]
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
