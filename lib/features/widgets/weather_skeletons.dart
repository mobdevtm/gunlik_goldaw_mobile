import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/shimmer_loading.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/app_card.dart';

/// One shimmering block of a skeleton.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, required this.height, this.width, this.radius});

  final double height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) => ShimmerLoading(
    width: width ?? double.infinity,
    height: height,
    borderRadius: radius ?? Dimens.radiusSmall,
  );
}

/// The skeleton of a card: a title bar and [lines] rows under it, inside
/// the same soft panel the real card uses, so nothing jumps when it lands.
class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key, this.lines = 3, this.lineHeight});

  final int lines;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(Dimens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(height: Dimens.r(18), width: Dimens.r(140)),
          for (var i = 0; i < lines; i++) ...[
            SizedBox(height: Dimens.spacingMedium),
            SkeletonBox(height: lineHeight ?? Dimens.r(44)),
          ],
        ],
      ),
    );
  }
}

/// The skeleton of the current conditions hero card.
class HeroSkeleton extends StatelessWidget {
  const HeroSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(Dimens.cardPaddingLarge),
      child: Column(
        children: [
          SkeletonBox(height: Dimens.r(20), width: Dimens.r(160)),
          SizedBox(height: Dimens.spacingLarge),
          SkeletonBox(
            height: Dimens.r(96),
            width: Dimens.r(96),
            radius: Dimens.r(48),
          ),
          SizedBox(height: Dimens.spacing),
          SkeletonBox(height: Dimens.r(56), width: Dimens.r(120)),
          SizedBox(height: Dimens.spacingMedium),
          SkeletonBox(height: Dimens.r(16), width: Dimens.r(180)),
        ],
      ),
    );
  }
}

/// The skeleton of a horizontal strip of [count] tiles.
class StripSkeleton extends StatelessWidget {
  const StripSkeleton({super.key, this.count = 6});

  final int count;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(Dimens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(height: Dimens.r(18), width: Dimens.r(140)),
          SizedBox(height: Dimens.spacingMedium),
          Row(
            children: [
              for (var i = 0; i < count; i++) ...[
                if (i != 0) SizedBox(width: Dimens.spacingSmall),
                Expanded(child: SkeletonBox(height: Dimens.r(112))),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
