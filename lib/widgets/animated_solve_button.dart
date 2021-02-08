import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/widgets/custom_slider_thumb_rect.dart';

class AnimatedSolveButton extends StatefulWidget {
  @override
  _AnimatedSolveButtonState createState() => _AnimatedSolveButtonState();
}

class _AnimatedSolveButtonState extends State<AnimatedSolveButton>
    with TickerProviderStateMixin {
  // Final values
  final double _threshold = 95;
  final double _height = 50;

  // Current value of slider
  double _currentSliderValue = 0;

  // Animations
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        upperBound: 1, duration: Duration(milliseconds: 700), vsync: this);
    animation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                // Colors.blueAccent.withOpacity(_currentSliderValue / 100),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue[900].withOpacity(0.2),
                    offset: Offset(0, 5),
                    blurRadius: 5,
                    spreadRadius: 3,
                  ),
                ],
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
              overlayColor: Colors.transparent,
              thumbShape: CustomSliderThumbRect(
                thumbRadius: 20,
                thumbHeight: (_height - 8) * animation.value,
                min: 0,
                max: 100,
                thumbColor: Colors.blueAccent,
              ),
              // CustomSliderThumbCircle(
              //     thumbRadius: (_height / 2) + 3, thumbColor: Colors.blue),
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
              onChangeEnd: (double value) async {
                if (value > _threshold) {
                  setState(() {
                    _currentSliderValue = 100;
                  });
                  controller.forward();
                  await Future.delayed(controller.duration);
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
