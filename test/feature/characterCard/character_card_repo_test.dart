import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';

void main() {
  group('character card repo deve', () {
    test('poder obtener los datos', () {
      final repo = CharacterCardRepoTest();
      final resultado = repo.getCharacterData();
      expect(
          resultado,
          HPCharacter.constructor(
            nameProp: 'Harry Potter',
            speciesProp: 'human',
            houseProp: 'Gryffindor',
            genderProp: 'male',
            dateOfBirthProp: '31-07-1980',
            ancestryProp: 'half-blood',
            patronusProp: 'stag',
            wandProp:
                Barita(wood: "holly", core: "phoenix feather", length: 11),
            hogwartsStudentProp: true,
            hogwartsStaffProp: false,
            imageUrl: 'https://hp-api.herokuapp.com/images/harry.jpg',
          ));
    });
  });
}
