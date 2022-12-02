import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterCard/character_repo.dart';
import 'package:hp_cartas/feature/characterDataProvider/api_data_provider.dart';

const elJson = 'test';
final ApiDataProvider dataProvider = ApiDataProviderTest(elJson);
void main() {
  group('character card repo deve', () {
    test('poder obtener los datos de Harry Potter', () async {
      final repo = CharacterRepoTest();
      final resultado = await repo.getCharacterWithName(
          characterName: 'Harry Potter', apiDataProvider: dataProvider);
      resultado.match((l) {
        assert(false);
      }, (r) {
        expect(
            r,
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
    //herminony tira error
    //Minerva McGonagall
    // cho chang
    test('poder obtener los datos de Hermione Granger', () async {
      final repo = CharacterRepoTest();
      final resultado = await repo.getCharacterWithName(
          characterName: 'Hermione Granger', apiDataProvider: dataProvider);
      resultado.match((l) {
        assert(false);
      }, (r) {
        expect(
            r,
            HPCharacter.constructor(
              nameProp: 'Hermione Granger',
              speciesProp: 'human',
              houseProp: 'Gryffindor',
              genderProp: 'female',
              dateOfBirthProp: '19-09-1979',
              ancestryProp: 'muggleborn',
              patronusProp: 'otter',
              wandProp: Barita(
                  wood: "vine", core: "dragon heartstring", length: null),
              hogwartsStudentProp: true,
              hogwartsStaffProp: false,
              imageUrl: 'https://hp-api.herokuapp.com/images/hermione.jpeg',
            ));
      });
    });
    test('url vacia de imagen hace que el campo sea null', () async {
      final repo = CharacterRepoTest();
      final resultado = await repo.getCharacterWithName(
          characterName: 'Victoire Weasley', apiDataProvider: dataProvider);
      resultado.match((l) {
        assert(false);
      }, (r) {
        expect(
            r,
            HPCharacter.constructor(
              nameProp: 'Victoire Weasley',
              speciesProp: 'human',
              houseProp: '',
              genderProp: 'female',
              dateOfBirthProp: '',
              ancestryProp: '',
              patronusProp: '',
              wandProp: Barita(wood: "", core: "", length: null),
              hogwartsStudentProp: true,
              hogwartsStaffProp: false,
              imageUrl: '',
            ));
      });
    });
    test(
        'poder obtener un HPCharacter desde un json que es un arreglo de objetos',
        () {
      var resultado = getDataFromList('''[{
    "name": "Harry Potter",
    "alternate_names": [],
    "species": "human",
    "gender": "male",
    "house": "Gryffindor",
    "dateOfBirth": "31-07-1980",
    "yearOfBirth": 1980,
    "wizard": true,
    "ancestry": "half-blood",
    "eyeColour": "green",
    "hairColour": "black",
    "wand": {
      "wood": "holly",
      "core": "phoenix feather",
      "length": 11
    },
    "patronus": "stag",
    "hogwartsStudent": true,
    "hogwartsStaff": false,
    "actor": "Daniel Radcliffe",
    "alternate_actors": [],
    "alive": true,
    "image": "https://hp-api.herokuapp.com/images/harry.jpg"
  }]''', 'Harry Potter');
      resultado.match(
        (l) {
          assert(false);
        },
        (r) {
          expect(
              r,
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
        },
      );
    });
  });
  group('getListData debe ', () {
    test('conseguir solo los nombres de los personajes', () {
      final resultado = getListData('''[{
    "name": "Harry Potter",
    "alternate_names": [],
    "species": "human",
    "gender": "male",
    "house": "Gryffindor",
    "dateOfBirth": "31-07-1980",
    "yearOfBirth": 1980,
    "wizard": true,
    "ancestry": "half-blood",
    "eyeColour": "green",
    "hairColour": "black",
    "wand": {
      "wood": "holly",
      "core": "phoenix feather",
      "length": 11
    },
    "patronus": "stag",
    "hogwartsStudent": true,
    "hogwartsStaff": false,
    "actor": "Daniel Radcliffe",
    "alternate_actors": [],
    "alive": true,
    "image": "https://hp-api.herokuapp.com/images/harry.jpg"
  },
  {
    "name": "Draco Malfoy",
    "alternate_names": [],
    "species": "human",
    "gender": "male",
    "house": "Slytherin",
    "dateOfBirth": "05-06-1980",
    "yearOfBirth": 1980,
    "wizard": true,
    "ancestry": "pure-blood",
    "eyeColour": "grey",
    "hairColour": "blonde",
    "wand": {
      "wood": "hawthorn",
      "core": "unicorn tail-hair",
      "length": 10
    },
    "patronus": "",
    "hogwartsStudent": true,
    "hogwartsStaff": false,
    "actor": "Tom Felton",
    "alternate_actors": [],
    "alive": true,
    "image": "https://hp-api.herokuapp.com/images/draco.jpg"
  }]''');
      resultado.match((l) {
        assert(false);
      }, (r) {
        expect(r, ['Harry Potter', 'Draco Malfoy']);
      });
    });
  });
  group('getCharacterCharacterWithCode debe ', () {
    test('debolver Albert Runcorn con el codigo: 289311629', () async {
      final repo = CharacterRepoTest();
      final resultado = await repo.getCharacterWithCode(
          characterCode: CodeInput.constructor('289311629'),
          apiDataProvider: dataProvider);
      resultado.match((l) {
        assert(false);
      }, (r) {
        expect(
            r,
            HPCharacter.constructor(
                nameProp: 'Albert Runcorn',
                speciesProp: 'human',
                genderProp: 'male',
                hogwartsStudentProp: false,
                hogwartsStaffProp: false,
                wandProp: Barita.vacia()));
      });
    });
    test('debolver error con el codigo: 289311', () async {
      final repo = CharacterRepoTest();
      final resultado = await repo.getCharacterWithCode(
          characterCode: CodeInput.constructor('289311'),
          apiDataProvider: dataProvider);
      resultado.match((l) {
        assert(false);
      }, (r) {
        expect(r, equals(null));
      });
    });
  });
  //estas pruebas son considerando la bd real
  group('datos del json deben cumplir con...', () {
    test('todos los personajes deben generar un hashcode distinto', () async {
      final repo = CharacterRepoTest();
      final dataList =
          await repo.getCharacterNameList(apiDataProvider: dataProvider);
      await dataList.match(
        (l) {
          assert(false);
        },
        (r) async {
          final getCharacers = r.map((e) async {
            final res = await repo.getCharacterWithName(
                characterName: e, apiDataProvider: dataProvider);
            return res.match((l) => left(l), (r) => right(r.hashCode));
          }).toList();
          final result = await Future.wait(getCharacers);
          expect(result.length, r.length);
          expect(false, result.any((element) => element.isLeft()));
        },
      );
    });
  });
}
