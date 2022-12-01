import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/problem.dart';

abstract class DataProvider {
  // Future<Either<Problem, String>> getFromLocalDB(String file);
  Future<Either<ProblemDataParse, String>> getCharacterListFromAPI(String url);
  Future<Either<ProblemDataParse, String>> getSpellListFromAPI(String url);
}

class DataProviderTest extends DataProvider {
  @override
  Future<Either<ProblemDataParse, String>> getCharacterListFromAPI(
      String url) async {
    late final String elJson;
    try {
      elJson = await File('$url/characters.json').readAsString();
    } catch (e) {
      return Future.value(left(BadAPIConection()));
    }
    return Future.value(validateData(elJson));
  }

  @override
  Future<Either<ProblemDataParse, String>> getSpellListFromAPI(
      String url) async {
    late final String elJson;
    try {
      elJson = await File('$url/spells.json').readAsString();
    } catch (e) {
      return Future.value(left(BadAPIConection()));
    }
    return Future.value(validateData(elJson));
  }

  // @override
  // Future<Either<Problem, String>> getFromLocalDB(String file) {
  //   // TODO: implement getFromLocalDB
  //   throw UnimplementedError();
  // }
}

Either<ProblemDataParse, String> validateData(String data) {
  try {
    List<dynamic> listaCharacters = jsonDecode(data);
  } catch (e) {
    return left(InvalidDataRecived());
  }
  return right(data);
}
