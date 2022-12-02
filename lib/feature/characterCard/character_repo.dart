import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterDataProvider/api_data_provider.dart';

///Esta clase se encarga de extraer informacion de un json para generar HPCharacter
abstract class CharacterRepo {
  Future<Either<Problem, HPCharacter>> getCharacterWithName(
      {required String characterName,
      required ApiDataProvider apiDataProvider});
  Future<Either<Problem, List<String>>> getCharacterNameList(
      {required ApiDataProvider apiDataProvider});
  Future<Either<Problem, HPCharacter?>> getCharacterWithCode(
      {required CodeInput characterCode,
      required ApiDataProvider apiDataProvider});
}

class CharacterRepoTest extends CharacterRepo {
  @override
  Future<Either<Problem, HPCharacter>> getCharacterWithName(
      {required String characterName,
      required ApiDataProvider apiDataProvider}) async {
    final elJson = await apiDataProvider.getCharacterListFromAPI();
    return elJson.match(
      (l) => left(l),
      (r) => getDataFromList(r, characterName),
    );
  }

  @override
  Future<Either<Problem, List<String>>> getCharacterNameList(
      {required ApiDataProvider apiDataProvider}) async {
    final elJson = await apiDataProvider.getCharacterListFromAPI();
    return elJson.match(
      (l) => left(l),
      (r) => getListData(r),
    );
  }

  @override
  Future<Either<Problem, HPCharacter?>> getCharacterWithCode(
      {required CodeInput characterCode,
      required ApiDataProvider apiDataProvider}) async {
    final elJson = await apiDataProvider.getCharacterListFromAPI();
    return elJson.match(
        (l) => left(l),
        (json) => getListData(json).match(
              (l) => left(l),
              (r) {
                final resultado = r
                    .map((e) => getDataFromList(json, e)
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
              },
            ));
  }
}

Either<Problem, HPCharacter> getDataFromList(
    String ejJson, String characterName) {
  try {
    List<dynamic> listaCharacters = jsonDecode(ejJson);
    final resultado = listaCharacters.firstWhere(
      (element) => element["name"] == characterName && element["image"] != '',
    );

    return right(HPCharacter.fromMap(resultado));
  } catch (e) {
    return left(UnknownProblem(e.toString()));
  }
}

Either<Problem, List<String>> getListData(String ejJson) {
  try {
    List<dynamic> listaCharacters = jsonDecode(ejJson);
    final resultado = listaCharacters
        .filter((t) => t["image"] != '')
        .map((e) => e["name"].toString())
        .toList();
    return right(resultado.toSet().toList());
    // return right(resultado);
  } catch (e) {
    return left(UnknownProblem(e.toString()));
  }
}
