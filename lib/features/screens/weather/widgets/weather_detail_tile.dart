import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// One reading: what it is, its value, and an optional word about it.
///
/// [leading] replaces the icon when the reading draws its own, like the wind
/// arrow.
class WeatherDetailTile extends StatelessWidget {
  const WeatherDetailTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.leading,
    this.caption,
    this.accent,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Widget? leading;
  final String? caption;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final muted = AppPalette.secondaryLabel(context);
    final accentColor = accent ?? AppPalette.tint(context);

    return Container(
      padding: EdgeInsets.all(Dimens.spacingSmall),
      decoration: BoxDecoration(
        color: AppPalette.fill(context),
        borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              leading ??
                  PhosphorIcon(
                    icon ?? PhosphorIcons.info(PhosphorIconsStyle.duotone),
                    size: Dimens.iconSmall,
                    color: accentColor,
                  ),
              SizedBox(width: Dimens.spacingSmall),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Dimens.fontTiny, color: muted),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimens.spacingSmall),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: Dimens.fontMedium,
              fontWeight: FontWeight.w700,
              color: AppPalette.label(context),
            ),
          ),
          if (caption != null) ...[
            SizedBox(height: Dimens.spacingTiny),
            Text(
              caption!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Dimens.fontTiny,
                fontWeight: FontWeight.w600,
                color: accent ?? muted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
