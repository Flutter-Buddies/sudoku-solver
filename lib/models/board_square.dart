import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/position_model.dart';

class BoardSquare extends ChangeNotifier {
  Position position;
  int value;

  void updateValue(int i) {
    value = i;
    notifyListeners();
  }

  BoardSquare({@required this.position, @required this.value});

  String toString() {
    return value.toString();
  }
}
