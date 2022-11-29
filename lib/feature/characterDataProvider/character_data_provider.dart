// ignore: todo
//TODO: adminisrar personajes almacenados localmente y los obtenidos de la api
// states: loading, new character unlocked, getting character, getting character list from api, bad comunication, bad response format
// events: got character, got character list
// screens: character obtained view,

// obtener personaje de bd Local

// obtener personaje de api

// debe devolver el json en string

import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/problem.dart';

abstract class CharacterDataProvider {
  // Future<Either<Problem, String>> getFromLocalDB(String file);
  Future<Either<Problem, String>> getFromAPI(String url);
}

class CharacterDataObtainerTest extends CharacterDataProvider {
  @override
  Future<Either<Problem, String>> getFromAPI(String url) {
    // TODO: implement getFromAPI
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Problem, String>> getFromLocalDB(String file) {
  //   // TODO: implement getFromLocalDB
  //   throw UnimplementedError();
  // }
}
