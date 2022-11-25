import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/problem.dart';

abstract class CharacterCardRepo {
  Either<Problem, HPCharacter> getCharacterData(
      {required String characterName});
  Either<Problem, HPCharacter> getCharacterList(
      {required String characterName});
}

class CharacterCardRepoTest extends CharacterCardRepo {
  @override
  Either<Problem, HPCharacter> getCharacterData(
      {required String characterName}) {
    final elJson = File('test/characters.json').readAsStringSync();
    return getDataFromList(elJson, characterName);
  }

  @override
  Either<Problem, HPCharacter> getCharacterList(
      {required String characterName}) {
    // TODO: implement getCharacterList
    throw UnimplementedError();
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
