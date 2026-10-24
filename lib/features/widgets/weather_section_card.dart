import 'package:flutter/widgets.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/app_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The card every weather section sits on.
///
/// Headed the way iOS Weather heads its modules: a small icon and a quiet
/// uppercase caption, then a hairline, then the content.
class WeatherSectionCard extends StatelessWidget {
  const WeatherSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.trailing,
    this.padding,
  });

  final String title;
  final Widget child;
  final IconData? icon;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final caption = AppPalette.secondaryLabel(context);

    return AppCard(
      padding: padding ?? EdgeInsets.all(Dimens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                PhosphorIcon(icon!, size: Dimens.iconSmall, color: caption),
                SizedBox(width: Dimens.spacingSmall),
              ],
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Dimens.fontTiny,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                    color: caption,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          SizedBox(height: Dimens.spacingSmall),
          Container(height: 0.5, color: AppPalette.separator(context)),
          SizedBox(height: Dimens.spacingMedium),
          child,
        ],
      ),
    );
  }
}
