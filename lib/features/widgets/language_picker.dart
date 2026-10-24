import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gunluk_goldaw_mobile/core/assets/assets.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/constants.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/data/local/settings_manager.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// One selectable language: its locale code, flag asset and native label.
class LangItem {
  final String code;
  final String flag;
  final String label;

  const LangItem({required this.code, required this.flag, required this.label});
}

/// The languages the app ships with, in display order.
const List<LangItem> kAppLanguages = [
  LangItem(code: 'tk', flag: Assets.iconsTurkmenistan, label: 'Türkmen'),
  LangItem(code: 'ru', flag: Assets.iconsRussia, label: 'Русский'),
  LangItem(code: 'en', flag: Assets.iconsEnglish, label: 'English'),
];

LangItem languageOf(String code) => kAppLanguages.firstWhere(
  (l) => l.code == code,
  orElse: () => kAppLanguages.first,
);

/// Applies [code] as the app locale and persists it.
Future<void> changeAppLanguage(BuildContext context, String code) async {
  await context.setLocale(Locale(code));
  getIt<SettingsManager>().update(SettingsType.lang, code);
}

/// Opens the language picker as an iOS action sheet. Resolves to the picked
/// code, or null if it was dismissed without a choice.
Future<String?> showLanguagePicker(
  BuildContext context, {
  required String currentCode,
}) {
  return showCupertinoModalPopup<String>(
    context: context,
    builder: (sheetContext) => CupertinoActionSheet(
      title: Text('language'.tr()),
      actions: [
        for (final language in kAppLanguages)
          CupertinoActionSheetAction(
            isDefaultAction: language.code == currentCode,
            onPressed: () => Navigator.pop(sheetContext, language.code),
            child: _LanguageRow(
              language: language,
              isSelected: language.code == currentCode,
            ),
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(sheetContext),
        child: Text('cancel'.tr()),
      ),
    ),
  );
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({required this.language, required this.isSelected});

  final LangItem language;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.r(4)),
          child: SvgPicture.asset(
            language.flag,
            width: Dimens.r(28),
            height: Dimens.r(20),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: Dimens.spacingMedium),
        Expanded(child: Text(language.label)),
        if (isSelected)
          PhosphorIcon(
            PhosphorIcons.check(PhosphorIconsStyle.bold),
            size: Dimens.iconSmall,
            color: AppPalette.tint(context),
          ),
      ],
    );
  }
}
