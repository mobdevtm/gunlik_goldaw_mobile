import 'package:flutter/cupertino.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:shimmer/shimmer.dart';

/// A shimmering placeholder block in the system fill colours, so a skeleton
/// sits on its card the way the real content will.
class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
  });

  final double height;
  final double? width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final base = AppPalette.fill(context);

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: AppPalette.card(context),
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.radius),
        ),
      ),
    );
  }
}
