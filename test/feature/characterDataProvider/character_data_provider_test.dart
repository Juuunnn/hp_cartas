import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterDataProvider/character_data_provider.dart';

const String testUrl = 'test/characters.json';
const String testFile = '';

void main() {
  group('character data obtainer getFromAPI debe ', (() {
    test('tener largo de 108', () async {
      final obtainer = await CharacterDataObtainerTest().getFromAPI(testUrl);
      obtainer.match((l) {
        assert(false);
      }, (r) {
        List<dynamic> characterList = jsonDecode(r);
        expect(characterList.length, 403);
      });
    });
    test('tirar error de malos datos ', () async {
      final obtainer = await CharacterDataObtainerTest()
          .getFromAPI('test/feature/characterDataProvider/badJson.txt');
      obtainer.match((l) {
        expect(l, isA<InvalidDataRecived>());
      }, (r) {
        assert(false);
      });
    });
    test('tirar error de mala coneccion', () async {
      final obtainer = await CharacterDataObtainerTest().getFromAPI('fdsa');
      obtainer.match((l) {
        expect(l, isA<BadAPIConection>());
      }, (r) {
        assert(false);
      });
    });
  }));
  // group('character data obtainer getFromLocalDB debe ', (() {
  //   test('debovler Harry Potter', () async {
  //     final obtainer =
  //         await CharacterDataObtainerTest().getFromLocalDB(testFile);
  //     obtainer.match((l) {
  //       assert(false);
  //     }, (r) {
  //       assert(true);
  //     });
  //   });
  // }));
}
