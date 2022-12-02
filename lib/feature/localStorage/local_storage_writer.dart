import 'dart:convert';
import 'dart:io';

import 'package:hp_cartas/domain/app_storage.dart';

class LocalStorageWriter {
  static void writeToLocalDB(AppStorage appData, File db) {
    db.writeAsStringSync(appData.toJson());
  }

  static AppStorage readFromLocalDB(File db) {
    return AppStorage.fromJson(db.readAsStringSync());
  }
}
