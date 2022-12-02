import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/app_storage.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/character_card.dart';
import 'package:hp_cartas/domain/spell.dart';
import 'package:hp_cartas/feature/localStorage/local_storage_writer.dart';

void main() {
  group('LocalStorageWriter debe ', () {
    test('poder recuperar los datos que escriva de CharacterCard', () {
      final character = HPCharacter.constructor(
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
      final result = CharacterCard.constructor(character: character, spells: [
        Spell(name: 'ds', description: 'description'),
        Spell(name: 'ds', description: 'description'),
        Spell(name: 'ds', description: 'description'),
      ]).toJson;
      expect(
          CharacterCard.fromJson(result.call()).character, equals(character));
    });
    // TODO: este test esta fallando por la igualdad de la clase pero el resultado se ve correcto
    test('poder recuperar los datos que escriva de AppStorage', () {
      var appStorage = AppStorage.constructor(daylyCharacterObtained: true);
      final character = HPCharacter.constructor(
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
      appStorage.obtainedCharacters[character.name] = [];
      appStorage.newCharacter(
          CharacterCard.constructor(character: character, spells: [
            Spell(name: 'ds', description: 'description'),
            Spell(name: 'ds', description: 'description'),
            Spell(name: 'ds', description: 'description'),
          ]),
          character.name);
      LocalStorageWriter.writeToLocalDB(appStorage, 'test');
      final result = LocalStorageWriter.readFromLocalDB('test');
      result.match((l) {
        assert(false);
      }, (r) {
        expect(r, equals(appStorage));
      });
      File('test.json').delete();
    });
    test('poder recuperar los datos de un HPCharacter', () {
      final character = HPCharacter.constructor(
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
      final result = character.toJson;
      expect(HPCharacter.fromJson(result.call()), equals(character));
    });
    test('poder recuperar los datos de una lista de spell', () {
      final character = [
        Spell(name: 'ds', description: 'description'),
        Spell(name: 'ds', description: 'description'),
        Spell(name: 'ds', description: 'description'),
      ];
      final result = jsonEncode(character);
      final dato = jsonDecode(result);
      final resultado = dato[0];
      print(resultado.runtimeType);
      expect(List<Spell>.from(dato.map((e) => Spell.fromJson(e))),
          equals(character));
    });
    test('poder recuperar los datos que escriva de AppStorage vacio', () {
      var appStorage = AppStorage.constructor();
      LocalStorageWriter.writeToLocalDB(appStorage, 'test');
      final result = LocalStorageWriter.readFromLocalDB('test');
      result.match((l) {
        assert(false);
      }, (r) {
        expect(r, equals(appStorage));
      });
    });
  });
}
