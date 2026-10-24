import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/errors/api_error_handler.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/error_visual_mapper.dart';
import 'package:gunluk_goldaw_mobile/features/providers/connectivity_provider.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/app_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

/// Says the device is offline, above whatever data is still on screen.
///
/// Hidden while online; slides in and out as the connection changes.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isOffline = context.select<ConnectivityProvider, bool>(
      (provider) => provider.isOffline,
    );
    final visual = ErrorVisualMapper.map(ErrorType.network);
    final warning = AppPalette.warning(context);

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: !isOffline
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: EdgeInsets.only(bottom: Dimens.spacingMedium),
              child: AppCard(
                color: warning.withValues(alpha: 0.14),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.cardPadding,
                  vertical: Dimens.spacingSmall,
                ),
                child: Row(
                  children: [
                    PhosphorIcon(
                      visual.icon,
                      size: Dimens.iconNormal,
                      color: warning,
                    ),
                    SizedBox(width: Dimens.spacingMedium),
                    Expanded(
                      child: Text(
                        'offline_banner'.tr(),
                        style: TextStyle(
                          fontSize: Dimens.fontSmall,
                          fontWeight: FontWeight.w600,
                          color: AppPalette.label(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
