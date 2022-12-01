import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/domain/spell.dart';

abstract class SpellRepo {
  Either<Problem, List<Spell>> getSpellList({required String elJson});
}

class SpellRepoTest extends SpellRepo {
  @override
  Either<Problem, List<Spell>> getSpellList({required String elJson}) {
    return getListData(elJson);
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


/* TODO: actividades a lograr

  Cambiar que cada repositorio se comunique con la direccion de la api que le corresponde
    obtener datos de un personaje sea de la direccion especifica de la api
    lista de nombres de la general
*/