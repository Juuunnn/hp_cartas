// ignore: todo
//TODO: adminisrar personajes almacenados localmente y los obtenidos de la api
// states: new character unlocked, getting character,
//
//      finished:loading getting character list from api,  bad comunication, bad response format

// finished events: got character, got character list
// finished screens: character obtained view,

// obtener personaje de bd Local

import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/problem.dart';

abstract class CharacterDataProvider {
  // Future<Either<Problem, String>> getFromLocalDB(String file);
  Future<Either<ProblemDataParse, String>> getFromAPI(String url);
}

class CharacterDataObtainerTest extends CharacterDataProvider {
  @override
  Future<Either<ProblemDataParse, String>> getFromAPI(String url) async {
    late final String elJson;
    try {
      elJson = await File(url).readAsString();
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
