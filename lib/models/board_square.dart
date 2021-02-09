import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/position_model.dart';

class BoardSquare extends ChangeNotifier {
  Position position;
  int value;
  bool userInputted;
  bool hasError;

  BoardSquare({
    @required this.position,
    @required this.value,
    this.userInputted = false,
    this.hasError = false,
  });

  void updateValue(int i) {
    value = i;
    userInputted = true;
    notifyListeners();
  }

  String toString() {
    return value.toString();
  }
}
