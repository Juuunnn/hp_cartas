import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/domain/spell.dart';
import 'package:hp_cartas/feature/characterDataProvider/api_data_provider.dart';

abstract class SpellRepo {
  Future<Either<Problem, List<Spell>>> getSpellList(
      {required ApiDataProvider apiDataProvider});
}

class SpellRepoTest extends SpellRepo {
  @override
  Future<Either<Problem, List<Spell>>> getSpellList(
      {required ApiDataProvider apiDataProvider}) async {
    final elJson = await apiDataProvider.getSpellListFromAPI();
    return elJson.match(
      (l) => left(l),
      (r) => getListData(r),
    );
  }
}

Either<Problem, List<Spell>> getListData(String elJson) {
  try {
    List<dynamic> listaCharacters = jsonDecode(elJson);
    final resultado = listaCharacters.map((e) => Spell.fromMap(e));
    return right(resultado.toSet().toList());
    // return right(resultado);
  } catch (e) {
    return left(UnknownProblem(e.toString()));
  }
}
