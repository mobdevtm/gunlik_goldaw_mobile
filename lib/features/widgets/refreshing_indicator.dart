import 'package:flutter/cupertino.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';

/// A small spinner over a section while it reloads in place.
///
/// The section keeps showing its last data underneath, so this is all the
/// user needs to see that something is happening.
class RefreshingIndicator extends StatelessWidget {
  const RefreshingIndicator({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: visible
          ? Padding(
              padding: EdgeInsets.only(bottom: Dimens.spacingSmall),
              child: CupertinoActivityIndicator(radius: Dimens.r(8)),
            )
          : const SizedBox(width: double.infinity),
    );
  }
}
