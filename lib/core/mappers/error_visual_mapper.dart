import 'package:flutter/material.dart';
import 'package:gunluk_goldaw_mobile/core/errors/api_error_handler.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// How one kind of failure is pictured and worded.
class ErrorVisual {
  const ErrorVisual({
    required this.icon,
    required this.color,
    required this.titleKey,
    required this.messageKey,
  });

  final IconData icon;
  final Color color;
  final String titleKey;
  final String messageKey;
}

/// One picture per [ErrorType], shared by the full-screen error and the
/// compact one a weather section shows in place of its card.
class ErrorVisualMapper {
  ErrorVisualMapper._();

  static const _warning = Color(0xFFF5A524);
  static const _danger = Color(0xFFE5484D);

  static ErrorVisual map(ErrorType type) => switch (type) {
    ErrorType.network => ErrorVisual(
      icon: PhosphorIcons.wifiSlash(PhosphorIconsStyle.duotone),
      color: _warning,
      titleKey: 'no_internet_connection',
      messageKey: 'please_check_your_internet_connection',
    ),
    ErrorType.timeout => ErrorVisual(
      icon: PhosphorIcons.clockCountdown(PhosphorIconsStyle.duotone),
      color: _warning,
      titleKey: 'connection_timed_out',
      messageKey: 'the_request_took_too_long_please_try_again',
    ),
    ErrorType.unauthorized => ErrorVisual(
      icon: PhosphorIcons.lockKey(PhosphorIconsStyle.duotone),
      color: _danger,
      titleKey: 'session_expired',
      messageKey: 'please_sign_in_again_to_continue',
    ),
    ErrorType.forbidden => ErrorVisual(
      icon: PhosphorIcons.prohibit(PhosphorIconsStyle.duotone),
      color: _danger,
      titleKey: 'access_denied',
      messageKey: 'you_do_not_have_permission_to_view_this_content',
    ),
    ErrorType.server => ErrorVisual(
      icon: PhosphorIcons.cloudWarning(PhosphorIconsStyle.duotone),
      color: _danger,
      titleKey: 'server_error_title',
      messageKey: 'something_went_wrong_on_our_side_please_try_again_later',
    ),
    ErrorType.client => ErrorVisual(
      icon: PhosphorIcons.warningCircle(PhosphorIconsStyle.duotone),
      color: _warning,
      titleKey: 'something_went_wrong',
      messageKey: 'unavailable_to_process_data',
    ),
    ErrorType.badRequest => ErrorVisual(
      icon: PhosphorIcons.mapPinLine(PhosphorIconsStyle.duotone),
      color: _warning,
      titleKey: 'error_bad_request_title',
      messageKey: 'error_bad_request_message',
    ),
    ErrorType.quotaExceeded => ErrorVisual(
      icon: PhosphorIcons.hourglassMedium(PhosphorIconsStyle.duotone),
      color: _warning,
      titleKey: 'error_quota_title',
      messageKey: 'error_quota_message',
    ),
    ErrorType.unknown => ErrorVisual(
      icon: PhosphorIcons.warningCircle(PhosphorIconsStyle.duotone),
      color: Colors.grey,
      titleKey: 'something_went_wrong',
      messageKey: 'unavailable_to_process_data',
    ),
  };
}
