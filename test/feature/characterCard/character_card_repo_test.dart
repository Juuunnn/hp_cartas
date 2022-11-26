import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';

void main() {
  group('character card repo deve', () {
    test('poder obtener los datos', () {
      final repo = CharacterCardRepoTest();
      final resultado = repo.getCharacterData(characterName: 'Harry Potter');
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
    test('poder obtener los datos', () {
      final repo = CharacterCardRepoTest();
      final resultado =
          repo.getCharacterData(characterName: 'Hermione Granger');
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
}
