import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterCard/character_repo.dart';

final elJson = File('test/characters.json').readAsStringSync();

void main() {
  group('character card repo deve', () {
    test('poder obtener los datos de Harry Potter', () {
      final repo = CharacterRepoTest();
      final resultado =
          repo.getCharacterData(characterName: 'Harry Potter', elJson: elJson);
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
    test('poder obtener los datos de Hermione Granger', () {
      final repo = CharacterRepoTest();
      final resultado = repo.getCharacterData(
          characterName: 'Hermione Granger', elJson: elJson);
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
    test('url vacia de imagen hace que el campo sea null', () {
      final repo = CharacterRepoTest();
      final resultado = repo.getCharacterData(
          characterName: 'Victoire Weasley', elJson: elJson);
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
    test('debolver Albert Runcorn con el codigo: 289311629', () {
      final repo = CharacterRepoTest();
      final resultado = repo.getCharacterWithCode(
          characterCode: CodeInput.constructor('289311629'), elJson: elJson);
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
    test('debolver error con el codigo: 289311', () {
      final repo = CharacterRepoTest();
      final resultado = repo.getCharacterWithCode(
          characterCode: CodeInput.constructor('289311'), elJson: elJson);
      resultado.match((l) {
        assert(false);
      }, (r) {
        expect(r, equals(null));
      });
    });
  });
  //estas pruebas son considerando la bd real
  group('datos del json deben cumplir con...', () {
    test('todos los personajes deben generar un hashcode distinto', () {
      final repo = CharacterRepoTest();
      final dataList = repo.getCharacterWithName(elJson: elJson);
      dataList.match(
        (l) {
          assert(false);
        },
        (r) {
          final result = r.map((e) {
            return repo
                .getCharacterData(characterName: e, elJson: elJson)
                .match((l) => left(l), (r) => right(r.hashCode));
          }).toSet();
          expect(result.length, r.length);
          expect(false, result.any((element) => element.isLeft()));
        },
      );
    });
  });
}
