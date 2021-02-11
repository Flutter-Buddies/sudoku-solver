import 'package:flutter/material.dart';
import 'package:sudoku_solver/widgets/sudoku_table.dart';

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OptionsRow(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SudokuTable(),
            ),
            Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
              ),
              child: KeyPad(),
            ),
            Spacer(
              flex: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical:
                      MediaQuery.of(context).size.height < 620 ? 8.0 : 16.0),
              child: AnimatedSolveButton(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
