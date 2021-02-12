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
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.05,
              child: FractionallySizedBox(
                widthFactor: 0.92,
                heightFactor: 0.92,
                child: SudokuTable(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: OptionsRow(),
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: KeyPad(),
                    ),
                    Spacer(),
                    FractionallySizedBox(
                      widthFactor: 0.85,
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
