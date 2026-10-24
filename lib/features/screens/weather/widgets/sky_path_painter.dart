import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// The path of the sun or the moon over one day, iOS Weather style: a wave
/// across the horizon, above it while the body is up.
///
/// Positions are fractions of the location's day, 0 at midnight and 1 at
/// the next. The curve is a cosine centred between [rise] and [set] and
/// shifted so it crosses the horizon exactly at both. [set] may come before
/// [rise] — the moon is often up across midnight — and either may lie
/// outside 0..1 when the event falls on another day; only the part inside
/// the day is drawn.
///
/// Under it runs an hour axis, every [_hourStep] hours from midnight to
/// midnight, with a faint line up from each mark.
class SkyPathPainter extends CustomPainter {
  SkyPathPainter({
    required this.rise,
    required this.set,
    required this.now,
    required this.color,
    required this.belowColor,
    required this.horizonColor,
    required this.strokeWidth,
    required this.dotRadius,
    required this.labelStyle,
  });

  final double rise;
  final double set;

  /// Where the body is now, or null when the day shown is not today.
  final double? now;
  final Color color;
  final Color belowColor;
  final Color horizonColor;
  final double strokeWidth;
  final double dotRadius;
  final TextStyle labelStyle;
  static const _hourStep = 3;
  static const _samples = 192;

  /// How far down the box the horizon sits: the arc above it gets the room.
  static const _horizonAt = 0.68;

  @override
  void paint(Canvas canvas, Size size) {
    final labels = [
      for (var hour = 0; hour <= 24; hour += _hourStep)
        TextPainter(
          text: TextSpan(text: _hourLabel(hour), style: labelStyle),
          textDirection: TextDirection.ltr,
        )..layout(),
    ];
    final labelHeight = labels.first.height;
    final pad = dotRadius * 2;
    final top = pad;
    final bottom = size.height - labelHeight - pad * 2;
    final horizonY = top + (bottom - top) * _horizonAt;

    _paintHourAxis(canvas, size, labels, top: top, bottom: bottom + pad);

    var upLength = (set - rise) % 1;
    if (upLength == 0) upLength = 0.5;
    final transit = rise + upLength / 2;
    final offset = math.cos(math.pi * upLength);
    double raw(double t) => math.cos(2 * math.pi * (t - transit)) - offset;
    final peak = 1 - offset;
    final trough = 1 + offset;

    Offset pointAt(double t) {
      final value = raw(t);
      final y = value >= 0
          ? horizonY - value / peak * (horizonY - top)
          : horizonY - value / trough * (bottom - horizonY);
      return Offset(t * size.width, y);
    }

    final below = Path();
    final upRuns = <List<Offset>>[];
    var run = <Offset>[];
    for (var i = 0; i <= _samples; i++) {
      final t = i / _samples;
      final point = pointAt(t);
      i == 0
          ? below.moveTo(point.dx, point.dy)
          : below.lineTo(point.dx, point.dy);
      if (raw(t) >= 0) {
        run.add(point);
      } else if (run.isNotEmpty) {
        upRuns.add(run);
        run = [];
      }
    }
    if (run.isNotEmpty) upRuns.add(run);

    canvas.drawPath(
      below,
      Paint()
        ..color = belowColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
    );

    final fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.32), color.withValues(alpha: 0.04)],
      ).createShader(Rect.fromLTRB(0, top, size.width, horizonY));
    final line = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (final points in upRuns.where((points) => points.length > 1)) {
      final arc = Path()..moveTo(points.first.dx, points.first.dy);
      for (final point in points.skip(1)) {
        arc.lineTo(point.dx, point.dy);
      }
      final area = Path.from(arc)
        ..lineTo(points.last.dx, horizonY)
        ..lineTo(points.first.dx, horizonY)
        ..close();
      canvas
        ..drawPath(area, fill)
        ..drawPath(arc, line);
    }

    canvas.drawLine(
      Offset(0, horizonY),
      Offset(size.width, horizonY),
      Paint()
        ..color = horizonColor
        ..strokeWidth = 1,
    );

    for (final t in [rise, set].where((t) => t >= 0 && t <= 1)) {
      canvas.drawCircle(
        Offset(t * size.width, horizonY),
        dotRadius * 0.6,
        Paint()..color = color,
      );
    }

    final current = now;
    if (current != null) {
      final body = pointAt(current);
      final tint = raw(current) >= 0 ? color : belowColor;
      canvas
        ..drawCircle(
          body,
          dotRadius * 2,
          Paint()..color = tint.withValues(alpha: 0.25),
        )
        ..drawCircle(body, dotRadius, Paint()..color = tint);
    }
  }

  /// A faint line at every mark and its hour under it. The two ends are
  /// pulled in so their labels stay inside the box.
  void _paintHourAxis(
    Canvas canvas,
    Size size,
    List<TextPainter> labels, {
    required double top,
    required double bottom,
  }) {
    final grid = Paint()
      ..color = horizonColor.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    for (var i = 0; i < labels.length; i++) {
      final x = size.width * i / (labels.length - 1);
      canvas.drawLine(Offset(x, top), Offset(x, bottom), grid);
      final label = labels[i];
      final left = (x - label.width / 2).clamp(0.0, size.width - label.width);
      label.paint(canvas, Offset(left, bottom + dotRadius * 0.4));
    }
  }

  /// `0:00`, `3:00` … `21:00`, and `23:59` at the closing midnight so the
  /// two ends of the day read apart.
  static String _hourLabel(int hour) => hour == 24 ? '23:59' : '$hour:00';

  @override
  bool shouldRepaint(SkyPathPainter old) =>
      old.rise != rise ||
      old.set != set ||
      old.now != now ||
      old.color != color ||
      old.belowColor != belowColor ||
      old.horizonColor != horizonColor ||
      old.strokeWidth != strokeWidth ||
      old.dotRadius != dotRadius ||
      old.labelStyle != labelStyle;
}
