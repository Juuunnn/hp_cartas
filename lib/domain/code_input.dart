import 'package:hp_cartas/domain/problem.dart';

class CodeInput {
  final String searchCode;

  CodeInput._(this.searchCode);
  factory CodeInput.constructor(String prop) {
    if (prop.isEmpty) throw EmptyInput();
    if (int.tryParse(prop) == null) throw IsNotNumber();
    return CodeInput._(prop);
  }
}
