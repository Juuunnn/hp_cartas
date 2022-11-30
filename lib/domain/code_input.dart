import 'package:hp_cartas/domain/problem.dart';

class CodeInput {
  final String searchCode;

  CodeInput._(this.searchCode);
  factory CodeInput.constructor(String prop) {
    if (int.tryParse(prop) == null) throw InvalidCode();
    if (prop.isEmpty) throw InvalidCode();
    return CodeInput._(prop);
  }
}
