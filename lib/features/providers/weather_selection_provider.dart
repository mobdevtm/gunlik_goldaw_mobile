import 'package:flutter/foundation.dart';

/// What the history chart plots.
enum HistoryChartMetric { temperature, humidity, precipitation }

/// What the user has picked on the weather screen: a day in the daily list,
/// and what the history chart shows.
///
/// Indexes rather than models, so a reload that brings fresh data keeps the
/// same day selected instead of losing the selection.
class WeatherSelectionProvider extends ChangeNotifier {
  int _selectedDayIndex = 0;
  HistoryChartMetric _chartMetric = HistoryChartMetric.temperature;

  int get selectedDayIndex => _selectedDayIndex;
  HistoryChartMetric get chartMetric => _chartMetric;

  void selectDay(int index) {
    if (index == _selectedDayIndex || index < 0) return;
    _selectedDayIndex = index;
    notifyListeners();
  }

  void setChartMetric(HistoryChartMetric metric) {
    if (metric == _chartMetric) return;
    _chartMetric = metric;
    notifyListeners();
  }

  /// Back to "now" — used when the city changes and the old slots mean
  /// nothing for the new one.
  void reset() {
    _selectedDayIndex = 0;
    notifyListeners();
  }
}
