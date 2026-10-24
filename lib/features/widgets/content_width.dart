import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';

/// Stops a scrolling screen from stretching across a tablet.
///
/// On a phone this is a no-op — [Dimens.contentMaxWidth] is the screen width
/// there, so the child fills it exactly as before. On a tablet the child is
/// capped at 70% of the screen and centred.
///
/// Why cap at all: a list row drawn 1024pt wide puts its two ends too far
/// apart to read as one thing — a member's avatar at the far left and their
/// role badge at the far right — and a line of text that long is hard to
/// track back to the start of the next line. Fixing the scale makes the text
/// the right size; this makes the layout the right shape.
///
/// Wraps the scroll view rather than each row, so the scrollbar and the
/// pull-to-refresh gesture still belong to the full width.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Dimens.contentMaxWidth),
        child: child,
      ),
    );
  }
}

/// [ContentWidth] for a sliver list: centres [sliver] in a column no wider
/// than [Dimens.contentMaxWidth], with [Dimens.screenPadding] at the sides at least.
///
/// For screens whose navigation bar is itself a sliver — the bar keeps the
/// full width while the cards under it stay readable on a tablet.
class SliverContentWidth extends StatelessWidget {
  const SliverContentWidth({
    super.key,
    required this.sliver,
    this.top = 0,
    this.bottom = 0,
  });

  final Widget sliver;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.crossAxisExtent;
        final side = width > Dimens.contentMaxWidth
            ? (width - Dimens.contentMaxWidth) / 2 + Dimens.screenPadding
            : Dimens.screenPadding;
        return SliverPadding(
          padding: EdgeInsets.fromLTRB(side, top, side, bottom),
          sliver: sliver,
        );
      },
    );
  }
}
