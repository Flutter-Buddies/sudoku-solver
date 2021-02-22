import 'package:flutter/material.dart';
import 'sudoku_table.dart';

import 'animated_solve_button.dart';
import 'keypad.dart';
import 'options_row.dart';

class VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blue background at top of the screen
        // Using [FractionallySizedBox] so that is always takes up ~1/3 of screen height
        FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 0.33,
          child: Container(
            color: Colors.blueAccent,
          ),
        ),
        Center(
          child: Column(
            children: [
              Spacer(flex: 3),
              FractionallySizedBox(
                widthFactor: 0.92,
                child: OptionsRow(),
              ),
              Spacer(),
              FractionallySizedBox(
                widthFactor: 0.92,
                child: SudokuTable(),
              ),
              Spacer(flex: 2),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: KeyPad(),
              ),
              Spacer(flex: 2),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: AnimatedSolveButton(),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
