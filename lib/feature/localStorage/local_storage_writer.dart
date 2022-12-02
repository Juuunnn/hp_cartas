import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/app_storage.dart';
import 'package:hp_cartas/domain/problem.dart';

class LocalStorageWriter {
  static void writeToLocalDB(AppStorage appData, String fileName) {
    File('$fileName.json').writeAsStringSync(appData.toJson());
  }

  static Either<Problem, AppStorage> readFromLocalDB(String fileName) {
    try {
      var readAsStringSync = File('$fileName.json').readAsStringSync();
      var appStorage = AppStorage.fromJson(readAsStringSync);
      return right(appStorage);
    } catch (e) {
      return left(NoDBFound());
    }
  }
}
