import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';

void main() {
  group('CodeInput debe ', () {
    test('debolver error cuando codigo esta vacio', () {
      expect(() => CodeInput.constructor(''), throwsA(isA<InvalidCode>()));
    });
    test('debolver error con el codigo: 28931f6w9', () {
      expect(() => CodeInput.constructor('28931f6w9'),
          throwsA(isA<InvalidCode>()));
    });
  });
}
