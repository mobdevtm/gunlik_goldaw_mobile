import 'package:flutter/material.dart';

/// A line chart of one reading across the past hours, with the area under
/// it washed in the line's colour.
///
/// Missing readings break the line instead of being drawn as zero — a gap
/// in the data should look like a gap.
class HistoryChartPainter extends CustomPainter {
  HistoryChartPainter({
    required this.values,
    required this.xLabels,
    required this.formatValue,
    required this.lineColor,
    required this.gridColor,
    required this.labelStyle,
    required this.strokeWidth,
    required this.dotRadius,
    required this.labelGap,
  });

  /// Oldest first, one per hour.
  final List<double?> values;

  /// Same length as [values]; an empty string draws no label.
  final List<String> xLabels;
  final String Function(double value) formatValue;
  final Color lineColor;
  final Color gridColor;
  final TextStyle labelStyle;
  final double strokeWidth;
  final double dotRadius;
  final double labelGap;

  static const _gridLines = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final present = values.nonNulls;
    if (present.isEmpty) return;

    var low = present.reduce((a, b) => a < b ? a : b);
    var high = present.reduce((a, b) => a > b ? a : b);
    if (high == low) {
      // A flat line still needs a scale to sit in the middle of.
      high += 1;
      low -= 1;
    }

    final highLabel = _text(formatValue(high));
    final lowLabel = _text(formatValue(low));
    final yLabelWidth = highLabel.width > lowLabel.width
        ? highLabel.width
        : lowLabel.width;
    final xLabelHeight = _text('0').height;

    final chart = Rect.fromLTRB(
      yLabelWidth + labelGap,
      dotRadius + highLabel.height / 2,
      size.width - dotRadius,
      size.height - xLabelHeight - labelGap,
    );

    _paintGrid(canvas, chart, highLabel, lowLabel);

    final stepX = values.length < 2 ? 0.0 : chart.width / (values.length - 1);
    Offset pointAt(int i) => Offset(
      chart.left + stepX * i,
      chart.bottom - (values[i]! - low) / (high - low) * chart.height,
    );

    _paintSeries(canvas, chart, pointAt);
    _paintXLabels(canvas, chart, stepX, size.height - xLabelHeight);
  }

  void _paintGrid(
    Canvas canvas,
    Rect chart,
    TextPainter highLabel,
    TextPainter lowLabel,
  ) {
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (var i = 0; i <= _gridLines; i++) {
      final y = chart.top + chart.height * i / _gridLines;
      canvas.drawLine(Offset(chart.left, y), Offset(chart.right, y), grid);
    }
    highLabel.paint(canvas, Offset(0, chart.top - highLabel.height / 2));
    lowLabel.paint(canvas, Offset(0, chart.bottom - lowLabel.height / 2));
  }

  void _paintSeries(Canvas canvas, Rect chart, Offset Function(int) pointAt) {
    final line = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withValues(alpha: 0.28),
          lineColor.withValues(alpha: 0),
        ],
      ).createShader(chart);

    // Each unbroken run of readings is its own line and its own fill.
    var run = <Offset>[];
    void flush() {
      if (run.length > 1) {
        final path = Path()..moveTo(run.first.dx, run.first.dy);
        for (final point in run.skip(1)) {
          path.lineTo(point.dx, point.dy);
        }
        final area = Path.from(path)
          ..lineTo(run.last.dx, chart.bottom)
          ..lineTo(run.first.dx, chart.bottom)
          ..close();
        canvas
          ..drawPath(area, fill)
          ..drawPath(path, line);
      }
      run = [];
    }

    Offset? last;
    for (var i = 0; i < values.length; i++) {
      if (values[i] == null) {
        flush();
        continue;
      }
      final point = pointAt(i);
      run.add(point);
      last = point;
    }
    flush();

    if (last != null) {
      canvas.drawCircle(last, dotRadius, Paint()..color = lineColor);
    }
  }

  void _paintXLabels(Canvas canvas, Rect chart, double stepX, double top) {
    for (var i = 0; i < xLabels.length; i++) {
      if (xLabels[i].isEmpty) continue;
      final label = _text(xLabels[i]);
      final x = (chart.left + stepX * i - label.width / 2).clamp(
        chart.left - label.width / 2,
        chart.right - label.width,
      );
      label.paint(canvas, Offset(x, top));
    }
  }

  TextPainter _text(String text) => TextPainter(
    text: TextSpan(text: text, style: labelStyle),
    textDirection: TextDirection.ltr,
  )..layout();

  @override
  bool shouldRepaint(HistoryChartPainter old) =>
      old.values != values ||
      old.xLabels != xLabels ||
      old.lineColor != lineColor ||
      old.gridColor != gridColor ||
      old.labelStyle != labelStyle;
}
