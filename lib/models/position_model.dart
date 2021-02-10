import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final int x;
  final int y;

  Position({this.x, this.y});

  @override
  String toString() => 'Position(x: $x, y: $y)';

  @override
  List<Object> get props => [x, y];
}
