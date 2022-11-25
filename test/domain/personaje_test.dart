import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/character.dart';

import 'package:hp_cartas/domain/problem.dart';

void main() {
  group('constructor personaje debe ', () {
    test('construir con todos los elementos completos', () {
      final resultado = HPCharacter.constructor(
        nameProp: 'Harry Potter',
        speciesProp: 'human',
        houseProp: 'Gryffindor',
        genderProp: 'male',
        dateOfBirthProp: '31-07-1980',
        ancestryProp: 'half-blood',
        patronusProp: 'stag',
        wandProp: Barita(wood: "holly", core: "phoenix feather", length: 11),
        hogwartsStudentProp: true,
        hogwartsStaffProp: false,
        imageUrl: 'https://hp-api.herokuapp.com/images/harry.jpg',
      );
      expect(resultado, isA<HPCharacter>());
    });
    test('construir con los minimos elementos', () {
      final resultado = HPCharacter.constructor(
        nameProp: 'Harry Potter',
        speciesProp: 'human',
        genderProp: 'male',
        hogwartsStudentProp: true,
        hogwartsStaffProp: false,
      );
      expect(resultado, isA<HPCharacter>());
    });
    test('tener nombre con caracteres', () {
      expect(
          () => HPCharacter.constructor(
                nameProp: ' ',
                speciesProp: 'human',
                genderProp: 'male',
                hogwartsStudentProp: true,
                hogwartsStaffProp: false,
              ),
          throwsA(isA<InvalidName>()));
    });
    test('tener especie con caracteres', () {
      expect(
          () => HPCharacter.constructor(
                nameProp: 'sdfas ',
                speciesProp: '',
                genderProp: 'male',
                hogwartsStudentProp: true,
                hogwartsStaffProp: false,
              ),
          throwsA(isA<InvalidSpecies>()));
    });
    test('tener genero con caracteres', () {
      expect(
          () => HPCharacter.constructor(
                nameProp: ' dfsdf',
                speciesProp: 'human',
                genderProp: '   ',
                hogwartsStudentProp: true,
                hogwartsStaffProp: false,
              ),
          throwsA(isA<InvalidGender>()));
    });
  });
}
