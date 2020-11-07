import 'package:flutter/material.dart';
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
                  // Clear board
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
                    child: RaisedButton(
                      onPressed: () {
                        // Solve the board
                        print(Provider.of<SudokuGrid>(context, listen: false));
                      },
                      child: Text('Solve!'),
                    ),
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
