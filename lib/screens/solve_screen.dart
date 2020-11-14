import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_solver/constants/enums.dart';
import 'package:sudoku_solver/models/board_square.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:sudoku_solver/widgets/sudoku_table.dart';
import 'package:sudoku_solver/widgets/keypad.dart';
import 'package:provider/provider.dart';

class SolveScreen extends StatelessWidget {
  final int width = 9;
  final int height = 9;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                // open camera to take picture of sudoku puzzle
              },
            ),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  Provider.of<SudokuGrid>(context, listen: false).resetBoard();
                })
          ],
          title: Text('Solve Screen'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SudokuTable(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: KeyPad(),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    child: BottomButton(),
                  ),
                ),
              ),
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
    return RaisedButton(
      onPressed: () {
        final snackBar = SnackBar(duration: Duration(seconds: 2), content: Text('There is an error on the board!'));

        Provider.of<SudokuGrid>(context, listen: false)
            .solveButtonPress(Provider.of<SudokuGrid>(context, listen: false).userBoard);
        // Provider.of<SudokuGrid>(context, listen: false)
        //     .solveBoard(Provider.of<SudokuGrid>(context, listen: false).userBoard);
      },
      child: Provider.of<SudokuGrid>(context).solveScreenStates == SolveScreenStates.Idle
          ? Text('Solve!')
          : CircularProgressIndicator(),
    );
  }
}
