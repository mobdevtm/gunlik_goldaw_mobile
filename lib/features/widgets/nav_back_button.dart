import 'package:flutter/cupertino.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The back button for a [CupertinoNavigationBar].
///
/// The bar's own back button draws its chevron from the `cupertino_icons`
/// font, which the app doesn't ship, so it shows a "?" box. This one draws
/// the chevron with Phosphor instead.
class NavBackButton extends StatelessWidget {
  const NavBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.square(Dimens.r(44)),
      onPressed: () => Navigator.of(context).maybePop(),
      child: PhosphorIcon(
        PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
        size: Dimens.iconNormal,
        color: AppPalette.tint(context),
        semanticLabel: CupertinoLocalizations.of(context).backButtonLabel,
      ),
    );
  }
}
