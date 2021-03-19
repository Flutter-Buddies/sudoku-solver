// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "slide_to_solve": "قم بالتمرير لحل اللغز",
  "solved": "تم الحل!",
  "solving": "جاري الحل...",
  "unsolvable": "غير قابلة للحل",
  "reset": "إعادة",
  "feature_coming_soon": "ستتوفر الميزة قريبًا!",
  "take_picture": "التقط صورة",
  "invalid_puzzle_unsolvable": "لغز غير صالح - غير قابل للحل",
  "invalid_puzzle_duplicate_number": "لغز غير صالح - رقم مكرر",
  "solve": "حل",
  "invalid_board": "لوحة غير صالحة",
  "this_board_connot_be_solved": "لا يمكن حل هذه اللوحة",
  "there_is_an_error_on_the_board": "هناك خطأ في لوحة السودوكو!",
  "invalid_board_duplicate_number": "لوحة غير صالحة - رقم مكرر",
  "sudoku_solver": "Sudoku Solver",
  "change_language": "تغيير اللغة"
};
static const Map<String,dynamic> en = {
  "slide_to_solve": "Slide to solve",
  "solved": "SOLVED!",
  "solving": "Solving...",
  "unsolvable": "Unsolvable",
  "reset": "Reset",
  "feature_coming_soon": "Feature coming soon!",
  "take_picture": "Take picture",
  "invalid_puzzle_unsolvable": "Invalid Puzzle - Unsolvable",
  "invalid_puzzle_duplicate_number": "Invalid Puzzle - Duplicate Number",
  "solve": "Solve",
  "invalid_board": "Invalid Board",
  "this_board_connot_be_solved": "This board cannot be solved",
  "there_is_an_error_on_the_board": "There is an error on the board!",
  "invalid_board_duplicate_number": "Invalid Board - Duplicate Number",
  "sudoku_solver": "Sudoku Solver",
  "change_language": "Change Language"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
