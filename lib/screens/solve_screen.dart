import 'package:flutter/material.dart';
import 'package:sudoku_solver/constants/enums.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:sudoku_solver/widgets/options_row.dart';
import 'package:sudoku_solver/widgets/sudoku_table.dart';
import 'package:sudoku_solver/widgets/keypad.dart';
import 'package:provider/provider.dart';

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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: OptionsRow(),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SudokuTable(),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 16.0),
                  child: KeyPad(),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: BottomButton(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buttonContent() {
      if (Provider.of<SudokuGrid>(context).solveScreenStates ==
              SolveScreenStates.Idle &&
          Provider.of<SudokuGrid>(context).boardErrors == BoardErrors.None) {
        return Text(
          'SOLVE!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).boardErrors ==
          BoardErrors.Duplicate) {
        return Text(
          'Invalid Board',
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).boardErrors ==
          BoardErrors.UnSolvable) {
        return Text(
          'This board cannot be solved',
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).solveScreenStates ==
          SolveScreenStates.Solved) {
        return Text(
          'SOLVED!',
          style: TextStyle(color: Colors.green, fontSize: 20),
        );
      } else {
        return CircularProgressIndicator(
          backgroundColor: Colors.white,
        );
      }
    }

    return RaisedButton(
      color: Colors.blueAccent,
      onPressed: () {
        final snackBar = SnackBar(
            duration: Duration(seconds: 2),
            content: Text('There is an error on the board!'));

        Provider.of<SudokuGrid>(context, listen: false).solveButtonPress(
            Provider.of<SudokuGrid>(context, listen: false).userBoard);
      },
      child: buttonContent(),
    );
  }
}
