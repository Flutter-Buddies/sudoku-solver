import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:provider/provider.dart';

class AnimatedSolveButton extends StatefulWidget {
  @override
  _AnimatedSolveButtonState createState() => _AnimatedSolveButtonState();
}

class _AnimatedSolveButtonState extends State<AnimatedSolveButton> {
  double _currentSliderValue = 0;
  final double _threshold = 90;
  final double _height = 45;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(_currentSliderValue / 100),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Center(
            child: Text(
              '    Slide to solve >>>',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              thumbShape: CustomSliderThumbCircle(
                  thumbRadius: (_height / 2) + 3, thumbColor: Colors.blue),
            ),
            child: Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
              onChangeEnd: (double value) {
                if (value > _threshold) {
                  context
                      .read<SudokuGrid>()
                      .solveButtonPress(context.read<SudokuGrid>().userBoard);
                }
                if (value <= _threshold) {
                  setState(() {
                    _currentSliderValue = 0;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
