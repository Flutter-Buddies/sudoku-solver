import 'package:flutter/material.dart';
import 'package:sudoku_solver/constants/enums.dart';
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

  // Slider variables
  double _currentSliderValue;
  String _sliderText;
  Color _borderColor;
  bool _animationHasPlayed = false;

  // Animations
  Animation<double> _sliderThumbAnimation;
  AnimationController _sliderThumbController;
  Animation<double> _loadingAnimation;
  AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    // Initialise slider variables
    _currentSliderValue = 0;
    _sliderText = '    Slide to solve >>>';
    _borderColor = Colors.blueAccent;

    // Initialise slider thumb animations
    _sliderThumbController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _sliderThumbAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _sliderThumbController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn));
    _sliderThumbController.addListener(() {
      setState(() {});
    });

    // Initialise loading text animation
    _loadingController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _loadingAnimation = Tween(begin: 3.0, end: 8.0).animate(CurvedAnimation(
        parent: _loadingController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut));
    _loadingController.addListener(() {
      setState(() {});
    });
    _loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _loadingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _loadingController.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sliderThumbController.dispose();
    _loadingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<SudokuGrid>().solveScreenStates ==
            SolveScreenStates.Idle &&
        context.watch<SudokuGrid>().boardErrors == BoardErrors.None) {
      //! This is definitely a very bad way of doing this!
      if (_animationHasPlayed == true) {
        _sliderThumbController.reverse();
        _animationHasPlayed = false;
      }
      setState(() {
        _sliderText = '    Slide to solve >>>';
        _borderColor = Colors.blueAccent;
      });
      _loadingController.reset();
    }

    if (context.watch<SudokuGrid>().solveScreenStates ==
        SolveScreenStates.Solved) {
      setState(() {
        _borderColor = Colors.green;
        _sliderText = 'SOLVED!';
      });
      _loadingController.reset();
    }

    if (context.watch<SudokuGrid>().solveScreenStates ==
        SolveScreenStates.Loading) {
      setState(() {
        _sliderText = 'Solving...';
      });
      _loadingController.forward();
    }

    if (context.watch<SudokuGrid>().boardErrors == BoardErrors.Duplicate) {
      setState(() {
        _borderColor = Colors.red;
        _sliderText = 'Invalid Board';
      });
      _loadingController.reset();
    }

    if (context.watch<SudokuGrid>().boardErrors == BoardErrors.UnSolvable) {
      setState(() {
        _borderColor = Colors.red;
        _sliderText = 'Unsolvable';
      });
      _loadingController.reset();
    }
    return Container(
      height: _height,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: _borderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: _borderColor.withOpacity(0.20),
                    offset: Offset(0.0, 0.0),
                    blurRadius: 5,
                    spreadRadius: _loadingAnimation.value,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: context.watch<SudokuGrid>().solveScreenStates ==
                    SolveScreenStates.Loading
                ? SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator())
                : Text(
                    _sliderText,
                    style: TextStyle(
                      color: _borderColor,
                    ),
                  ),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              overlayColor: Colors.transparent,
              thumbShape: CustomSliderThumbRect(
                thumbRadius: 20,
                thumbHeight: (_height - 8) * _sliderThumbAnimation.value,
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
                // _bgColorController.value = value / 100;
              },
              onChangeEnd: (double value) async {
                if (value > _threshold) {
                  setState(() {
                    // Move the slider all the way to the end
                    _currentSliderValue = 100;
                  });
                  _sliderThumbController.forward();

                  // Wait for the animation to complete before calling the function
                  await Future.delayed(_sliderThumbController.duration);
                  _animationHasPlayed = true;

                  // Reset
                  _currentSliderValue = 0;

                  // Call the function to solve
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
