import 'package:flutter/material.dart';
import 'package:sudoku_solver/constants/enums.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:sudoku_solver/widgets/sudoku_table.dart';
import 'package:sudoku_solver/widgets/keypad.dart';
import 'package:provider/provider.dart';

class SolveScreen extends StatelessWidget {
  final int width = 9;
  final int height = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                  height: 50,
                  width: double.infinity,
                  child: BottomButton(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
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
