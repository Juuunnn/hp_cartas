import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';

abstract class CharacterRepo {
  Either<Problem, HPCharacter> getCharacterData(
      {required String characterName, required String elJson});
  Either<Problem, List<String>> getCharacterWithName({required String elJson});
  Either<Problem, HPCharacter?> getCharacterWithCode(
      {required CodeInput characterCode, required String elJson});
}

class CharacterRepoTest extends CharacterRepo {
  @override
  Either<Problem, HPCharacter> getCharacterData(
      {required String characterName, required String elJson}) {
    return getDataFromList(elJson, characterName);
  }

  @override
  Either<Problem, List<String>> getCharacterWithName({required String elJson}) {
    return getListData(elJson);
  }

  @override
  Either<Problem, HPCharacter?> getCharacterWithCode(
      {required CodeInput characterCode, required String elJson}) {
    return getListData(elJson).match((l) => left(l), (r) {
      final resultado = r
          .map((e) => getCharacterData(characterName: e, elJson: elJson)
                  .match<Either<Problem, HPCharacter>>(
                (l) => left(l),
                (r) => right(r),
              ))
          .toList();
      try {
        final personaje = resultado.firstWhere(
            (Either<Problem, HPCharacter> element) =>
                element.getRight().toNullable().hashCode.toString() ==
                characterCode.searchCode);
        return personaje.match((l) => left(l), (r) => right(r));
      } catch (e) {
        return right(null);
      }
    });
  }
}

Either<Problem, HPCharacter> getDataFromList(
    String ejJson, String characterName) {
  try {
    List<dynamic> listaCharacters = jsonDecode(ejJson);
    final resultado = listaCharacters.firstWhere(
      (element) => element["name"] == characterName,
    );

    return right(HPCharacter.fromMap(resultado));
  } catch (e) {
    return left(UnknownProblem(e.toString()));
  }
}

Either<Problem, List<String>> getListData(String ejJson) {
  try {
    List<dynamic> listaCharacters = jsonDecode(ejJson);
    final resultado = listaCharacters.map((e) => e["name"].toString()).toList();
    return right(resultado.toSet().toList());
    // return right(resultado);
  } catch (e) {
    return left(UnknownProblem(e.toString()));
  }
}
