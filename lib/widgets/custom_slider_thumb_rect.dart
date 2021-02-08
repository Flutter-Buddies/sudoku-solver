import 'package:flutter/material.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  Color thumbColor;
  final double thumbHeight;
  final int min;
  final int max;

  CustomSliderThumbRect({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
    thumbColor,
  }) {
    this.thumbColor = thumbColor ?? Colors.grey;
  }

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: thumbHeight, height: thumbHeight),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = thumbColor //Thumb Background Color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = thumbColor.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * 0.57735 + 0.5)
      ..style = PaintingStyle.fill;

    // TextSpan span = new TextSpan(
    //     style: new TextStyle(
    //         fontSize: thumbHeight * .3,
    //         fontWeight: FontWeight.w700,
    //         color: Colors.white,
    //         height: 1),
    //     text: '${getValue(value)}');
    // TextPainter tp = new TextPainter(
    //     text: span,
    //     textAlign: TextAlign.left,
    //     textDirection: TextDirection.ltr);
    // tp.layout();
    // Offset textCenter =
    //     Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, shadowPaint);
    canvas.drawRRect(rRect, paint);
    // tp.paint(canvas, textCenter);
  }

  // String getValue(double value) {
  //   return (min + (max - min) * value).round().toString();
  // }
}
