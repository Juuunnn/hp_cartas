import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/personaje.dart';

import '../../lib/domain/problem.dart';

void main() {
  group('constructor personaje debe ', () {
    test('construir con todos los elementos completos', () {
      final resultado = PersonajeHP.constructor(
        nombre: 'Harry Potter',
        especie: 'human',
        casa: 'Gryffindor',
        genero: 'male',
        fechaNacimiento: '31-07-1980',
        ancestry: 'half-blood',
        patronus: 'stag',
        barita: Barita(wood: "holly", core: "phoenix feather", length: 11),
        estudiante: true,
        profesor: false,
        direccionImagen: 'https://hp-api.herokuapp.com/images/harry.jpg',
      );
      expect(resultado, isA<PersonajeHP>());
    });
    test('construir con los minimos elementos', () {
      final resultado = PersonajeHP.constructor(
        nombre: 'Harry Potter',
        especie: 'human',
        genero: 'male',
        estudiante: true,
        profesor: false,
      );
      expect(resultado, isA<PersonajeHP>());
    });
    test('tener nombre balido', () {
      expect(() {
        final resultado = PersonajeHP.constructor(
          nombre: ' ',
          especie: 'human',
          genero: 'male',
          estudiante: true,
          profesor: false,
        );
      }, throwsA(isA<NombreInbalido>()));
    });
  });
}
