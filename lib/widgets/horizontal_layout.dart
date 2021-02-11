import 'package:flutter/material.dart';
import 'package:sudoku_solver/widgets/animated_solve_button.dart';
import 'package:sudoku_solver/widgets/keypad.dart';
import 'package:sudoku_solver/widgets/options_row.dart';
import 'package:sudoku_solver/widgets/sudoku_table.dart';

class HorizontalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 0.2,
          child: Container(
            color: Colors.blueAccent,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 384,
              width: 380,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AspectRatio(aspectRatio: 0.80, child: SudokuTable()),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OptionsRow(),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: KeyPad(),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AnimatedSolveButton(),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
