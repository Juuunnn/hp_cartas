import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/feature/characterDataProvider/character_data_provider.dart';

const String testUrl = '';
const String testFile = '';

void main() {
  group('character data obtainer getFromAPI debe ', (() {
    test('tener largo de 108', () async {
      final obtainer = await CharacterDataObtainerTest().getFromAPI(testUrl);
      obtainer.match((l) {
        assert(false);
      }, (r) {
        List<dynamic> characterList = jsonDecode(r);
        expect(characterList, 403);
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
