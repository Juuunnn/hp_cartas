import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterDataProvider/api_data_provider.dart';

const String testUrl = 'test';

void main() {
  group('character data obtainer getCharacterListFromAPI debe ', (() {
    test('tener largo de 403', () async {
      final obtainer =
          await ApiDataProviderTest(testUrl).getCharacterListFromAPI();
      obtainer.match((l) {
        assert(false);
      }, (r) {
        List<dynamic> characterList = jsonDecode(r);
        expect(characterList.length, 403);
      });
    });
    test('tirar error de malos datos ', () async {
      final obtainer = await ApiDataProviderTest(
              'test/feature/characterDataProvider/badJson')
          .getCharacterListFromAPI();
      obtainer.match((l) {
        expect(l, isA<InvalidDataRecived>());
      }, (r) {
        assert(false);
      });
    });
    test('tirar error de mala coneccion', () async {
      final obtainer =
          await ApiDataProviderTest('fdsa').getCharacterListFromAPI();
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
      final obtainer = await ApiDataProviderTest(testUrl).getSpellListFromAPI();
      obtainer.match((l) {
        assert(false);
      }, (r) {
        List<dynamic> characterList = jsonDecode(r);
        expect(characterList.length, 77);
      });
    });
    test('tirar error de malos datos ', () async {
      final obtainer = await ApiDataProviderTest(
              'test/feature/characterDataProvider/badJson')
          .getCharacterListFromAPI();
      obtainer.match((l) {
        expect(l, isA<InvalidDataRecived>());
      }, (r) {
        assert(false);
      });
    });
    test('tirar error de mala coneccion', () async {
      final obtainer =
          await ApiDataProviderTest('fdsa').getCharacterListFromAPI();
      obtainer.match((l) {
        expect(l, isA<BadAPIConection>());
      }, (r) {
        assert(false);
      });
    });
  }));
}
