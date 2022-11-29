// ignore: todo
//TODO: adminisrar personajes almacenados localmente y los obtenidos de la api
// states: loading, new character unlocked, getting character, getting character list from api,
//
//      finished:  bad comunication, bad response format

// events: got character, got character list
// screens: character obtained view,

// obtener personaje de bd Local

// obtener personaje de api

// debe devolver el json en string

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
    try {
      List<dynamic> listaCharacters = jsonDecode(elJson);
    } catch (e) {
      return Future.value(left(InvalidDataRecived()));
    }
    return Future.value(right(elJson));
  }

  // @override
  // Future<Either<Problem, String>> getFromLocalDB(String file) {
  //   // TODO: implement getFromLocalDB
  //   throw UnimplementedError();
  // }
}
