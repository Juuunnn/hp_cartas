import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterDataProvider/data_provider.dart';

const String testUrl = 'test/characters.json';
const String spellTestUrl = 'test/spells.json';

void main() {
  group('character data obtainer getCharacterListFromAPI debe ', (() {
    test('tener largo de 403', () async {
      final obtainer =
          await ApiDataProviderTest().getCharacterListFromAPI(testUrl);
      obtainer.match((l) {
        assert(false);
      }, (r) {
        List<dynamic> characterList = jsonDecode(r);
        expect(characterList.length, 403);
      });
    });
    test('tirar error de malos datos ', () async {
      final obtainer = await ApiDataProviderTest().getCharacterListFromAPI(
          'test/feature/characterDataProvider/badJson.txt');
      obtainer.match((l) {
        expect(l, isA<InvalidDataRecived>());
      }, (r) {
        assert(false);
      });
    });
    test('tirar error de mala coneccion', () async {
      final obtainer =
          await ApiDataProviderTest().getCharacterListFromAPI('fdsa');
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
  group('character data obtainer getSpellListFromAPI debe ', (() {
    test('tener largo de 77', () async {
      final obtainer =
          await ApiDataProviderTest().getSpellListFromAPI(spellTestUrl);
      obtainer.match((l) {
        assert(false);
      }, (r) {
        List<dynamic> characterList = jsonDecode(r);
        expect(characterList.length, 77);
      });
    });
    test('tirar error de malos datos ', () async {
      final obtainer = await ApiDataProviderTest().getCharacterListFromAPI(
          'test/feature/characterDataProvider/badJson.txt');
      obtainer.match((l) {
        expect(l, isA<InvalidDataRecived>());
      }, (r) {
        assert(false);
      });
    });
    test('tirar error de mala coneccion', () async {
      final obtainer =
          await ApiDataProviderTest().getCharacterListFromAPI('fdsa');
      obtainer.match((l) {
        expect(l, isA<BadAPIConection>());
      }, (r) {
        assert(false);
      });
    });
  }));
}
