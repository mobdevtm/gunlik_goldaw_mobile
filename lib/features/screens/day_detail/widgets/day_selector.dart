import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/forecast_day_model.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';

/// The forecast days as chips, to step between them on the detail screen.
class DaySelector extends StatelessWidget {
  const DaySelector({
    super.key,
    required this.days,
    required this.selectedIndex,
    required this.onSelected,
    this.utcOffset,
  });

  final List<ForecastDayModel> days;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Duration? utcOffset;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final primary = AppPalette.tint(context);
    // A scrolling row, not a list view, so the chips size to their text at
    // any text scale instead of to a height guessed in advance.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < days.length; index++) ...[
            if (index != 0) SizedBox(width: Dimens.spacingSmall),
            _chip(context, index, locale, primary),
          ],
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, int index, String locale, Color primary) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onSelected(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.screenPadding,
          vertical: Dimens.spacingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primary : AppPalette.card(context),
          borderRadius: BorderRadius.circular(Dimens.radiusMedium),
        ),
        child: Text(
          WeatherFormatters.dayLabel(
            days[index].displayDate,
            utcOffset,
            locale,
          ),
          style: TextStyle(
            fontSize: Dimens.fontSmall,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? CupertinoColors.white
                : AppPalette.label(context),
          ),
        ),
      ),
    );
  }
}
