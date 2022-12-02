import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:http/http.dart' as http;

abstract class ApiDataProvider {
  final String url;

  ApiDataProvider(this.url);
  // Future<Either<Problem, String>> getFromLocalDB(String file);
  Future<Either<ProblemDataParse, String>> getCharacterListFromAPI();
  Future<Either<ProblemDataParse, String>> getSpellListFromAPI();
}

class ApiDataProviderTest extends ApiDataProvider {
  ApiDataProviderTest(super.url);

  @override
  Future<Either<ProblemDataParse, String>> getCharacterListFromAPI() async {
    try {
      final String elJson = await File('$url/characters.json').readAsString();
      return Future.value(validateData(elJson));
    } catch (e) {
      return Future.value(left(BadAPIConection()));
    }
  }

  @override
  Future<Either<ProblemDataParse, String>> getSpellListFromAPI() async {
    try {
      final String elJson = await File('$url/spells.json').readAsString();
      return Future.value(validateData(elJson));
    } catch (e) {
      return Future.value(left(BadAPIConection()));
    }
  }
}

class ApiDataProviderReal extends ApiDataProvider {
  ApiDataProviderReal(super.url);

  @override
  Future<Either<ProblemDataParse, String>> getCharacterListFromAPI() async {
    Uri direccion = Uri.https(url, 'api/characters');

    try {
      final elJson = await http.get(direccion);
      if (elJson.statusCode != 200) {
        return left(BadAPIConection());
      }
      return Future.value(validateData(elJson.body));
    } catch (e) {
      return Future.value(left(BadAPIConection()));
    }
  }

  @override
  Future<Either<ProblemDataParse, String>> getSpellListFromAPI() async {
    Uri direccion = Uri.https(url, 'api/spells');

    try {
      final elJson = await http.get(direccion);
      if (elJson.statusCode != 200) {
        return left(BadAPIConection());
      }
      return Future.value(validateData(elJson.body));
    } catch (e) {
      return Future.value(left(BadAPIConection()));
    }
  }
}

Either<ProblemDataParse, String> validateData(String data) {
  try {
    List<dynamic> listaCharacters = jsonDecode(data);
    return right(data);
  } catch (e) {
    return left(InvalidDataRecived());
  }
}
