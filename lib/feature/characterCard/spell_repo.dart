import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/domain/spell.dart';

abstract class SpellRepo {
  Either<Problem, List<Spell>> getSpellList({required String elJson});
}

class SpellRepoTest extends SpellRepo {
  @override
  Either<Problem, List<Spell>> getSpellList({required String elJson}) {
    // TODO: implement getSpellList
    throw UnimplementedError();
  }
}
