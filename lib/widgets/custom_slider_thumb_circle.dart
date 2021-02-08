import 'package:flutter/material.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  Color thumbColor;
  CustomSliderThumbCircle({@required this.thumbRadius, thumbColor}) {
    this.thumbColor = thumbColor ?? Colors.grey;
  }

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = thumbColor.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * 0.57735 + 0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius + 2, shadowPaint);
    canvas.drawCircle(center, thumbRadius, paint);
  }
}
