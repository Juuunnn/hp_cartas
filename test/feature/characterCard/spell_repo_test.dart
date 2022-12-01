import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/feature/characterCard/spell_repo.dart';

final elJson = File('test/spells.json').readAsStringSync();
void main() {
  group('SpellRepo debe ', () {
    test('obtener lista completa de spell', () {
      SpellRepo repo = SpellRepoTest();
      final result = repo.getSpellList(elJson: elJson);
      result.match((l) {
        assert(false);
      }, (r) {
        expect(r.length, equals(77));
      });
    });
  });
}
