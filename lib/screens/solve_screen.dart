import 'package:flutter/material.dart';
import 'package:sudoku_solver/widgets/options_row.dart';
import 'package:sudoku_solver/widgets/solve_button.dart';
import 'package:sudoku_solver/widgets/sudoku_table.dart';
import 'package:sudoku_solver/widgets/keypad.dart';

class SolveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: SolveButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
