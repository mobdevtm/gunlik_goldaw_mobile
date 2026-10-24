import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:gunluk_goldaw_mobile/core/constants/dimens.dart';
import 'package:gunluk_goldaw_mobile/core/helpers/weather_formatters.dart';
import 'package:gunluk_goldaw_mobile/core/mappers/weather_tone.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/weather_hour_model.dart';
import 'package:gunluk_goldaw_mobile/features/providers/weather_selection_provider.dart';
import 'package:gunluk_goldaw_mobile/features/screens/weather/widgets/history_chart_painter.dart';
import 'package:gunluk_goldaw_mobile/core/constants/app_palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

/// The past 24 hours as a chart, with a switch for what it plots.
class HistoryChart extends StatelessWidget {
  const HistoryChart({super.key, required this.hours});

  /// As the API sends them — newest first.
  final List<WeatherHourModel> hours;

  /// One label every this many hours keeps the axis readable on a phone.
  static const _labelEvery = 6;

  @override
  Widget build(BuildContext context) {
    final metric = context.select<WeatherSelectionProvider, HistoryChartMetric>(
      (provider) => provider.chartMetric,
    );
    final locale = context.locale.languageCode;
    final ordered = _chronological(hours);
    final values = [for (final hour in ordered) _valueOf(hour, metric)];
    final xLabels = [
      for (var i = 0; i < ordered.length; i++)
        i % _labelEvery == 0 ? WeatherFormatters.hour(ordered[i], locale) : '',
    ];
    final unit = _unitOf(ordered, metric);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CupertinoSlidingSegmentedControl<HistoryChartMetric>(
          groupValue: metric,
          onValueChanged: (value) {
            if (value != null) {
              context.read<WeatherSelectionProvider>().setChartMetric(value);
            }
          },
          children: {
            for (final option in HistoryChartMetric.values)
              option: _SegmentLabel(
                icon: _iconOf(option),
                label: _labelKeyOf(option).tr(),
              ),
          },
        ),
        SizedBox(height: Dimens.spacing),
        SizedBox(
          height: Dimens.r(180),
          child: values.nonNulls.isEmpty
              ? Center(
                  child: Text(
                    'no_data'.tr(),
                    style: TextStyle(
                      fontSize: Dimens.fontSmall,
                      color: AppPalette.secondaryLabel(context),
                    ),
                  ),
                )
              : CustomPaint(
                  size: Size.infinite,
                  painter: HistoryChartPainter(
                    values: values,
                    xLabels: xLabels,
                    formatValue: (value) => _format(value, metric, unit),
                    lineColor: _colorOf(metric).accent(context),
                    gridColor: AppPalette.secondaryLabel(
                      context,
                    ).withValues(alpha: 0.18),
                    labelStyle: TextStyle(
                      fontSize: Dimens.fontTiny,
                      color: AppPalette.secondaryLabel(context),
                    ),
                    strokeWidth: Dimens.r(2.5),
                    dotRadius: Dimens.r(4),
                    labelGap: Dimens.spacingSmall,
                  ),
                ),
        ),
      ],
    );
  }

  static List<WeatherHourModel> _chronological(List<WeatherHourModel> hours) {
    final sorted = [...hours];
    sorted.sort((a, b) {
      final at = a.interval?.startTime;
      final bt = b.interval?.startTime;
      if (at == null || bt == null) return 0;
      return at.compareTo(bt);
    });
    return sorted;
  }

  static double? _valueOf(WeatherHourModel hour, HistoryChartMetric metric) =>
      switch (metric) {
        HistoryChartMetric.temperature => hour.temperature?.degrees,
        HistoryChartMetric.humidity => hour.relativeHumidity?.toDouble(),
        HistoryChartMetric.precipitation => hour.precipitation?.qpf?.quantity,
      };

  /// The unit key of the precipitation readings, read off the data.
  static String? _unitOf(
    List<WeatherHourModel> hours,
    HistoryChartMetric metric,
  ) {
    if (metric != HistoryChartMetric.precipitation) return null;
    for (final hour in hours) {
      final unit = hour.precipitation?.qpf?.unit;
      if (unit != null) return unit == 'INCHES' ? 'unit_in' : 'unit_mm';
    }
    return null;
  }

  static String _format(
    double value,
    HistoryChartMetric metric,
    String? unitKey,
  ) => switch (metric) {
    HistoryChartMetric.temperature => '${value.round()}°',
    HistoryChartMetric.humidity => '${value.round()}%',
    HistoryChartMetric.precipitation =>
      '${value.toStringAsFixed(1)} ${unitKey?.tr() ?? ''}'.trim(),
  };

  static IconData _iconOf(HistoryChartMetric metric) => switch (metric) {
    HistoryChartMetric.temperature => PhosphorIcons.thermometer(
      PhosphorIconsStyle.bold,
    ),
    HistoryChartMetric.humidity => PhosphorIcons.dropHalf(
      PhosphorIconsStyle.bold,
    ),
    HistoryChartMetric.precipitation => PhosphorIcons.umbrella(
      PhosphorIconsStyle.bold,
    ),
  };

  static String _labelKeyOf(HistoryChartMetric metric) => switch (metric) {
    HistoryChartMetric.temperature => 'chart_temperature',
    HistoryChartMetric.humidity => 'chart_humidity',
    HistoryChartMetric.precipitation => 'chart_precipitation',
  };

  static WeatherTone _colorOf(HistoryChartMetric metric) => switch (metric) {
    HistoryChartMetric.temperature => WeatherTone.clearDay,
    HistoryChartMetric.humidity => WeatherTone.wind,
    HistoryChartMetric.precipitation => WeatherTone.rain,
  };
}

/// One segment of the metric switch: an icon and a short label.
class _SegmentLabel extends StatelessWidget {
  const _SegmentLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.spacingTiny),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(icon, size: Dimens.r(14)),
          SizedBox(width: Dimens.spacingTiny),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: Dimens.fontTiny),
            ),
          ),
        ],
      ),
    );
  }
}
