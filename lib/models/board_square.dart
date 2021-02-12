import 'package:flutter/material.dart';
import 'position_model.dart';

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
    hasError = false;
    notifyListeners();
  }

  String toString() {
    return value.toString();
  }
}
