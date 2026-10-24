import 'package:flutter/widgets.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';

/// A rounded, flat card on the grouped background — the iOS inset-grouped
/// look. No shadows: the card is set apart by its colour alone.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.radius,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color ?? AppPalette.card(context),
        borderRadius: BorderRadius.circular(radius ?? Dimens.radius),
      ),
      child: child,
    );
  }
}
