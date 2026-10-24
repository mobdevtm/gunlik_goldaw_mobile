import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/errors/api_error_handler.dart';
import 'package:gunluk_goldaw_mobile/core/errors/base_error.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/error_visual_mapper.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/app_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A section that failed with nothing cached: what went wrong and a retry,
/// in the space the card would have taken.
class SectionErrorView extends StatelessWidget {
  const SectionErrorView({
    super.key,
    required this.error,
    this.offline = false,
    this.onRetry,
  });

  final BaseError? error;

  /// Words it as "no connection" whatever [error] says.
  final bool offline;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final type = offline
        ? ErrorType.network
        : (error?.type ?? ErrorType.unknown);
    final visual = ErrorVisualMapper.map(type);
    final message = offline
        ? 'offline_no_data'.tr()
        : (error?.message.isNotEmpty ?? false)
        ? error!.message
        : visual.messageKey.tr();

    return AppCard(
      padding: EdgeInsets.all(Dimens.cardPaddingLarge),
      child: Column(
        children: [
          PhosphorIcon(
            visual.icon,
            size: Dimens.iconLarge,
            color: visual.color,
          ),
          SizedBox(height: Dimens.spacingMedium),
          Text(
            visual.titleKey.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimens.fontNormal,
              fontWeight: FontWeight.w600,
              color: AppPalette.label(context),
            ),
          ),
          SizedBox(height: Dimens.spacingTiny),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimens.fontSmall,
              color: AppPalette.secondaryLabel(context),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: Dimens.spacing),
            CupertinoButton.tinted(
              onPressed: onRetry,
              sizeStyle: CupertinoButtonSize.small,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PhosphorIcon(
                    PhosphorIcons.arrowsClockwise(PhosphorIconsStyle.bold),
                    size: Dimens.iconSmall,
                  ),
                  SizedBox(width: Dimens.spacingSmall),
                  Text('try_again'.tr()),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
