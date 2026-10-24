import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/features/blocs/weather_section_bloc/weather_section_bloc.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/refreshing_indicator.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_empty_view.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/section_error_view.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Renders one weather section in whichever state its bloc is in.
///
/// With data cached the data always wins: a reload adds the thin bar above
/// it, and a failed reload a one-line note with a retry — the card itself
/// never disappears. Without data, the skeleton, empty or error view takes
/// its place.
///
/// [hideWhenUnavailable] is for sections whose coverage is uncertain (air
/// quality, pollen): with no data, an empty or failed answer removes the
/// section instead of showing why.
class SectionStateView<T extends Object> extends StatelessWidget {
  const SectionStateView({
    super.key,
    required this.state,
    required this.builder,
    required this.skeleton,
    this.onRetry,
    this.hideWhenUnavailable = false,
    this.emptyMessageKey = 'weather_empty',
  });

  final WeatherSectionState<T> state;
  final Widget Function(BuildContext context, T data) builder;
  final Widget skeleton;
  final VoidCallback? onRetry;
  final bool hideWhenUnavailable;
  final String emptyMessageKey;

  @override
  Widget build(BuildContext context) {
    final data = state.cachedData;

    if (data != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RefreshingIndicator(visible: state.isBusy),
          if (state.status == SectionStatus.error && !hideWhenUnavailable)
            _ReloadFailedNote(onRetry: onRetry),
          builder(context, data),
        ],
      );
    }

    final unavailable = state.status == SectionStatus.empty || state.hasFailed;
    if (hideWhenUnavailable && unavailable) return const SizedBox.shrink();

    return switch (state.status) {
      SectionStatus.initial ||
      SectionStatus.loading ||
      SectionStatus.refreshing => skeleton,
      SectionStatus.empty => SectionEmptyView(messageKey: emptyMessageKey),
      SectionStatus.offline => SectionErrorView(
        error: state.error,
        offline: true,
        onRetry: onRetry,
      ),
      SectionStatus.error || SectionStatus.loaded => SectionErrorView(
        error: state.error,
        onRetry: onRetry,
      ),
    };
  }
}

/// One line above stale data: the reload failed, tap to try again.
class _ReloadFailedNote extends StatelessWidget {
  const _ReloadFailedNote({this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final muted = AppPalette.secondaryLabel(context);

    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.spacingSmall),
      child: GestureDetector(
        onTap: onRetry,
        child: Row(
          children: [
            PhosphorIcon(
              PhosphorIcons.warningCircle(PhosphorIconsStyle.bold),
              size: Dimens.iconSmall,
              color: muted,
            ),
            SizedBox(width: Dimens.spacingSmall),
            Expanded(
              child: Text(
                'section_failed'.tr(),
                style: TextStyle(fontSize: Dimens.fontTiny, color: muted),
              ),
            ),
            if (onRetry != null)
              PhosphorIcon(
                PhosphorIcons.arrowsClockwise(PhosphorIconsStyle.bold),
                size: Dimens.iconSmall,
                color: AppPalette.tint(context),
              ),
          ],
        ),
      ),
    );
  }
}
