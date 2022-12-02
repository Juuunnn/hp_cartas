import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/feature/characterCard/spell_repo.dart';
import 'package:hp_cartas/feature/characterDataProvider/api_data_provider.dart';

const elJson = 'test';
final ApiDataProvider dataProvider = ApiDataProviderTest(elJson);

void main() {
  group('SpellRepo debe ', () {
    test('obtener lista completa de spell', () async {
      SpellRepo repo = SpellRepoTest();
      final result = await repo.getSpellList(apiDataProvider: dataProvider);
      result.match((l) {
        assert(false);
      }, (r) {
        expect(r.length, equals(77));
      });
    });
  });
}
