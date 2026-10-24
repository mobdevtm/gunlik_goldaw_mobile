import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:gunluk_goldaw_mobile/core/constants/constants.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/data/local/settings_manager.dart';
import 'package:gunluk_goldaw_mobile/di.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/content_width.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/language_picker.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:gunluk_goldaw_mobile/features/widgets/nav_back_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Language and theme, laid out like the iOS Settings app.
///
/// Both values live somewhere that already notifies — the language in the
/// locale, the theme in the settings box — so the screen only reads and
/// writes them. Units are always metric, so there is nothing to choose.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = getIt<SettingsManager>();
    final language = languageOf(context.locale.languageCode);

    return Scaffold(
      backgroundColor: AppPalette.background(context),
      appBar: CupertinoNavigationBar(
        leading: const NavBackButton(),
        middle: Text('settings'.tr()),
      ),
      body: SafeArea(
        child: ContentWidth(
          child: ListView(
            children: [
              CupertinoListSection.insetGrouped(
                header: Text('appearance'.tr()),
                children: [
                  CupertinoListTile(
                    leading: _TileIcon(
                      PhosphorIcons.translate(PhosphorIconsStyle.duotone),
                    ),
                    title: Text('language'.tr()),
                    additionalInfo: Text(language.label),
                    trailing: PhosphorIcon(
                      PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                      size: Dimens.iconSmall,
                      color: AppPalette.secondaryLabel(context),
                    ),
                    onTap: () => _pickLanguage(context, language.code),
                  ),
                  ValueListenableBuilder(
                    valueListenable: settings.box.listenable(
                      keys: [SettingsType.isDark.name],
                    ),
                    builder: (context, _, _) => CupertinoListTile(
                      leading: _TileIcon(
                        PhosphorIcons.moon(PhosphorIconsStyle.duotone),
                      ),
                      title: Text('dark_mode'.tr()),
                      trailing: CupertinoSwitch(
                        value: settings.isDark(),
                        onChanged: (value) =>
                            settings.update(SettingsType.isDark, value),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context, String current) async {
    final code = await showLanguagePicker(context, currentCode: current);
    if (code == null || code == current || !context.mounted) return;
    await changeAppLanguage(context, code);
  }
}

/// The tinted leading icon of a settings row.
class _TileIcon extends StatelessWidget {
  const _TileIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) => PhosphorIcon(
    icon,
    size: Dimens.iconNormal,
    color: AppPalette.tint(context),
  );
}
