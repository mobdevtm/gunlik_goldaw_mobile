import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/app_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A section the API answered with nothing for.
class SectionEmptyView extends StatelessWidget {
  const SectionEmptyView({super.key, this.messageKey = 'weather_empty'});

  final String messageKey;

  @override
  Widget build(BuildContext context) {
    final muted = AppPalette.secondaryLabel(context);

    return AppCard(
      padding: EdgeInsets.all(Dimens.cardPaddingLarge),
      child: Row(
        children: [
          PhosphorIcon(
            PhosphorIcons.cloudSlash(PhosphorIconsStyle.duotone),
            size: Dimens.iconLarge,
            color: muted,
          ),
          SizedBox(width: Dimens.spacing),
          Expanded(
            child: Text(
              messageKey.tr(),
              style: TextStyle(fontSize: Dimens.fontSmall, color: muted),
            ),
          ),
        ],
      ),
    );
  }
}
